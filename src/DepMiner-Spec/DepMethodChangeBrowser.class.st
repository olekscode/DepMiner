Class {
	#name : #DepMethodChangeBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'methodChangeTable',
		'oldCode',
		'newCode'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepMethodChangeBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		add: #methodChangeTable;
		add: (SpBoxLayout newHorizontal
			spacing: 3;
			add: (SpBoxLayout newVertical
				add: 'Old source code' height: self labelHeight;
				add: #oldCode;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'New source code' height: self labelHeight;
				add: #newCode;
				yourself);
			yourself);
		yourself.
]

{ #category : #specs }
DepMethodChangeBrowser class >> preferredExtent [
	^ 1200@600
]

{ #category : #initialization }
DepMethodChangeBrowser >> connectPresenters [
	super connectPresenters.
	
	methodChangeTable whenSelectionChangedDo: [ :selectionMode |
		self showMethodChange: methodChangeTable selectedItem ].
	
	methodChangeTable contextMenu: [
		SpMenuPresenter new 
			addGroup: [ :group | group 
				addItem: [ :item | item
					name: 'Inspect';
					action: [ methodChangeTable selectedItem inspect ] ] ] ].
]

{ #category : #initialization }
DepMethodChangeBrowser >> initializePresenters [
	super initializePresenters.
	
	methodChangeTable := self newTable.
	
	oldCode := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		beNotEditable;
		yourself.
		
	newCode := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		beNotEditable;
		yourself.
		
	self showMethodChangeTable.
	self showMethodChange: methodChangeTable selectedItem.
]

{ #category : #initialization }
DepMethodChangeBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self windowTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #'accessing model' }
DepMethodChangeBrowser >> setModelBeforeInitialization: aRule [
	rule := aRule
]

{ #category : #'as yet unclassified' }
DepMethodChangeBrowser >> showMethodChange: aMethodChange [
	oldCode text: aMethodChange oldSourceCode.
	newCode text: aMethodChange newSourceCode.
]

{ #category : #'as yet unclassified' }
DepMethodChangeBrowser >> showMethodChangeTable [	
	methodChangeTable
		columns: { };
		items: rule methodChanges;
		addColumn: (SpStringTableColumn
			title: 'Class'
			evaluated: [ :each | each method className ]);
		addColumn: (SpStringTableColumn
			title: 'Method'
			evaluated: [ :each | each method selector ]);
		addColumn: (SpStringTableColumn
			title: 'Commit'
			evaluated: [ :each | each commitSha ]).
			
	methodChangeTable selectIndex: 1.
]

{ #category : #initialization }
DepMethodChangeBrowser >> windowTitle [
	^ 'Method changes in which the change ', rule asString, ' appeared'
]
