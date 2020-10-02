Class {
	#name : #MrCommitLoaderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'experimentManager',
		'commits',
		'resultCallback',
		'progressBar',
		'fromCommitTable',
		'repositoriesTable',
		'toCommitTable',
		'branchesTable',
		'minCountInput',
		'minConfidenceInput',
		'mineRulesButton'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitLoaderPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 2;
		add: (SpBoxLayout newHorizontal
			spacing: 4;
			add: (SpBoxLayout newVertical
				add: 'Repository' height: self labelHeight;
				add: #repositoriesTable;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'Branch' height: self labelHeight;
				add: #branchesTable;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'From commit' height: self labelHeight;
				add: #fromCommitTable;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'To commit' height: self labelHeight;
				add: #toCommitTable;
				yourself);
			add: (SpBoxLayout newVertical
				add: '' height: self labelHeight;
				add: (SpBoxLayout newHorizontal
					add: 'Min count';
					add: #minCountInput width: 50;
					yourself) height: self buttonHeight;
				add: (SpBoxLayout newHorizontal
					add: 'Min confidence';
					add: #minConfidenceInput width: 50;
					yourself) height: self buttonHeight;
				add: #mineRulesButton height: self buttonHeight;
				yourself);
			yourself);
		add: #progressBar height: self buttonHeight;
		yourself.
]

{ #category : #accessing }
MrCommitLoaderPresenter class >> defaultTitle [
	^ 'MrMiner'
]

{ #category : #accessing }
MrCommitLoaderPresenter class >> preferredExtent [
	^ 1100@500
]

{ #category : #initialization }
MrCommitLoaderPresenter >> connectPresenters [ 
	repositoriesTable whenSelectionChangedDo: [ :selection |
		self onRepositorySelectionChanged: repositoriesTable selectedItem ].
		
	branchesTable whenSelectionChangedDo: [ :selection |
		self onBranchSelectionChanged: branchesTable selectedItem ].
	
	fromCommitTable whenSelectionChangedDo: [ :selection |
		self onFromCommitSelectionChanged: fromCommitTable selectedItem ].
	
	toCommitTable whenSelectionChangedDo: [ :selection |
		self onToCommitSelectionChanged: toCommitTable selectedItem ].
	
	mineRulesButton action: [ self mineRules ].
]

{ #category : #initialization }
MrCommitLoaderPresenter >> initialize [
	super initialize.
	experimentManager := MrExperimentManager new.
]

{ #category : #initialization }
MrCommitLoaderPresenter >> initializePresenters [ 
	repositoriesTable := self newTable.
	branchesTable:= self newTable.
	fromCommitTable := self newTable.
	toCommitTable := self newTable.
	
	minCountInput := self newNumberInput.
	minConfidenceInput := self newNumberInput.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.
		
	progressBar := self newProgressBar.
	progressBar fixedAt: 0.3.
	
	minCountInput
		minimum: 2;
		number: 2.
		
	minConfidenceInput
		beFloat;
		minimum: 0.0;
		maximum: 1.0;
		number: 0.0;
		climbRate: 0.01.
	
	repositoriesTable hideColumnHeaders.
	branchesTable hideColumnHeaders.
	
	fromCommitTable
		hideColumnHeaders;
		enableSearch;
		searchMatching: [ :item :pattern |
			(fromCommitTable columns first evaluation value: item) includesSubstring: pattern ].
		
	toCommitTable hideColumnHeaders;
		enableSearch;
		searchMatching: [ :item :pattern |
			(toCommitTable columns first evaluation value: item) includesSubstring: pattern ].
		
	repositoriesTable
		columns: { };
		items: (IceRepository registry select: [ :repo | repo isValid ]);
		addColumn: (SpStringTableColumn
			title: 'Repository'
			evaluated: [ :repo | repo name ]).
]

{ #category : #initialization }
MrCommitLoaderPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> mineRules [
	experimentManager
		loadMethodChangesFromCommit: fromCommitTable selectedItem
		toCommit: toCommitTable selectedItem.
		
	experimentManager
		mineRulesWithMinCount: minCountInput number 
		minConfidence: minConfidenceInput number.
		
	resultCallback value: experimentManager experiment.
	self window close.
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> onBranchSelectionChanged: aBranch [
	aBranch ifNotNil: [
		experimentManager branch: aBranch.
		commits := experimentManager loadAllCommits.
		
		fromCommitTable
			columns: { };
			items: commits;
			addColumn: (SpStringTableColumn
				title: 'From commit'
				evaluated: [ :commit |
					commit shortSha, (commit tags
						ifEmpty: [ '' ]
						ifNotEmpty: [ ' (', (', ' join: commit tags), ')' ]) ]).
					
		toCommitTable items: #() ].
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> onFromCommitSelectionChanged: aCommit [
	aCommit ifNotNil: [
		toCommitTable
			columns: { };
			items: (commits select: [ :each | each datetime > aCommit datetime ]);
			addColumn: (SpStringTableColumn
				title: 'To commit'
				evaluated: [ :commit |
					commit shortSha, (commit tags
						ifEmpty: [ '' ]
						ifNotEmpty: [ ' (', (', ' join: commit tags), ')' ]) ]) ].
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> onRepositorySelectionChanged: aRepository [
	aRepository ifNotNil: [
		experimentManager repository: aRepository.
		
		branchesTable
			columns: { };
			items: aRepository localBranches;
			addColumn: (SpStringTableColumn
				title: 'Branch'
				evaluated: [ :branch | branch name ]).
				
		fromCommitTable items: #().
		toCommitTable items: #() ].
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> onToCommitSelectionChanged: aCommit [
	aCommit ifNotNil: [  ].
]

{ #category : #accessing }
MrCommitLoaderPresenter >> whenReseltsAreReadyDo: aBlock [
	resultCallback := aBlock
]
