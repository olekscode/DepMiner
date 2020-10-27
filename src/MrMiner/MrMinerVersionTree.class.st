Class {
	#name : #MrMinerVersionTree,
	#superclass : #Object,
	#instVars : [
		'iconName',
		'children',
		'name'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
MrMinerVersionTree >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #adding }
MrMinerVersionTree >> addChild: aTree [
	children add: aTree
]

{ #category : #accessing }
MrMinerVersionTree >> children [
	^ children
]

{ #category : #comparing }
MrMinerVersionTree >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
MrMinerVersionTree >> iconName [
	^ iconName
]

{ #category : #accessing }
MrMinerVersionTree >> iconName: anObject [
	iconName := anObject
]

{ #category : #initialization }
MrMinerVersionTree >> initialize [
	super initialize.
	children := Set new.
]

{ #category : #accessing }
MrMinerVersionTree >> name [
	^ name
]

{ #category : #accessing }
MrMinerVersionTree >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MrMinerVersionTree >> printOn: aStream [
	aStream nextPutAll: name
]
