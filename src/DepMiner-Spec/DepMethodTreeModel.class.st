Class {
	#name : #DepMethodTreeModel,
	#superclass : #Object,
	#instVars : [
		'iconName',
		'children',
		'name'
	],
	#category : #'DepMiner-Spec-ViewModels'
}

{ #category : #comparing }
DepMethodTreeModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #adding }
DepMethodTreeModel >> addChild: aTree [
	children add: aTree
]

{ #category : #accessing }
DepMethodTreeModel >> children [
	^ children
]

{ #category : #comparing }
DepMethodTreeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
DepMethodTreeModel >> iconName [
	^ iconName
]

{ #category : #accessing }
DepMethodTreeModel >> iconName: anObject [
	iconName := anObject
]

{ #category : #initialization }
DepMethodTreeModel >> initialize [
	super initialize.
	children := SortedCollection sortBlock: [ :a :b | a name < b name ].
]

{ #category : #accessing }
DepMethodTreeModel >> name [
	^ name
]

{ #category : #accessing }
DepMethodTreeModel >> name: anObject [
	name := anObject
]

{ #category : #private }
DepMethodTreeModel >> numberOfMethods [
	^ children inject: 0 into: [ :sum :each | sum + each numberOfMethods ]
]

{ #category : #accessing }
DepMethodTreeModel >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPut: $(;
		nextPutAll: self numberOfMethods asString;
		nextPut: $).
]

{ #category : #'as yet unclassified' }
DepMethodTreeModel >> receiveClickActionFrom: aView [
	aView onPackageOrClassClicked: self valueToInspect
]

{ #category : #'as yet unclassified' }
DepMethodTreeModel >> valueToInspect [
	^ children collect: [ :child | child valueToInspect ]
]
