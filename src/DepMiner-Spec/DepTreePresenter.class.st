Class {
	#name : #DepTreePresenter,
	#superclass : #SpTreePresenter,
	#instVars : [
		'actionOnLeafClicked',
		'actionOnTreeClicked'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #accessing }
DepTreePresenter >> actionOnLeafClicked: aBlock [
	actionOnLeafClicked := aBlock
]

{ #category : #accessing }
DepTreePresenter >> actionOnTreeClicked: aBlock [
	actionOnTreeClicked := aBlock
]

{ #category : #'as yet unclassified' }
DepTreePresenter >> buildTreesFrom: aCollectionOfItems [
	| packages method packageTrees packageTree classTree |
	
	packages := Dictionary new.
	
	"First we build a tree-like structure using dictionaries"
	aCollectionOfItems do: [ :item |
		method := self methodToDisplayFor: item.
		
		((packages at: method packageName ifAbsentPut: [ Dictionary new ])
			at: method className ifAbsentPut: [ OrderedCollection new ])
				add: item ].
			
	"Then we create an actual tree"
	packageTrees := SortedCollection sortBlock: [ :a :b | a name < b name ].
	
	packages keysAndValuesDo: [ :packageName :classesDictionary |
		packageTree := DepTreeModel new
			name: packageName;
			iconName: #package;
			yourself.
			
		classesDictionary keysAndValuesDo: [ :className :methods |
			classTree := DepTreeModel new
				name: (self classNameToDisplayFor: className);
				iconName: #class;
				yourself.
				
			methods do: [ :item |
				classTree addChild: (DepTreeLeafModel new
					name: item name;
					value: item;
					iconName: #method;
					yourself) ].
			
			packageTree addChild: classTree ].
		packageTrees add: packageTree ].

	^ packageTrees
]

{ #category : #'as yet unclassified' }
DepTreePresenter >> classNameToDisplayFor: aClassName [
	self subclassResponsibility
]

{ #category : #initialization }
DepTreePresenter >> initialize [
	super initialize.
	
	actionOnLeafClicked := [ :method | "do nothing" ].
	actionOnTreeClicked := [ :packageOrClass | "do nothing" ].
	
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
DepTreePresenter >> items: aCollectionOfItems [
	self roots: (self buildTreesFrom: aCollectionOfItems)
]

{ #category : #'as yet unclassified' }
DepTreePresenter >> methodToDisplayFor: anItem [
	self subclassResponsibility
]

{ #category : #events }
DepTreePresenter >> onItemClicked: anItem [
	anItem ifNotNil: [ anItem receiveClickActionFrom: self ]
]

{ #category : #events }
DepTreePresenter >> onLeafClicked: aMethod [
	actionOnLeafClicked value: aMethod 
]

{ #category : #events }
DepTreePresenter >> onTreeClicked: aPackageOrClass [
	actionOnTreeClicked value: aPackageOrClass
]
