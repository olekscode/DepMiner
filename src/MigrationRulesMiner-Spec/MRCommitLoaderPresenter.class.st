Class {
	#name : #MRCommitLoaderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'repositorySelect',
		'branchSelect',
		'fromCommitSelect',
		'toCommitSelect',
		'loadCommitsButton',
		'changeHistory',
		'parent'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRCommitLoaderPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
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
		yourself.
]

{ #category : #accessing }
MRCommitLoaderPresenter >> branchSelect [
	^ branchSelect
]

{ #category : #accessing }
MRCommitLoaderPresenter >> branchSelect: anObject [
	branchSelect := anObject
]

{ #category : #accessing }
MRCommitLoaderPresenter >> changeHistory [
	^ changeHistory
]

{ #category : #initialization }
MRCommitLoaderPresenter >> connectPresenters [ 
	loadCommitsButton action: [ self loadCommits ].
	
	repositorySelect whenSelectedItemChangedDo: [ :repo |
		branchSelect
			items: repo allBranches;
			display: [ :branch | branch name ] ].
]

{ #category : #accessing }
MRCommitLoaderPresenter >> fromCommitSelect [
	^ fromCommitSelect
]

{ #category : #accessing }
MRCommitLoaderPresenter >> fromCommitSelect: anObject [
	fromCommitSelect := anObject
]

{ #category : #initialization }
MRCommitLoaderPresenter >> initializePresenters [ 
	repositorySelect := self newDropList
		items: (IceRepository registry select: [ :repo | repo isValid ]);
		display: [ :repo | repo name ]
		yourself.
		
	branchSelect := self newDropList.
	fromCommitSelect := self newTextInput.
	toCommitSelect := self newTextInput.
	
	loadCommitsButton := self newButton
		label: 'Load commits';
		yourself.
]

{ #category : #'as yet unclassified' }
MRCommitLoaderPresenter >> loadCommits [
	| repository |
	
	repository := repositorySelect selectedItem.

	changeHistory := MRChangeHistory new
   		repository: repository;
		branchNamed: branchSelect selectedItem name;
		fromCommitId: fromCommitSelect text;
		toCommitId: toCommitSelect text;
		yourself.
	
	changeHistory loadCommits.
	changeHistory calculateDiffs.
	changeHistory extractMethodChanges.
	
	parent changeHistory: changeHistory.
]

{ #category : #accessing }
MRCommitLoaderPresenter >> loadCommitsButton [
	^ loadCommitsButton
]

{ #category : #accessing }
MRCommitLoaderPresenter >> loadCommitsButton: anObject [
	loadCommitsButton := anObject
]

{ #category : #accessing }
MRCommitLoaderPresenter >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
MRCommitLoaderPresenter >> repositorySelect [
	^ repositorySelect
]

{ #category : #accessing }
MRCommitLoaderPresenter >> repositorySelect: anObject [
	repositorySelect := anObject
]

{ #category : #accessing }
MRCommitLoaderPresenter >> toCommitSelect [
	^ toCommitSelect
]

{ #category : #accessing }
MRCommitLoaderPresenter >> toCommitSelect: anObject [
	toCommitSelect := anObject
]
