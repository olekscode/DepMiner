Class {
	#name : #DepCommitSelector,
	#superclass : #SpPresenter,
	#instVars : [
		'commitsTable',
		'selectButton',
		'commits',
		'callback'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepCommitSelector class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 2;
		add: #commitsTable;
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #selectButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #accessing }
DepCommitSelector class >> defaultTitle [
	^ 'MrMiner Commit Selector'
]

{ #category : #accessing }
DepCommitSelector class >> preferredExtent [
	^ 500@600
]

{ #category : #accessing }
DepCommitSelector >> callback: aBlock [
	callback := aBlock
]

{ #category : #initialization }
DepCommitSelector >> connectPresenters [
	super connectPresenters.
	
	selectButton action: [
		callback value: commitsTable selectedItem.
		self window close ].
]

{ #category : #initialization }
DepCommitSelector >> initializePresenters [
	super initializePresenters.
	
	commitsTable := self newTable.
	
	selectButton := self newButton
		label: 'Select';
		yourself.
		
	commits ifNotNil: [ self showCommits ].
]

{ #category : #initialization }
DepCommitSelector >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #'accessing model' }
DepCommitSelector >> setModelBeforeInitialization: aCollectionOfCommits [
	commits := aCollectionOfCommits
]

{ #category : #'as yet unclassified' }
DepCommitSelector >> showCommits [
	commitsTable
		columns: { };
		items: commits;
		addColumn: (SpStringTableColumn
			title: 'SHA'
			evaluated: [ :commit | commit shortSha ]);
		addColumn: (SpStringTableColumn
			title: 'Author'
			evaluated: [ :commit | commit author ]);
		addColumn: (SpStringTableColumn
			title: 'Message'
			evaluated: [ :commit | commit message ]);
		addColumn: (SpStringTableColumn
			title: 'Date'
			evaluated: [ :commit | commit date ]);
		addColumn: (SpStringTableColumn
			title: 'Time'
			evaluated: [ :commit | commit time ]);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :commit | ', ' join: commit tags ]).
]
