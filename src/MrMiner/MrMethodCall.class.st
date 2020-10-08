Class {
	#name : #MrMethodCall,
	#superclass : #Object,
	#instVars : [
		'selector',
		'isAdded'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
MrMethodCall >> < anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ selector < anObject selector
]

{ #category : #comparing }
MrMethodCall >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject selector = selector and: [
		anObject isAdded = isAdded ]
]

{ #category : #comparing }
MrMethodCall >> hash [ 
	^ selector hash bitXor: isAdded hash
]

{ #category : #accessing }
MrMethodCall >> isAdded [
	^ isAdded
]

{ #category : #accessing }
MrMethodCall >> isDeleted [
	^ isAdded not
]

{ #category : #accessing }
MrMethodCall >> makeAdded [
	isAdded := true
]

{ #category : #accessing }
MrMethodCall >> makeDeleted [
	isAdded := false
]

{ #category : #printing }
MrMethodCall >> printOn: aStream [
	aStream nextPutAll: selector.
]

{ #category : #accessing }
MrMethodCall >> selector [
	^ selector
]

{ #category : #accessing }
MrMethodCall >> selector: anObject [
	selector := anObject
]
