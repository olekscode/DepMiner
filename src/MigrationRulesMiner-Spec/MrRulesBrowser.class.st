Class {
	#name : #MrRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'rules',
		'rulesTable',
		'rulePresenter'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowser class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 15;
		add: #rulesTable width: 500;
		add: #rulePresenter;
		yourself.
]

{ #category : #accessing }
MrRulesBrowser class >> defaultTitle [
	^ 'Rule Browser'
]

{ #category : #'world menu' }
MrRulesBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Migration Rules Browser')
		parent: #Tools;
		action: [ self open ];
		order: 30;
		help: 'A tool for browsing and evaluating the migration rules that were mined from the commit history';
		icon: (self iconNamed: #user).
]

{ #category : #examples }
MrRulesBrowser class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #accessing }
MrRulesBrowser class >> preferredExtent [
	^ 1700@1000
]

{ #category : #'private builder' }
MrRulesBrowser >> buildToolbar [
	^ self toolbarActions 
		asToolbarPresenterWith: [ :presenter | 
			presenter 
				displayMode: SpToolbarDisplayMode modeIconAndLabel;
				addStyle: 'stToolbar' ]
]

{ #category : #initialization }
MrRulesBrowser >> connectPresenters [
	super connectPresenters.
	
	rulesTable whenSelectionChangedDo: [
		rulesTable selectedItem ifNotNil: [ 
			self showRule: rulesTable selectedItem ] ]
]

{ #category : #initialization }
MrRulesBrowser >> initializePresenters [ 
	super initializePresenters.
	
	rulesTable := self newTable.
	rulePresenter := MrRulePresenter new.
	
	rules ifNotNil: [ self showRules ].
]

{ #category : #initialization }
MrRulesBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent;
		toolbar: self buildToolbar.
]

{ #category : #accessing }
MrRulesBrowser >> rulePresenter [
	^ rulePresenter
]

{ #category : #accessing }
MrRulesBrowser >> rulesTable [
	^ rulesTable
]

{ #category : #'accessing model' }
MrRulesBrowser >> setModelBeforeInitialization: aCollectionOfRules [
	rules := aCollectionOfRules
]

{ #category : #'as yet unclassified' }
MrRulesBrowser >> showRule: aRule [
	rulePresenter rule: aRule
]

{ #category : #'as yet unclassified' }
MrRulesBrowser >> showRules [
	rulesTable
		columns: { };
		items: rules;
		addColumn: (SpStringTableColumn
			title: 'Deleted calls'
			evaluated: [ :each | ', ' join: each deletedMethodCalls]);
		addColumn: (SpStringTableColumn
			title: 'Added calls'
			evaluated: [ :each | ', ' join: each addedMethodCalls ]);
		addColumn: (SpStringTableColumn
			title: 'Count'
			evaluated: [ :each | each count ]);
		addColumn: (SpStringTableColumn
			title: 'Confidence'
			evaluated: [ :each | each confidence asFloat round: 3 ]);
		addColumn: (SpStringTableColumn
			title: 'Lift'
			evaluated: [ :each | each lift asFloat round: 3 ]).
			
		rules ifNotEmpty: [ 
			rulesTable selectIndex: 1.
			self showRule: rulesTable selectedItem ].
]

{ #category : #building }
MrRulesBrowser >> toolbarActions [
	^ CmCommandGroup forSpec
		register: (CmCommandGroup forSpec
			register: (MrOpenCommand forSpecContext: self);
			register: (MrSaveCommand forSpecContext: self);
			yourself);
		yourself
]
