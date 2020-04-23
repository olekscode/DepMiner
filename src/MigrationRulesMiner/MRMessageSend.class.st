Class {
	#name : #MRMessageSend,
	#superclass : #Object,
	#instVars : [
		'astNode',
		'isAdded',
		'isDeleted',
		'sender'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRMessageSend >> astNode: aNode [
	astNode := aNode
]

{ #category : #initialization }
MRMessageSend >> initialize [ 
	super initialize.
	isAdded := false.
	isDeleted := false.
]

{ #category : #accessing }
MRMessageSend >> isAdded [
	^ isAdded
]

{ #category : #accessing }
MRMessageSend >> isAdded: aBoolean [
	isAdded := aBoolean
]

{ #category : #accessing }
MRMessageSend >> isDeleted [
	^ isDeleted
]

{ #category : #accessing }
MRMessageSend >> isDeleted: aBoolean [
	isDeleted := aBoolean
]

{ #category : #printing }
MRMessageSend >> printOn: aStream [
	| prefix |
	
	prefix := self isAdded
		ifTrue: [ 'added-send' ]
		ifFalse: [ 
			self isDeleted
				ifTrue: [ 'deleted-send' ]
				ifFalse: [ 'not-changed-send' ] ].
	
	aStream 
		nextPutAll: prefix;
		nextPut: $(;
		nextPutAll: self selector;
		nextPut: $).
]

{ #category : #accessing }
MRMessageSend >> selector [ 
	^ astNode selector
]

{ #category : #accessing }
MRMessageSend >> sender [
	^ sender
]

{ #category : #accessing }
MRMessageSend >> sender: anObject [
	sender := anObject
]
