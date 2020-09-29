Class {
	#name : #MrCommitLoaderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'repositorySelect',
		'branchSelect',
		'fromCommitSelect',
		'toCommitSelect',
		'loadCommitsButton',
		'progressBar',
		'methodChangeCollector'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitLoaderPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 2;
		add: (SpBoxLayout newHorizontal
			add: 'Repository' width: self labelWidth;
			add: #repositorySelect;
			yourself) height: self inputTextHeight;
		add: (SpBoxLayout newHorizontal
			add: 'Branch' width: self labelWidth;
			add: #branchSelect;
			yourself) height: self inputTextHeight;
		add: (SpBoxLayout newHorizontal
			add: 'From commit' width: self labelWidth;
			add: #fromCommitSelect;
			yourself) height: self inputTextHeight;
		add: (SpBoxLayout newHorizontal
			add: 'To commit' width: self labelWidth;
			add: #toCommitSelect;
			yourself) height: self inputTextHeight;
		add: #loadCommitsButton height: self buttonHeight;
		add: #progressBar;
		yourself.
]

{ #category : #accessing }
MrCommitLoaderPresenter >> branchSelect [
	^ branchSelect
]

{ #category : #accessing }
MrCommitLoaderPresenter >> branchSelect: anObject [
	branchSelect := anObject
]

{ #category : #initialization }
MrCommitLoaderPresenter >> connectPresenters [ 
	| repository commits |
	loadCommitsButton action: [ self loadCommits ].
	
	repositorySelect whenSelectedItemChangedDo: [ :repo |
		branchSelect
			items: repo localBranches;
			display: [ :branch | branch name ];
			resetSelection ].
		
	branchSelect whenSelectedItemChangedDo: [ :branch |
		repository := repositorySelect selectedItem.
		methodChangeCollector := MrMethodChangeCollector forRepository: repository branch: branch.
		commits := methodChangeCollector loadAllCommits.
		
		fromCommitSelect
			items: commits;
			display: [ :commit | commit sha copyFrom: 1 to: 7 ];
			resetSelection.
			
		toCommitSelect
			items: commits;
			display: [ :commit | commit sha copyFrom: 1 to: 7 ];
			resetSelection ]
]

{ #category : #accessing }
MrCommitLoaderPresenter >> fromCommitSelect [
	^ fromCommitSelect
]

{ #category : #accessing }
MrCommitLoaderPresenter >> fromCommitSelect: anObject [
	fromCommitSelect := anObject
]

{ #category : #initialization }
MrCommitLoaderPresenter >> initializePresenters [ 
	repositorySelect := self newDropList
		items: (IceRepository registry select: [ :repo | repo isValid ]);
		display: [ :repo | repo name ]
		yourself.
		
	branchSelect := self newDropList.
	fromCommitSelect := self newDropList.
	toCommitSelect := self newDropList.
	
	loadCommitsButton := self newButton
		label: 'Load commits';
		yourself.
		
	progressBar := self newProgressBar.
	progressBar fixedAt: 0.3.
]

{ #category : #'as yet unclassified' }
MrCommitLoaderPresenter >> loadCommits [
	| fromCommit toCommit commits diffs methodChanges |

	fromCommit := methodChangeCollector iceCommitFromSha: fromCommitSelect selectedItem sha.
	toCommit := methodChangeCollector iceCommitFromSha: toCommitSelect selectedItem sha.

	commits := methodChangeCollector loadIceCommitsFrom: fromCommit to: toCommit.
	diffs := OrderedCollection new.
	progressBar fixedAt: 0.
	
	commits withIndexDo: [ :commit :index | 
		diffs add: (commit diffTo: commit parent).
		progressBar fixedAt: index / commits size asFloat ].
	
	methodChanges := methodChangeCollector extractMethodChangesFromDiffs: diffs.
	
	methodChanges inspect.
]

{ #category : #accessing }
MrCommitLoaderPresenter >> loadCommitsButton [
	^ loadCommitsButton
]

{ #category : #accessing }
MrCommitLoaderPresenter >> loadCommitsButton: anObject [
	loadCommitsButton := anObject
]

{ #category : #accessing }
MrCommitLoaderPresenter >> progressBar [
	^ progressBar
]

{ #category : #accessing }
MrCommitLoaderPresenter >> progressBar: anObject [
	progressBar := anObject
]

{ #category : #accessing }
MrCommitLoaderPresenter >> repositorySelect [
	^ repositorySelect
]

{ #category : #accessing }
MrCommitLoaderPresenter >> repositorySelect: anObject [
	repositorySelect := anObject
]

{ #category : #accessing }
MrCommitLoaderPresenter >> toCommitSelect [
	^ toCommitSelect
]

{ #category : #accessing }
MrCommitLoaderPresenter >> toCommitSelect: anObject [
	toCommitSelect := anObject
]
