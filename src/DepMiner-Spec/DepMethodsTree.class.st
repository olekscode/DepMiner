Class {
	#name : #DepMethodsTree,
	#superclass : #SpTreePresenter,
	#instVars : [
		'actionOnMethodClicked',
		'actionOnPackageOrClassClicked'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #accessing }
DepMethodsTree >> actionOnMethodClicked: aBlock [
	actionOnMethodClicked := aBlock
]

{ #category : #accessing }
DepMethodsTree >> actionOnPackageOrClassClicked: aBlock [
	actionOnPackageOrClassClicked := aBlock
]

{ #category : #initialization }
DepMethodsTree >> initialize [
	super initialize.
	
	actionOnMethodClicked := [ :method | "do nothing" ].
	actionOnPackageOrClassClicked := [ :packageOrClass | "do nothing" ].

	self
		children: [ :each | each children ];
		display: [ :each | each asString ];
		displayIcon: [ :each | self iconNamed: each iconName ];
		whenSelectionChangedDo: [ self onItemClicked: self selectedItem ].
		
	self contextMenu: [
		SpMenuPresenter new 
			addGroup: [ :group | group 
				addItem: [ :item | item
					name: 'Inspect';
					action: [ self selectedItem valueToInspect inspect ] ] ] ].
]

{ #category : #accessing }
DepMethodsTree >> methods: aCollectionOfMethods [
	self roots: (self methodsToVersionTrees: aCollectionOfMethods)
]

{ #category : #'as yet unclassified' }
DepMethodsTree >> methodsToVersionTrees: aCollectionOfClioMethods [
	| packages packageTrees packageTree classTree |
	
	packages := Dictionary new.
	
	"First we build a tree-like structure using dictionaries"
	aCollectionOfClioMethods do: [ :method |
		((packages at: method packageName ifAbsentPut: [ Dictionary new ])
			at: method className ifAbsentPut: [ OrderedCollection new ])
				add: method ].
			
	"Then we create an actual tree"
	packageTrees := SortedCollection sortBlock: [ :a :b | a name < b name ].
	
	packages keysAndValuesDo: [ :packageName :classesDictionary |
		packageTree := DepMethodTreeModel new
			name: packageName;
			iconName: #package;
			yourself.
			
		classesDictionary keysAndValuesDo: [ :className :methods |
			classTree := DepMethodTreeModel new
				name: className;
				iconName: #class;
				yourself.
				
			methods do: [ :method |
				classTree addChild: (DepMethodTreeLeafModel new
					name: method selector;
					value: method;
					iconName: #method;
					yourself) ].
			
			packageTree addChild: classTree ].
		packageTrees add: packageTree ].

	^ packageTrees
]

{ #category : #events }
DepMethodsTree >> onItemClicked: anItem [
	anItem ifNotNil: [ anItem receiveClickActionFrom: self ]
]

{ #category : #events }
DepMethodsTree >> onMethodClicked: aMethod [
	actionOnMethodClicked value: aMethod 
]

{ #category : #events }
DepMethodsTree >> onPackageOrClassClicked: aPackageOrClass [
	actionOnPackageOrClassClicked value: aPackageOrClass
]
