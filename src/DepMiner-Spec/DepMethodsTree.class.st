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
	| classes methodTree |
		
	classes := aCollectionOfClioMethods collect: [ :method |
		DepMethodTreeModel new
			name: method className;
			iconName: #class;
			yourself ].
		
	classes := classes asSet asArray sorted: [ :a :b | a name < b name ].
		
	aCollectionOfClioMethods do: [ :method |
		methodTree := DepMethodTreeLeafModel new
			name: method selector;
			value: method;
			iconName: #method;
			yourself.
			
		classes
			detect: [ :aClass | aClass name = method className ]
			ifFound: [ :aClass | aClass addChild: methodTree ] ].
		
	^ classes
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
