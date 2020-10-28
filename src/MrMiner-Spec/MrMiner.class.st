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
		'oldVersionInput',
		'newVersionInput',
		'loadChangesButton',
		'minCountSelect',
		'minConfidenceSelect',
		'mineRulesButton',
		'oldVersionNotebook',
		'oldVersionAllMethodsTree',
		'oldVersionDeletedMethodsTree',
		'newVersionNotebook',
		'newVersionAllMethodsTree',
		'newVersionAddedMethodsTree',
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
					add: #oldVersionInput width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: 'New version';
					add: #newVersionInput width: inputWidth;
					yourself) height: self inputTextHeight;
				add: (SpBoxLayout newHorizontal
					add: '';
					add: #loadChangesButton width: buttonWidth;
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
					add: #oldVersionNotebook;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'New version' height: self labelHeight;
					add: #newVersionNotebook;
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
	
	loadProjectButton action: [ self onLoadProjectClicked ].
	
	oldVersionInput action: [
		(MrCommitSelector on: controller candidateCommitsForOldVersion)
			callback: [ :commit | self onOldVersionSelected: commit ];
			openWithSpec ].
		
	newVersionInput action: [
		(MrCommitSelector on: controller candidateCommitsForNewVersion)
			callback: [ :commit | self onNewVersionSelected: commit ];
			openWithSpec ].
		
	loadChangesButton action: [ self onLoadChangesClicked ].
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
		
	oldVersionInput := MrCommitInput new.
	newVersionInput := MrCommitInput new.
	
	loadChangesButton := self newButton
		label: 'Load changes';
		yourself.
		
	minCountSelect := self newNumberInput.
	minConfidenceSelect := self newNumberInput.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.
		
	oldVersionAllMethodsTree := self instantiate: MrMethodsTree.	
	oldVersionDeletedMethodsTree := self instantiate: MrMethodsTree.
	
	oldVersionNotebook := self newNotebook
		addPage: (self newNotebookPage
			title: 'All';
			presenterProvider: [ oldVersionAllMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Deleted';
			presenterProvider: [ oldVersionDeletedMethodsTree ];
			yourself);
		yourself.
		
	newVersionAllMethodsTree := self instantiate: MrMethodsTree.
	newVersionAddedMethodsTree := self instantiate: MrMethodsTree.
	
	newVersionNotebook := self newNotebook
		addPage: (self newNotebookPage
			title: 'All';
			presenterProvider: [ newVersionAllMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Added';
			presenterProvider: [ newVersionAddedMethodsTree ];
			yourself);
		yourself.
	
	proposedDeprecationsTree := self instantiate: MrMethodsTree.
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
MrMiner >> onLoadChangesClicked [
	| oldVersionString newVersionString |
	
	oldVersionString := oldVersionInput text.
	newVersionString := newVersionInput text.

	oldVersionString ifEmpty: [ 
		self inform: 'Please select the old version'.
		^ self ].

	newVersionString ifEmpty: [ 
		self inform: 'Please select the new version'.
		^ self ].

	(model oldVersionCommit isNotNil and: [ 
		 model oldVersionCommit matches: oldVersionString ]) 
		ifFalse: [ 
			controller candidateCommitsForOldVersion
				detect: [ :commit | commit matches: oldVersionString ]
				ifFound: [ :commit | model oldVersionCommit: commit ]
				ifNone: [ 
					self inform:
						'Old version with this commit SHA or tag was not found' ] ].
				
	(model newVersionCommit isNotNil and: [ 
		 model newVersionCommit matches: newVersionString ]) 
		ifFalse: [ 
			controller candidateCommitsForNewVersion
				detect: [ :commit | commit matches: newVersionString ]
				ifFound: [ :commit | model newVersionCommit: commit ]
				ifNone: [ 
					self inform:
						'New version with this commit SHA or tag was not found' ] ].
				
	controller loadChanges.
	
	self showOldVersion.
	self showNewVersion.
]

{ #category : #'as yet unclassified' }
MrMiner >> onLoadProjectClicked [
	| ownerName projectName |
	
	ownerName := ownerNameInput text.
	projectName := projectNameInput text.
	
	controller loadProject: projectName by: ownerName.
]

{ #category : #'as yet unclassified' }
MrMiner >> onNewVersionSelected: aCommit [
	newVersionInput text: aCommit shortSha.
	model newVersionCommit: aCommit.
]

{ #category : #'as yet unclassified' }
MrMiner >> onOldVersionSelected: aCommit [
	oldVersionInput text: aCommit shortSha.
	model oldVersionCommit: aCommit.
]

{ #category : #'as yet unclassified' }
MrMiner >> showNewVersion [
	self showNewVersionAllMethods.
	self showNewVersionAddedMethods.
]

{ #category : #'as yet unclassified' }
MrMiner >> showNewVersionAddedMethods [
	newVersionAddedMethodsTree packages: controller addedMethodsTree
]

{ #category : #'as yet unclassified' }
MrMiner >> showNewVersionAllMethods [
	newVersionAllMethodsTree packages: controller newVersionTree
]

{ #category : #'as yet unclassified' }
MrMiner >> showOldVersion [
	self showOldVersionAllMethods.
	self showOldVersionDeletedMethods.
]

{ #category : #'as yet unclassified' }
MrMiner >> showOldVersionAllMethods [
	oldVersionAllMethodsTree packages: controller oldVersionTree
]

{ #category : #'as yet unclassified' }
MrMiner >> showOldVersionDeletedMethods [
	oldVersionDeletedMethodsTree packages: controller deletedMethodsTree
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
