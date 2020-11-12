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
		'feedback'
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

{ #category : #accessing }
DepAssociationRule >> feedback [
	^ feedback
]

{ #category : #accessing }
DepAssociationRule >> feedback: anObject [
	feedback := anObject
]

{ #category : #testing }
DepAssociationRule >> hasFeedback [
	^ feedback isNotNil
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
	self subclassResponsibility
]

{ #category : #testing }
DepAssociationRule >> isBad [
	^ self hasFeedback and: [ feedback isGood = 'No' ]
]

{ #category : #testing }
DepAssociationRule >> isGood [
	^ self hasFeedback and: [ feedback isGood = 'Yes' ]
]

{ #category : #testing }
DepAssociationRule >> isUncertain [
	^ self hasFeedback and: [ feedback isGood = 'Not sure' ]
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

{ #category : #printing }
DepAssociationRule >> printOn: aStream [
	aStream 
		nextPut: ${;
		nextPutAll: (', ' join: deletedMethodCalls);
		nextPutAll: '} => {';
		nextPutAll: (', ' join: addedMethodCalls);
		nextPut: $}
]
