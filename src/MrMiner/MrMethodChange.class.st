Class {
	#name : #MrMethodChange,
	#superclass : #Object,
	#instVars : [
		'method',
		'commit',
		'oldSourceCode',
		'newSourceCode',
		'addedMethodCalls',
		'deletedMethodCalls'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
MrMethodChange >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject method = method and: [ 
		anObject commit = commit and: [ 
			anObject oldSourceCode = oldSourceCode and: [ 
				anObject newSourceCode = newSourceCode and: [ 
					anObject addedMethodCalls = addedMethodCalls and: [ 
						anObject deletedMethodCalls = deletedMethodCalls ] ] ] ] ]
]

{ #category : #accessing }
MrMethodChange >> addedMethodCalls [
	^ addedMethodCalls
]

{ #category : #accessing }
MrMethodChange >> addedMethodCalls: anObject [
	addedMethodCalls := anObject
]

{ #category : #accessing }
MrMethodChange >> commit [
	^ commit
]

{ #category : #accessing }
MrMethodChange >> commit: anObject [
	commit := anObject
]

{ #category : #accessing }
MrMethodChange >> deletedMethodCalls [
	^ deletedMethodCalls
]

{ #category : #accessing }
MrMethodChange >> deletedMethodCalls: anObject [
	deletedMethodCalls := anObject
]

{ #category : #comparing }
MrMethodChange >> hash [
	| fields |
	fields := { method . commit . oldSourceCode . newSourceCode . addedMethodCalls . deletedMethodCalls }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #accessing }
MrMethodChange >> method [
	^ method
]

{ #category : #accessing }
MrMethodChange >> method: anObject [
	method := anObject
]

{ #category : #accessing }
MrMethodChange >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
MrMethodChange >> newSourceCode: anObject [
	newSourceCode := anObject
]

{ #category : #accessing }
MrMethodChange >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
MrMethodChange >> oldSourceCode: anObject [
	oldSourceCode := anObject
]
