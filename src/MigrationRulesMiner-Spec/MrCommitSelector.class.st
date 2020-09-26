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

{ #category : #'as yet unclassified' }
MrCommitSelector class >> forCommits: aCollectionOfCommits [
	^ self new initializeCommits: aCollectionOfCommits; yourself.
]

{ #category : #accessing }
MrCommitSelector >> commitTable [
	^ commitTable
]

{ #category : #initialization }
MrCommitSelector >> connectPresenters [
	selectButton action: [ self showCommits ].
]

{ #category : #initialization }
MrCommitSelector >> initializeCommits: aCollectionOfCommits [
	commits := aCollectionOfCommits
]

{ #category : #initialization }
MrCommitSelector >> initializePresenters [ 
	commitTable := self newTable.
	
	selectButton := self newButton
		label: 'Select';
		yourself.
]

{ #category : #accessing }
MrCommitSelector >> selectButton [
	^ selectButton
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
			title: 'Tag'
			evaluated: [ :each | each tag ifNil: [ '' ] ifNotNil: [ each tag ] ]);
		addColumn: (SpStringTableColumn 
			title: 'Datetime'
			evaluated: [ :each | each datetime asString ])
]
