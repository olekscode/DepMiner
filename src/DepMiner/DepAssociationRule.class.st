Class {
	#name : #DepAssociationRule,
	#superclass : #Object,
	#instVars : [
		'addedMethodCalls',
		'deletedMethodCalls',
		'count',
		'confidence',
		'lift',
		'methodChanges',
		'transformationRule'
	],
	#category : #'DepMiner-Models'
}

{ #category : #comparing }
DepAssociationRule >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject addedMethodCalls = addedMethodCalls and: [ 
		anObject deletedMethodCalls = deletedMethodCalls and: [ 
			anObject count = count and: [ 
				anObject confidence = confidence and: [ 
					anObject lift = lift and: [ 
						anObject methodChanges = methodChanges ] ] ] ] ]
]

{ #category : #accessing }
DepAssociationRule >> addedMethodCalls [
	^ addedMethodCalls
]

{ #category : #accessing }
DepAssociationRule >> addedMethodCalls: anObject [
	addedMethodCalls := anObject
]

{ #category : #accessing }
DepAssociationRule >> confidence [
	^ confidence
]

{ #category : #accessing }
DepAssociationRule >> confidence: anObject [
	confidence := anObject
]

{ #category : #accessing }
DepAssociationRule >> count [
	^ count
]

{ #category : #accessing }
DepAssociationRule >> count: anObject [
	count := anObject
]

{ #category : #accessing }
DepAssociationRule >> deletedMethodCalls [
	^ deletedMethodCalls
]

{ #category : #accessing }
DepAssociationRule >> deletedMethodCalls: anObject [
	deletedMethodCalls := anObject
]

{ #category : #'as yet unclassified' }
DepAssociationRule >> generateDeprecationFor: aMethod [
	^ 'self
		deprecated: ''Use #', addedMethodCalls anyOne selector, ' instead''
		transformWith: ''', transformationRule antecedent, ''' -> ''', transformationRule consequent, '''.' 
]

{ #category : #'as yet unclassified' }
DepAssociationRule >> generateTransformationRule [
	| deletedSelector addedSelector |
	
	deletedSelector := deletedMethodCalls anyOne selector.
	addedSelector := addedMethodCalls anyOne selector.
	
	transformationRule := TransformationRule
		antecedent: (self transformationRuleExpressionFor: deletedSelector)
		consequent: (self transformationRuleExpressionFor: addedSelector).
]

{ #category : #accessing }
DepAssociationRule >> hasTransformationRule [
	^ transformationRule isNotNil
]

{ #category : #comparing }
DepAssociationRule >> hash [
	| fields |
	fields := { addedMethodCalls . deletedMethodCalls . count . confidence . lift . methodChanges }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #testing }
DepAssociationRule >> isAutomatable [
	"An association rule is automatable if we can use it to generate a transformation rule without any human intervention. This is only possible for one-to-one rules where the deleted and the added method call have the same number of arguments"
	| deletedSelector addedSelector |
	
	(deletedMethodCalls size = 1 and: [ addedMethodCalls size = 1 ])
		ifFalse: [ ^ false ].
		
	deletedSelector := deletedMethodCalls anyOne selector.
	addedSelector := addedMethodCalls anyOne selector.
	
	^ (self numberOfArgumentsFor: deletedSelector) = (self numberOfArgumentsFor: addedSelector)
		
	
]

{ #category : #testing }
DepAssociationRule >> isRelevant [
	"Only one-to-one and one-to-many rules can be used in deprecations"
	^ deletedMethodCalls size = 1
]

{ #category : #accessing }
DepAssociationRule >> lift [
	^ lift
]

{ #category : #accessing }
DepAssociationRule >> lift: anObject [
	lift := anObject
]

{ #category : #accessing }
DepAssociationRule >> methodChanges [
	^ methodChanges
]

{ #category : #accessing }
DepAssociationRule >> methodChanges: anObject [
	methodChanges := anObject
]

{ #category : #'as yet unclassified' }
DepAssociationRule >> numberOfArgumentsFor: aSelector [
	^ (aSelector anySatisfy: [ :char | char isAlphaNumeric or: [ char = $: ] ])
		ifTrue: [ aSelector occurrencesOf: $: ] "not an operator"
		ifFalse: [ 1 ]. "an operator"
]

{ #category : #printing }
DepAssociationRule >> printOn: aStream [
	aStream 
		nextPut: ${;
		nextPutAll: (', ' join: deletedMethodCalls);
		nextPutAll: '} => {';
		nextPutAll: (', ' join: addedMethodCalls);
		nextPut: $}
]

{ #category : #'as yet unclassified' }
DepAssociationRule >> snapshotOfSourceCodeWithGeneratedDeprecationFor: aMethod [
	| newAst |
	newAst := aMethod ast copy.
	newAst statements:
		(aMethod ast statements copyWithFirst:
			(RBParser parseExpression: (self generateDeprecationFor: aMethod))).
	^ newAst formattedCode
]

{ #category : #accessing }
DepAssociationRule >> transformationRule [
	^ transformationRule
]

{ #category : #accessing }
DepAssociationRule >> transformationRule: anObject [
	transformationRule := anObject
]

{ #category : #'as yet unclassified' }
DepAssociationRule >> transformationRuleExpressionFor: aSelector [
	| numberOfArguments |
	numberOfArguments := self numberOfArgumentsFor: aSelector.

	numberOfArguments = 0
		ifTrue: [ ^ '`@rec ', aSelector ].
	
	numberOfArguments = 1
		ifTrue: [ ^ '`@rec ', aSelector, ' `@arg' ].
	
	^ '`@rec ', (' ' join: (((aSelector splitOn: $:) copyFrom: 1 to: numberOfArguments) withIndexCollect: [ :selectorPart :i | selectorPart, ': `@arg', i asString ])).
]
