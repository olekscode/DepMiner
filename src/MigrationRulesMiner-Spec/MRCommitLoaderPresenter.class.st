Class {
	#name : #MRCommitLoaderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'repositorySelect',
		'branchSelect',
		'fromCommitSelect',
		'toCommitSelect',
		'loadCommitsButton',
		'changeHistory'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRCommitLoaderPresenter class >> defaultSpec [
	^ SpGridLayout new
		add: 'Repository' at: 1@1;
		add: #repositorySelect at: 2@1;
		add: 'Branch' at: 1@2;
		add: #branchSelect at: 2@2;
		add: 'From commit' at: 1@3;
		add: #fromCommitSelect at: 2@3;
		add: 'To commit' at: 1@4;
		add: #toCommitSelect at: 2@4;
		add: (SpBoxLayout newHorizontal
			addLast: #loadCommitsButton;
			yourself)
		at: 1@5 span: 2@1;
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
			enabled: true;
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
	fromCommitSelect := self newDropList.
	toCommitSelect := self newDropList.
	
	branchSelect enabled: false.
	
	loadCommitsButton := self newButton
		label: 'Load commits';
		yourself.
]

{ #category : #'as yet unclassified' }
MRCommitLoaderPresenter >> loadCommits [
	| repository |
	
	repository := IceRepository registry detect: [ :repo |
		(repo name = repositorySelect text) and: [ repo isValid ] ].

	changeHistory := MRChangeHistory new
   		repository: repository;
		branchNamed: branchSelect text;
		fromCommitId: fromCommitSelect text;
		toCommitId: toCommitSelect text;
		yourself.
	
	changeHistory loadCommits.
	changeHistory calculateDiffs.
	changeHistory extractMethodChanges.
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
