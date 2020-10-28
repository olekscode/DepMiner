Class {
	#name : #MrMethodsTree,
	#superclass : #SpTreePresenter,
	#category : #'MrMiner-Spec-NewViews'
}

{ #category : #initialization }
MrMethodsTree >> initialize [
	super initialize.

	self
		children: [ :each | each children ];
		display: [ :each | each asString ];
		displayIcon: [ :each | self iconNamed: each iconName ].
		
	self contextMenu: [
		SpMenuPresenter new 
			addGroup: [ :group | group 
				addItem: [ :item | item
					name: 'Inspect';
					action: [ self selectedItem inspect ] ] ] ].
]

{ #category : #accessing }
MrMethodsTree >> packages: aCollectionOfPackageTrees [
	self roots: aCollectionOfPackageTrees
]
