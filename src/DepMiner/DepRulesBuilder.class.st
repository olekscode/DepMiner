Class {
	#name : #DepRulesBuilder,
	#superclass : #Object,
	#category : #'DepMiner-Controllers'
}

{ #category : #'as yet unclassified' }
DepRulesBuilder >> buildMigrationRulesFromAssociationRules: aCollectionOfAssociationRules [
	| rule |
	
	^ aCollectionOfAssociationRules collect: [ :associationRule |
		rule := (self canBeAutomated: associationRule)
			ifFalse: [ 
				DepNonAutomatableRule new ]
			ifTrue: [
				DepAutomatableRule new
					transformationRule: (self transformationRuleFor: associationRule);
					yourself ].
			
		rule
			deletedMethodCalls: associationRule key asSet;
			addedMethodCalls: associationRule value asSet;
			count: associationRule count;
			confidence: associationRule confidence;
			lift: associationRule lift.
			
		rule ].
]

{ #category : #testing }
DepRulesBuilder >> canBeAutomated: anAssociationRule [
	| numberOfArgumentsInDeletedMethod numberOfArgumentsInAddedMethod | 
	
	"Only one-to-one rules can be automated"
	((anAssociationRule key size = 1) and: [ anAssociationRule value size = 1 ])
		ifFalse: [ ^ false ].
		
	numberOfArgumentsInDeletedMethod := self numberOfArgumentsFor: anAssociationRule key anyOne selector.
	numberOfArgumentsInAddedMethod := self numberOfArgumentsFor: anAssociationRule value anyOne selector.
	
	^ numberOfArgumentsInDeletedMethod = numberOfArgumentsInAddedMethod
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

{ #category : #'as yet unclassified' }
DepRulesBuilder >> transformationRuleFor: anAssociationRule [
	| deletedSelector addedSelector |
	
	deletedSelector := anAssociationRule key anyOne selector.
	addedSelector := anAssociationRule value anyOne selector.
	
	^ TransformationRule
		antecedent: (self transformationRuleExpressionFor: deletedSelector)
		consequent: (self transformationRuleExpressionFor: addedSelector).
]
