Class {
	#name : #MrRule,
	#superclass : #Object,
	#instVars : [
		'addedMethodCalls',
		'deletedMethodCalls',
		'count',
		'confidence',
		'lift',
		'methodChanges'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #comparing }
MrRule >> = anObject [
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
MrRule >> addedMethodCalls [
	^ addedMethodCalls
]

{ #category : #accessing }
MrRule >> addedMethodCalls: anObject [
	addedMethodCalls := anObject
]

{ #category : #accessing }
MrRule >> confidence [
	^ confidence
]

{ #category : #accessing }
MrRule >> confidence: anObject [
	confidence := anObject
]

{ #category : #accessing }
MrRule >> count [
	^ count
]

{ #category : #accessing }
MrRule >> count: anObject [
	count := anObject
]

{ #category : #accessing }
MrRule >> deletedMethodCalls [
	^ deletedMethodCalls
]

{ #category : #accessing }
MrRule >> deletedMethodCalls: anObject [
	deletedMethodCalls := anObject
]

{ #category : #comparing }
MrRule >> hash [
	| fields |
	fields := { addedMethodCalls . deletedMethodCalls . count . confidence . lift . methodChanges }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #accessing }
MrRule >> lift [
	^ lift
]

{ #category : #accessing }
MrRule >> lift: anObject [
	lift := anObject
]

{ #category : #accessing }
MrRule >> methodChanges [
	^ methodChanges
]

{ #category : #accessing }
MrRule >> methodChanges: anObject [
	methodChanges := anObject
]
