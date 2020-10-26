Class {
	#name : #MrMiner,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'controller',
		'ownerNameInput',
		'projectNameInput',
		'projectLoadedLabel',
		'loadProjectButton',
		'oldVersionSelect',
		'newVersionSelect',
		'calculateDiffsButton',
		'minCountSelect',
		'minConfidenceSelect',
		'mineRulesButton',
		'oldVersionTree',
		'newVersionTree',
		'proposedDeprecationsTree',
		'proposedReplacementsList',
		'proposedActionDescriptionLabel',
		'whyButton',
		'oldCode',
		'newCode',
		'applyButton'
	],
	#category : #'MrMiner-Spec-NewViews'
}

{ #category : #specs }
MrMiner class >> defaultSpec [
	| buttonWidth inputWidth spacing |
	
	buttonWidth := 95.
	inputWidth := 150.
	spacing := 4.
	
	^ SpBoxLayout newHorizontal
		spacing: spacing;
		add: (SpBoxLayout newVertical
			spacing: spacing;
			add: (SpBoxLayout newVertical
				add: (SpBoxLayout newHorizontal
					add: 'Owner name';
					add: #ownerNameInput width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: 'Project name';
					add: #projectNameInput width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: #projectLoadedLabel;
					add: #loadProjectButton width: buttonWidth;
					yourself) height: self buttonHeight;
				yourself);
			add: (SpBoxLayout newVertical
				add: (SpBoxLayout newHorizontal
					add: 'Old version';
					add: #oldVersionSelect width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: 'New version';
					add: #newVersionSelect width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: '';
					add: #calculateDiffsButton width: buttonWidth;
					yourself) height: self buttonHeight;
				yourself);
			add: (SpBoxLayout newVertical
				add: (SpBoxLayout newHorizontal
					add: 'Min count';
					add: #minCountSelect width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: 'Min confidence';
					add: #minConfidenceSelect width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: '';
					add: #mineRulesButton width: buttonWidth;
					yourself) height: self buttonHeight;
				yourself);
			yourself) width: 250;
		add: (SpBoxLayout newVertical
			spacing: spacing;
			add: (SpBoxLayout newHorizontal
				spacing: spacing;
				add: (SpBoxLayout newVertical
					add: 'Old version' height: self labelHeight;
					add: #oldVersionTree;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'New version' height: self labelHeight;
					add: #newVersionTree;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'Proposed deprecations' height: self labelHeight;
					add: #proposedDeprecationsTree;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'Proposed replacements' height: self labelHeight;
					add: #proposedReplacementsList;
					yourself);
				yourself) height: 200;
			add: (SpBoxLayout newHorizontal
				add: #proposedActionDescriptionLabel;
				add: #whyButton width: self buttonWidth;
				yourself) height: self buttonHeight;
			add: (SpBoxLayout newHorizontal
				spacing: spacing;
				add: (SpBoxLayout newVertical
					add: 'Old code' height: self labelHeight;
					add: #oldCode;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'New code' height: self labelHeight;
					add: #newCode;
					yourself);
				yourself);
			add: (SpBoxLayout newHorizontal
				add: '';
				add: #applyButton width: self buttonWidth;
				yourself) height: self buttonHeight;
			yourself);
		yourself.
]

{ #category : #accessing }
MrMiner class >> defaultTitle [
	^ 'MrMiner'
]

{ #category : #'world menu' }
MrMiner class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'MrMiner')
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A tool for mining the migration rules that were mined from the commit history as well as  browsing and evaluating those rules';
		icon: (self iconNamed: #databaseAdd).
]

{ #category : #examples }
MrMiner class >> open [
	<example>
	self new openWithSpec
]

{ #category : #accessing }
MrMiner class >> preferredExtent [
	^ 1000@600
]

{ #category : #'private builder' }
MrMiner >> buildToolbar [
	^ self toolbarActions 
		asToolbarPresenterWith: [ :presenter | 
			presenter 
				displayMode: SpToolbarDisplayMode modeIconAndLabel;
				addStyle: 'stToolbar' ]
]

{ #category : #initialization }
MrMiner >> connectPresenters [
	super connectPresenters.
	
	loadProjectButton action: [ self onLoadProject ].
]

{ #category : #initialization }
MrMiner >> initialize [
	super initialize.
	
	model := MrMinerModel new.
	
	controller := MrMinerController new
		model: model;
		yourself.
]

{ #category : #initialization }
MrMiner >> initializePresenters [
	super initializePresenters.
	
	ownerNameInput := self newTextInput.
	projectNameInput := self newTextInput.
	
	projectLoadedLabel := self newLabel.
	
	loadProjectButton := self newButton
		label: 'Load project';
		yourself.
		
	oldVersionSelect := MrCommitSelect new.
	newVersionSelect := MrCommitSelect new.
	
	calculateDiffsButton := self newButton
		label: 'Load changes';
		yourself.
		
	minCountSelect := self newNumberInput.
	minConfidenceSelect := self newNumberInput.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.
		
	oldVersionTree := self newTree.
	newVersionTree := self newTree.
	proposedDeprecationsTree := self newTree.
	proposedReplacementsList := self newList.
	
	proposedActionDescriptionLabel := self newLabel.
	
	whyButton := self newButton
		icon: (self iconNamed: #help);
		label: 'Why?';
		yourself.
	
	oldCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
		
	newCode := self newCode
		withoutLineNumbers;
		yourself.
	
	applyButton := self newButton
		label: 'Apply';
		yourself.
]

{ #category : #initialization }
MrMiner >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent;
		toolbar: self buildToolbar.
]

{ #category : #'as yet unclassified' }
MrMiner >> onLoadProject [
	| ownerName projectName |
	
	ownerName := ownerNameInput text.
	projectName := projectNameInput text.
	
	controller loadProject: projectName by: ownerName.
	model inspect.
]

{ #category : #building }
MrMiner >> toolbarActions [
	^ CmCommandGroup forSpec
		register: (CmCommandGroup forSpec
			register: (MrOpenCommand forSpecContext: self);
			register: (MrSaveCommand forSpecContext: self);
			yourself);
		yourself
]
