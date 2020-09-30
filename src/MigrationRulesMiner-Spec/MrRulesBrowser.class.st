Class {
	#name : #MrRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'rules',
		'notebook'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowser class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		add: #notebook;
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

{ #category : #adding }
MrRulesBrowser >> addPageWithRules: aCollectionOfRules title: aTitle [
	| newPage |
	newPage := self newNotebookPage
		title: aTitle;
		presenterProvider: [ MrRulesBrowserPage on: aCollectionOfRules ];
		yourself.
	
	notebook addPage: newPage.
	notebook selectPage: newPage.
	
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
MrRulesBrowser >> initializePresenters [ 
	super initializePresenters.
	
	notebook := self newNotebook.
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
MrRulesBrowser >> notebook [
	^ notebook
]

{ #category : #'accessing model' }
MrRulesBrowser >> setModelBeforeInitialization: aCollectionOfRules [
	rules := aCollectionOfRules
]

{ #category : #building }
MrRulesBrowser >> toolbarActions [
	^ CmCommandGroup forSpec
		register: (CmCommandGroup forSpec
			register: (MrOpenCommand forSpecContext: self);
			register: (MrSaveCommand forSpecContext: self);
			register: (MrMineRulesCommand forSpecContext: self);
			yourself);
		yourself
]
