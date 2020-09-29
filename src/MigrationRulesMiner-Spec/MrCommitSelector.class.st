Class {
	#name : #MrCommitSelector,
	#superclass : #SpPresenter,
	#instVars : [
		'commitTable',
		'selectButton',
		'commits'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitSelector class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 2;
		add: #commitTable;
		add: #selectButton height: self buttonHeight;
		yourself.
]

{ #category : #accessing }
MrCommitSelector class >> defaultTitle [
	^ 'Select commits'
]

{ #category : #accessing }
MrCommitSelector class >> preferredExtent [
	^ 700@400
]

{ #category : #accessing }
MrCommitSelector >> commitTable [
	^ commitTable
]

{ #category : #initialization }
MrCommitSelector >> connectPresenters [
	self showCommits.
]

{ #category : #initialization }
MrCommitSelector >> initializePresenters [ 
	commitTable := self newTable.
	
	selectButton := self newButton
		label: 'Select';
		yourself.
]

{ #category : #initialization }
MrCommitSelector >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #accessing }
MrCommitSelector >> selectButton [
	^ selectButton
]

{ #category : #initialization }
MrCommitSelector >> setModelBeforeInitialization: aCollectionOfCommits [
	commits := aCollectionOfCommits
]

{ #category : #initialization }
MrCommitSelector >> showCommits [
	commitTable
		columns: { };
		items: commits;
		addColumn: (SpStringTableColumn
			title: 'SHA'
			evaluated: [ :each | each sha copyFrom: 1 to: 7 ]);
		addColumn: (SpStringTableColumn
			title: 'Message'
			evaluated: [ :each | each message ]);
		addColumn: (SpStringTableColumn
			title: 'Author'
			evaluated: [ :each | each author ]);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ', ' join: each tags ]);
		addColumn: (SpStringTableColumn 
			title: 'Datetime'
			evaluated: [ :each | each datetime asString ])
]
