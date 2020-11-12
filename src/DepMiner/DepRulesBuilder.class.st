Class {
	#name : #DepRulesBuilder,
	#superclass : #Object,
	#category : #'DepMiner-Controllers'
}

{ #category : #testing }
DepRulesBuilder >> canGenerateTransformationRuleFrom: anAssociationRule [

	| deletedSelector addedSelector |
	
	"Only one-to-one rules can be automated"
	(anAssociationRule deletedMethodCalls size = 1 and: [ 
		 anAssociationRule addedMethodCalls size = 1 ]) ifFalse: [ ^ false ].
	
	deletedSelector := anAssociationRule deletedMethodCalls anyOne selector.
	addedSelector := anAssociationRule addedMethodCalls anyOne selector.

	^ (self numberOfArgumentsFor: deletedSelector) = (self numberOfArgumentsFor: addedSelector)
]

{ #category : #'as yet unclassified' }
DepRulesBuilder >> generateTransformationRuleFrom: anAssociationRule [
	| deletedSelector addedSelector |
	
	deletedSelector := anAssociationRule deletedMethodCalls anyOne selector.
	addedSelector := anAssociationRule addedMethodCalls anyOne selector.
	
	^ TransformationRule
		antecedent: (self transformationRuleExpressionFor: deletedSelector)
		consequent: (self transformationRuleExpressionFor: addedSelector).
]

{ #category : #'as yet unclassified' }
DepRulesBuilder >> mapRules: aCollectionOfRules toMethodChanges: aCollectionOfMethodChanges [
	aCollectionOfRules do: [ :rule |
		rule methodChanges: (aCollectionOfMethodChanges select: [ :methodChange |
			(methodChange deletedEntities asArray includesAll: rule deletedMethodCalls) and: [ 
				methodChange addedEntities asArray includesAll: rule addedMethodCalls ] ]) ]
]

{ #category : #'as yet unclassified' }
DepRulesBuilder >> numberOfArgumentsFor: aSelector [
	^ (aSelector anySatisfy: [ :char | char isAlphaNumeric or: [ char = $: ] ])
		ifTrue: [ aSelector occurrencesOf: $: ] "not an operator"
		ifFalse: [ 1 ]. "an operator"
]

{ #category : #'as yet unclassified' }
DepRulesBuilder >> transformationRuleExpressionFor: aSelector [
	| numberOfArguments |
	numberOfArguments := self numberOfArgumentsFor: aSelector.

	numberOfArguments = 0
		ifTrue: [ ^ '`@rec ', aSelector ].
	
	numberOfArguments = 1
		ifTrue: [ ^ '`@rec ', aSelector, '`@arg' ].
	
	^ '`@rec ', (' ' join: (((aSelector splitOn: $:) copyFrom: 1 to: numberOfArguments) withIndexCollect: [ :selectorPart :i | selectorPart, ': `@arg', i asString ])).
]
