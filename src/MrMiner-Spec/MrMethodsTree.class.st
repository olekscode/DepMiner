Class {
	#name : #MrMethodsTree,
	#superclass : #SpTreePresenter,
	#instVars : [
		'actionOnMethodClicked',
		'actionOnPackageOrClassClicked'
	],
	#category : #'MrMiner-Spec-NewViews'
}

{ #category : #accessing }
MrMethodsTree >> actionOnMethodClicked: aBlock [
	actionOnMethodClicked := aBlock
]

{ #category : #accessing }
MrMethodsTree >> actionOnPackageOrClassClicked: aBlock [
	actionOnPackageOrClassClicked := aBlock
]

{ #category : #initialization }
MrMethodsTree >> initialize [
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
MrMethodsTree >> methods: aCollectionOfMethods [
	self roots: (self methodsToVersionTrees: aCollectionOfMethods)
]

{ #category : #'as yet unclassified' }
MrMethodsTree >> methodsToVersionTrees: aCollectionOfClioMethods [
	| classes methodTree |
		
	classes := aCollectionOfClioMethods collect: [ :method |
		MrMethodTreeModel new
			name: method className;
			iconName: #class;
			yourself ].
		
	classes := classes asSet asArray sorted: [ :a :b | a name < b name ].
		
	aCollectionOfClioMethods do: [ :method |
		methodTree := MrMethodTreeLeafModel new
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
MrMethodsTree >> onItemClicked: anItem [
	anItem ifNotNil: [ anItem receiveClickActionFrom: self ]
]

{ #category : #events }
MrMethodsTree >> onMethodClicked: aMethod [
	actionOnMethodClicked value: aMethod 
]

{ #category : #events }
MrMethodsTree >> onPackageOrClassClicked: aPackageOrClass [
	actionOnPackageOrClassClicked value: aPackageOrClass
]
