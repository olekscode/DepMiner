Class {
	#name : #MrCommitPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'commit',
		'propertiesTable',
		'messageText'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 4;
		add: #propertiesTable;
		add: #messageText;
		yourself.
]

{ #category : #accessing }
MrCommitPresenter >> commit: aCommit [
	commit := aCommit.
	self showCommit.
]

{ #category : #initialization }
MrCommitPresenter >> initializePresenters [
	super initializePresenters.

	propertiesTable := self newTable.
	messageText := self newText.
	
	propertiesTable hideColumnHeaders.
	messageText beNotEditable.
]

{ #category : #accessing }
MrCommitPresenter >> messageText [
	^ messageText
]

{ #category : #accessing }
MrCommitPresenter >> propertiesTable [
	^ propertiesTable
]

{ #category : #'as yet unclassified' }
MrCommitPresenter >> showCommit [
	messageText text: commit message.
	self showPropertiesTable.
]

{ #category : #'as yet unclassified' }
MrCommitPresenter >> showPropertiesTable [
	| rows |
	rows := OrderedCollection new.
	
	rows add: { 'SHA' . commit sha }.
	rows add: { 'author' . commit author }.
	
	commit tags ifNotEmpty: [ 
		rows add: { 'tags' . (', ' join: commit tags) } ].
	
	rows add: { 'date' . commit datetime asDate }.
	rows add: { 'time' . commit datetime asTime }.
	
	propertiesTable
		items: rows;
		columns: { };
		addColumn: ((SpStringTableColumn
			title: 'Property'
			evaluated: [ :each | each first ]) width: 100; yourself);
		addColumn: (SpStringTableColumn
			title: 'Value'
			evaluated: [ :each | each second ]).
]
