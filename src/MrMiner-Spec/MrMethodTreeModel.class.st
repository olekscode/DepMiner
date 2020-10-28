Class {
	#name : #MrMethodTreeModel,
	#superclass : #Object,
	#instVars : [
		'iconName',
		'children',
		'name'
	],
	#category : #'MrMiner-Spec-ViewModels'
}

{ #category : #comparing }
MrMethodTreeModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #adding }
MrMethodTreeModel >> addChild: aTree [
	children add: aTree
]

{ #category : #accessing }
MrMethodTreeModel >> children [
	^ children
]

{ #category : #comparing }
MrMethodTreeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
MrMethodTreeModel >> iconName [
	^ iconName
]

{ #category : #accessing }
MrMethodTreeModel >> iconName: anObject [
	iconName := anObject
]

{ #category : #initialization }
MrMethodTreeModel >> initialize [
	super initialize.
	children := Set new.
]

{ #category : #accessing }
MrMethodTreeModel >> name [
	^ name
]

{ #category : #accessing }
MrMethodTreeModel >> name: anObject [
	name := anObject
]

{ #category : #private }
MrMethodTreeModel >> numberOfMethods [
	^ children inject: 0 into: [ :sum :each | sum + each numberOfMethods ]
]

{ #category : #accessing }
MrMethodTreeModel >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPut: $(;
		nextPutAll: self numberOfMethods asString;
		nextPut: $).
]
