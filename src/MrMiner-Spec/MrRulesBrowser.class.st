Class {
	#name : #MrRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'hasUnsavedChanges'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowser class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		add: #notebook;
		yourself.
]

{ #category : #accessing }
MrRulesBrowser class >> defaultTitle [
	^ 'MrMiner Browser'
]

{ #category : #examples }
MrRulesBrowser class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #accessing }
MrRulesBrowser class >> preferredExtent [
	^ 1300@720
]

{ #category : #adding }
MrRulesBrowser >> addPageWithExperiment: anExperiment title: aTitle [
	| newPage |
	newPage := self newNotebookPage
		title: aTitle;
		presenterProvider: [ (MrRulesBrowserPage on: anExperiment)
			whenFeedbackChangedDo: [ self onChanged ];
			yourself ];
		beCloseable;
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

{ #category : #'as yet unclassified' }
MrRulesBrowser >> currentExperiment [
	^ notebook selectedPage activePresenter experiment
]

{ #category : #initialization }
MrRulesBrowser >> initialize [
	super initialize.
	hasUnsavedChanges := false.
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

{ #category : #'as yet unclassified' }
MrRulesBrowser >> onChanged [
	hasUnsavedChanges ifFalse: [ 
		notebook selectedPage title: (notebook selectedPage title, '*') ].

	hasUnsavedChanges := true.
]

{ #category : #'as yet unclassified' }
MrRulesBrowser >> onSaved [
	hasUnsavedChanges := false.
	notebook selectedPage title: self currentExperiment fileReference basename.
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
