Class {
	#name : #DepMiner,
	#superclass : #SpPresenter,
	#instVars : [
		'settings',
		'projectHistory',
		'recommendations',
		'controller',
		'ownerNameInput',
		'projectNameInput',
		'projectLoadedLabel',
		'loadProjectButton',
		'oldVersionInput',
		'newVersionInput',
		'loadChangesButton',
		'numberOfCommitsLabel',
		'numberOfMethodChangesLabel',
		'numberOfRelevantMethodChangesLabel',
		'inspectProjectHistoryLink',
		'minCountSelect',
		'minConfidenceSelect',
		'mineRulesButton',
		'totalRulesCountLabel',
		'relevantRulesCountLabel',
		'automatableRulesCountLabel',
		'inspectRecommendationsLink',
		'oldVersionNotebook',
		'oldVersionAllMethodsTree',
		'oldVersionDeletedMethodsTree',
		'oldVersionDeprecatedMethodsTree',
		'newVersionNotebook',
		'newVersionAllMethodsTree',
		'newVersionAddedMethodsTree',
		'newVersionDeprecatedMethodsTree',
		'recommendationsNotebook',
		'proposedDeprecationsTree',
		'missingRulesTree',
		'onlyAutomatableRulesCheckbox',
		'mainAreaNotebook'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepMiner class >> defaultSpec [
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
				add: #numberOfCommitsLabel height: self labelHeight;
				add: #numberOfMethodChangesLabel height: self labelHeight;
				add: #numberOfRelevantMethodChangesLabel height: self labelHeight;
				add: #inspectProjectHistoryLink height: self labelHeight;
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
			add: (SpBoxLayout newVertical
				add: #totalRulesCountLabel height: self labelHeight;
				add: #relevantRulesCountLabel height: self labelHeight;
				add: #automatableRulesCountLabel height: self labelHeight;
				add: #inspectRecommendationsLink height: self labelHeight;
				yourself);
			add: '';
			yourself) width: 250;
		add: (SpPanedLayout newVertical
			add: (SpBoxLayout newHorizontal
				spacing: spacing;
				add: (SpBoxLayout newVertical
					add: 'Methods in the old version' height: self labelHeight;
					add: #oldVersionNotebook;
					yourself);
				add: (SpBoxLayout newVertical
					add: 'Methods in the new version' height: self labelHeight;
					add: #newVersionNotebook;
					yourself);
				add: (SpBoxLayout newVertical
					add: (SpBoxLayout newHorizontal
						add: 'Recommendations';
						add: #onlyAutomatableRulesCheckbox width: 180;
						yourself) height: self labelHeight;
					add: #recommendationsNotebook;
					yourself);
				yourself);
			add: #mainAreaNotebook;
			yourself);
		yourself.
]

{ #category : #accessing }
DepMiner class >> defaultTitle [
	^ 'DepMiner'
]

{ #category : #'world menu' }
DepMiner class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #DepMiner)
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A tool for mining transformation rules for deprecations based on the commit history of the project';
		icon: (self iconNamed: #databaseAdd).
]

{ #category : #examples }
DepMiner class >> open [
	<example>
	self new openWithSpec
]

{ #category : #accessing }
DepMiner class >> preferredExtent [
	^ 1300@700
]

{ #category : #'private builder' }
DepMiner >> buildToolbar [
	^ self toolbarActions 
		asToolbarPresenterWith: [ :presenter | 
			presenter 
				displayMode: SpToolbarDisplayMode modeIconAndLabel;
				addStyle: 'stToolbar' ]
]

{ #category : #initialization }
DepMiner >> connectPresenters [
	super connectPresenters.
	
	loadProjectButton action: [ self onLoadProjectClicked ].
	
	oldVersionInput action: [
		(DepCommitSelector on: controller candidateCommitsForOldVersion)
			callback: [ :commit | self onOldVersionSelected: commit ];
			openWithSpec ].
		
	newVersionInput action: [
		(DepCommitSelector on: controller candidateCommitsForNewVersion)
			callback: [ :commit | self onNewVersionSelected: commit ];
			openWithSpec ].
		
	loadChangesButton action: [ self onLoadChangesClicked ].
	mineRulesButton action: [ self onMineRulesClicked ].
	
	inspectProjectHistoryLink action: [ projectHistory inspect ].
	inspectRecommendationsLink action: [ recommendations inspect ].
	
	{
		oldVersionAllMethodsTree .
		oldVersionDeletedMethodsTree .
		oldVersionDeprecatedMethodsTree .
		newVersionAllMethodsTree .
		newVersionAddedMethodsTree .
		newVersionDeprecatedMethodsTree
	} do: [ :tree |
		tree actionOnLeafClicked: [ :method |
			self onMethodClicked: method ] ].
	
	{
		proposedDeprecationsTree .
		missingRulesTree
	} do: [ :tree |
		tree actionOnLeafClicked: [ :method |
			self onRecommendationClicked: method ] ].
	
	onlyAutomatableRulesCheckbox whenChangedDo: [ self onOnlyAutomatableRulesStateChanged ].
]

{ #category : #initialization }
DepMiner >> initialize [
	super initialize.
	
	settings := DepSettings new.
	projectHistory := DepProjectHistory new.
	recommendations := DepRecommendations new.
	
	controller := DepMinerController new
		settings: settings;
		projectHistory: projectHistory;
		recommendations: recommendations;
		yourself.
]

{ #category : #initialization }
DepMiner >> initializePresenters [
	super initializePresenters.
	
	ownerNameInput := self newTextInput.
	projectNameInput := self newTextInput.
	
	projectLoadedLabel := self newLabel.
	
	loadProjectButton := self newButton
		label: 'Load project';
		yourself.
		
	oldVersionInput := DepCommitInput new.
	newVersionInput := DepCommitInput new.
	
	loadChangesButton := self newButton
		label: 'Load changes';
		yourself.
		
	numberOfCommitsLabel := self newLabel.
	numberOfMethodChangesLabel := self newLabel.
	numberOfRelevantMethodChangesLabel := self newLabel.
		
	inspectProjectHistoryLink := self newLink
		label: '(inspect project history)';
		yourself.
		
	minCountSelect := self newNumberInput.
	minConfidenceSelect := self newNumberInput.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.
		
	totalRulesCountLabel := self newLabel.
	relevantRulesCountLabel := self newLabel.
	automatableRulesCountLabel := self newLabel.
		
	inspectRecommendationsLink := self newLink
		label: '(inspect recommendations)';
		yourself.
		
	oldVersionAllMethodsTree := self instantiate: DepMethodTreePresenter.	
	oldVersionDeletedMethodsTree := self instantiate: DepMethodTreePresenter.
	oldVersionDeprecatedMethodsTree := self instantiate: DepMethodTreePresenter.
	
	oldVersionNotebook := self newNotebook
		addPage: (self newNotebookPage
			title: 'All';
			presenterProvider: [ oldVersionAllMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Deleted';
			presenterProvider: [ oldVersionDeletedMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Deprecated';
			presenterProvider: [ oldVersionDeprecatedMethodsTree ];
			yourself);
		yourself.
		
	newVersionAllMethodsTree := self instantiate: DepMethodTreePresenter.
	newVersionAddedMethodsTree := self instantiate: DepMethodTreePresenter.
	newVersionDeprecatedMethodsTree := self instantiate: DepMethodTreePresenter.
	
	newVersionNotebook := self newNotebook
		addPage: (self newNotebookPage
			title: 'All';
			presenterProvider: [ newVersionAllMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Added';
			presenterProvider: [ newVersionAddedMethodsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Deprecated';
			presenterProvider: [ newVersionDeprecatedMethodsTree ];
			yourself);
		yourself.
	
	proposedDeprecationsTree := self instantiate: DepRecommendationTreePresenter.
	missingRulesTree := self instantiate: DepRecommendationTreePresenter.
	
	recommendationsNotebook := self newNotebook
		addPage: (self newNotebookPage
			title: 'Proposed Deprecations';
			presenterProvider: [ proposedDeprecationsTree ];
			yourself);
		addPage: (self newNotebookPage
			title: 'Missing Rules';
			presenterProvider: [ missingRulesTree ];
			yourself);
		yourself.
		
	onlyAutomatableRulesCheckbox := self newCheckBox
		label: 'Show only automatable rules';
		yourself.
	
	mainAreaNotebook := self newNotebook.
		
	self showProjectHistoryStats.
	self showRulesStats.
]

{ #category : #initialization }
DepMiner >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent;
		toolbar: self buildToolbar.
]

{ #category : #'as yet unclassified' }
DepMiner >> loadWithSettings: aSettingsModel projectHistory: aProjectHistoryModel recommendations: aRecommendationsModel [

	settings := aSettingsModel.
	projectHistory := aProjectHistoryModel.
	recommendations := aRecommendationsModel.
	
	controller settings: settings.
	controller projectHistory: projectHistory.
	controller recommendations: recommendations.
	
	mainAreaNotebook removeAll.
	
	self showSettings.
	self showOldVersion.
	self showNewVersion.
	self showRecommendations.
]

{ #category : #'as yet unclassified' }
DepMiner >> onLoadChangesClicked [
	| oldVersionString newVersionString oldCommit newCommit |
	
	oldVersionString := oldVersionInput text.
	newVersionString := newVersionInput text.

	oldVersionString ifEmpty: [ 
		self inform: 'Please select the old version'.
		^ self ].

	newVersionString ifEmpty: [ 
		self inform: 'Please select the new version'.
		^ self ].
	
	oldCommit := projectHistory
		commitThatMatches: oldVersionString
		ifNone: [
			self inform: 'Old version with this commit SHA or tag was not found'.
			^ self ].
		
	newCommit := projectHistory
		commitThatMatches: newVersionString
		ifNone: [
			self inform: 'New version with this commit SHA or tag was not found'.
			^ self ].
		
	settings oldCommitSha: oldCommit sha.
	settings newCommitSha: newCommit sha.
				
	controller loadChanges.
	
	self showOldVersion.
	self showNewVersion.
	
	self showProjectHistoryStats.
]

{ #category : #'as yet unclassified' }
DepMiner >> onLoadProjectClicked [
	settings ownerName: ownerNameInput text.
	settings projectName: projectNameInput text.
	
	controller loadProject.
]

{ #category : #events }
DepMiner >> onMethodClicked: aMethod [
	mainAreaNotebook removeAll.

	mainAreaNotebook addPage: (self newNotebookPage
		title: 'Source code';
		presenterProvider: [
			self newCode
				withoutLineNumbers;
				beForBehavior: Object;
				beNotEditable;
				text: aMethod sourceCode;
				yourself ];
		yourself).
		
	mainAreaNotebook selectPageIndex: 1.
]

{ #category : #'as yet unclassified' }
DepMiner >> onMineRulesClicked [
	settings minCount: minCountSelect number.
	settings minConfidence: minConfidenceSelect number.
	
	controller mineRules.
	
	self showRecommendations.
	self showRulesStats.
]

{ #category : #'as yet unclassified' }
DepMiner >> onNewVersionSelected: aCommit [
	newVersionInput text: aCommit tagOrShortSha.
	settings newCommitSha: aCommit sha.
]

{ #category : #'as yet unclassified' }
DepMiner >> onOldVersionSelected: aCommit [
	oldVersionInput text: aCommit tagOrShortSha.
	settings oldCommitSha: aCommit sha.
]

{ #category : #'as yet unclassified' }
DepMiner >> onOnlyAutomatableRulesStateChanged [
	| selectedPage selectedMethod |
	
	selectedPage := recommendationsNotebook selectedPage.
	selectedMethod := selectedPage activePresenter selectedItem.
	
	self showRecommendations.
	
	recommendationsNotebook selectPage: selectedPage.
	
	selectedMethod ifNotNil: [ 
		selectedPage activePresenter selectItem: selectedMethod ].
]

{ #category : #'as yet unclassified' }
DepMiner >> onRecommendationClicked: aRecommendation [
	mainAreaNotebook removeAll.
	
	self showAutomatableRulesApplicableTo: aRecommendation.
	
	onlyAutomatableRulesCheckbox state ifFalse: [
		self showNonAutomatableRulesApplicableTo: aRecommendation ].
		
	mainAreaNotebook selectPageIndex: 1.
]

{ #category : #accessing }
DepMiner >> projectHistory [
	^ projectHistory
]

{ #category : #accessing }
DepMiner >> recommendations [
	^ recommendations
]

{ #category : #accessing }
DepMiner >> settings [
	^ settings
]

{ #category : #'as yet unclassified' }
DepMiner >> showAutomatableRulesApplicableTo: aRecommendation [
	aRecommendation hasAutomatableReplacements ifTrue: [
		mainAreaNotebook addPage: (self newNotebookPage
			title: 'Automatable rules';
			presenterProvider: [ DepAutomatableRecommendationPresenter on: aRecommendation ];
			yourself) ].
]

{ #category : #'as yet unclassified' }
DepMiner >> showMissingRules [
	| methods |
	methods := recommendations methodsWithMissingRules.
	methods ifNil: [ ^ self ].
	
	onlyAutomatableRulesCheckbox state ifTrue: [ 
		methods := methods select: [ :method |
			method hasAutomatableReplacements ] ].
	
	missingRulesTree items: methods.
]

{ #category : #'as yet unclassified' }
DepMiner >> showNewVersion [
	self showNewVersionAllMethods.
	self showNewVersionAddedMethods.
	self showNewVersionDeprecatedMethods.
]

{ #category : #'as yet unclassified' }
DepMiner >> showNewVersionAddedMethods [
	newVersionAddedMethodsTree items:
		(projectHistory methods select: [ :method | method wasAdded ]).
]

{ #category : #'as yet unclassified' }
DepMiner >> showNewVersionAllMethods [
	newVersionAllMethodsTree items:
		(projectHistory methods select: [ :method | method isInNewVersion ])
]

{ #category : #'as yet unclassified' }
DepMiner >> showNewVersionDeprecatedMethods [
	newVersionDeprecatedMethodsTree items:
		(projectHistory methods select: [ :method | method isInNewVersion and: [ method isDeprecated ] ])
]

{ #category : #'as yet unclassified' }
DepMiner >> showNonAutomatableRulesApplicableTo: aRecommendation [
	aRecommendation hasNonAutomatableReplacements ifTrue: [
		mainAreaNotebook addPage: (self newNotebookPage
			title: 'Non-automatable rules';
			presenterProvider: [ DepNonAutomatableRecommendationPresenter on: aRecommendation ];
			yourself) ].
]

{ #category : #'as yet unclassified' }
DepMiner >> showOldVersion [
	self showOldVersionAllMethods.
	self showOldVersionDeletedMethods.
	self showOldVersionDeprecatedMethods.
]

{ #category : #'as yet unclassified' }
DepMiner >> showOldVersionAllMethods [
	oldVersionAllMethodsTree items:
		(projectHistory methods select: [ :method | method wasInOldVersion ])
]

{ #category : #'as yet unclassified' }
DepMiner >> showOldVersionDeletedMethods [
	oldVersionDeletedMethodsTree items:
		(projectHistory methods select: [ :method | method wasDeleted ])
]

{ #category : #'as yet unclassified' }
DepMiner >> showOldVersionDeprecatedMethods [
	oldVersionDeprecatedMethodsTree items:
		(projectHistory methods select: [ :method | method wasInOldVersion and: [ method wasDeprecatedInOldVersion ] ])
]

{ #category : #'as yet unclassified' }
DepMiner >> showProjectHistoryStats [
	| numberOfCommits numberOfMethodChanges numberOfRelevantMethodChanges fractionOfRelevantMethodChanges |
	
	recommendations ifNil: [ 
		numberOfCommits := 0.
		numberOfMethodChanges := 0.
		numberOfRelevantMethodChanges := 0.
		fractionOfRelevantMethodChanges := 0. ]
	ifNotNil: [
		numberOfCommits := projectHistory commitDictionary size.
		numberOfMethodChanges := projectHistory totalNumberOfMethodChanges.
		numberOfRelevantMethodChanges := projectHistory relevantMethodChanges size.
		fractionOfRelevantMethodChanges :=  numberOfMethodChanges = 0 ifTrue: [ 0 ] ifFalse: [ numberOfRelevantMethodChanges / numberOfMethodChanges ] ].
	
	numberOfCommitsLabel label: (numberOfCommits asString, ' commits between those two versions').
	numberOfMethodChangesLabel label: (numberOfMethodChanges asString, ' method changes').
	numberOfRelevantMethodChangesLabel label: (numberOfRelevantMethodChanges asString, ' relevant method changes (', ((fractionOfRelevantMethodChanges * 100) asFloat round: 1) asString, '%)').
]

{ #category : #'as yet unclassified' }
DepMiner >> showProposedDeprecations [
	| methods |
	methods := recommendations methodsToDeprecate.
	
	methods ifNil: [ ^ self ].
	
	onlyAutomatableRulesCheckbox state ifTrue: [ 
		methods := methods select: [ :method |
			method hasAutomatableReplacements ] ].
	
	proposedDeprecationsTree items: methods.
]

{ #category : #'as yet unclassified' }
DepMiner >> showRecommendations [
	self showProposedDeprecations.
	self showMissingRules.
]

{ #category : #'as yet unclassified' }
DepMiner >> showRulesStats [
	| totalNumberOfRules numberOfRelevantRules numberOfAutomatableRules fractionOfRelevantRules fractionOfAutomatableRules |
	
	recommendations ifNil: [ 
		totalNumberOfRules := 0.
		numberOfRelevantRules := 0.
		numberOfAutomatableRules := 0.
		fractionOfRelevantRules := 0.
		fractionOfAutomatableRules := 0. ]
	ifNotNil: [
		totalNumberOfRules := recommendations rules size.
		numberOfRelevantRules := recommendations relevantRules size.
		numberOfAutomatableRules := recommendations transformationRules size.
		fractionOfRelevantRules := totalNumberOfRules = 0 ifTrue: [ 0 ] ifFalse: [ numberOfRelevantRules / totalNumberOfRules ].
		fractionOfAutomatableRules :=  totalNumberOfRules = 0 ifTrue: [ 0 ] ifFalse: [ numberOfAutomatableRules / totalNumberOfRules ] ].
	
	totalRulesCountLabel label: (totalNumberOfRules asString, ' rules were found').
	relevantRulesCountLabel label: (numberOfRelevantRules asString, ' relevant rules (', ((fractionOfRelevantRules * 100) asFloat round: 1) asString, '%)').
	automatableRulesCountLabel label: (numberOfAutomatableRules asString, ' automatable rules (', ((fractionOfAutomatableRules * 100) asFloat round: 1) asString, '%)').
]

{ #category : #'as yet unclassified' }
DepMiner >> showSettings [
	ownerNameInput text: settings ownerName.
	projectNameInput text: settings projectName.
	
	oldVersionInput text: (projectHistory commitDictionary at: settings oldCommitSha) tagOrShortSha.
	newVersionInput text: (projectHistory commitDictionary at: settings newCommitSha) tagOrShortSha.
	
	minCountSelect number: settings minCount.
	minConfidenceSelect number: settings minConfidence.
	
	self showProjectHistoryStats.
	self showRulesStats.
]

{ #category : #building }
DepMiner >> toolbarActions [
	^ CmCommandGroup forSpec
		register: (CmCommandGroup forSpec
			register: (DepOpenCommand forSpecContext: self);
			register: (DepSaveCommand forSpecContext: self);
			yourself);
		yourself
]
