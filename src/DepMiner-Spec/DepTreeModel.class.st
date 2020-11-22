Class {
	#name : #DepTreeModel,
	#superclass : #Object,
	#instVars : [
		'iconName',
		'children',
		'name'
	],
	#category : #'DepMiner-Spec-ViewModels'
}

{ #category : #comparing }
DepTreeModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #adding }
DepTreeModel >> addChild: aTree [
	children add: aTree
]

{ #category : #accessing }
DepTreeModel >> children [
	^ children
]

{ #category : #comparing }
DepTreeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
DepTreeModel >> iconName [
	^ iconName
]

{ #category : #accessing }
DepTreeModel >> iconName: anObject [
	iconName := anObject
]

{ #category : #initialization }
DepTreeModel >> initialize [
	super initialize.
	children := SortedCollection sortBlock: [ :a :b | a name < b name ].
]

{ #category : #accessing }
DepTreeModel >> name [
	^ name
]

{ #category : #accessing }
DepTreeModel >> name: anObject [
	name := anObject
]

{ #category : #private }
DepTreeModel >> numberOfLeaves [
	^ children inject: 0 into: [ :sum :each | sum + each numberOfLeaves ]
]

{ #category : #accessing }
DepTreeModel >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPut: $(;
		nextPutAll: self numberOfLeaves asString;
		nextPut: $).
]

{ #category : #'as yet unclassified' }
DepTreeModel >> receiveClickActionFrom: aView [
	aView onTreeClicked: self valueToInspect
]

{ #category : #'as yet unclassified' }
DepTreeModel >> valueToInspect [
	^ children collect: [ :child | child valueToInspect ]
]
