Class {
	#name : #MrCommitPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'commit',
		'shaLabel',
		'messageLabel',
		'authorDateLabel'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #shaLabel height: self labelHeight;
		add: #messageLabel height: self labelHeight;
		add: #authorDateLabel height: self labelHeight;
		yourself.
]

{ #category : #accessing }
MrCommitPresenter >> commit: aCommit [
	commit := aCommit.
	self showCommit.
]

{ #category : #initialization }
MrCommitPresenter >> initializePresenters [ 
	shaLabel := self newLabel.
	messageLabel := self newLabel.
	authorDateLabel := self newLabel.
	
	commit ifNotNil: [ self showCommit ].
]

{ #category : #accessing }
MrCommitPresenter >> messageLabel [
	^ messageLabel
]

{ #category : #'accessing model' }
MrCommitPresenter >> setModelBeforeInitialization: aCommit [
	commit := aCommit
]

{ #category : #accessing }
MrCommitPresenter >> shaLabel [
	^ shaLabel
]

{ #category : #'as yet unclassified' }
MrCommitPresenter >> showCommit [
	shaLabel label: (commit sha,
		(commit tags ifEmpty: [ '' ] ifNotEmpty: [ '(', (', ' join: commit tags), ')' ])).
	messageLabel label: commit message.
	authorDateLabel label: ('by ', commit author, ' on ', commit datetime asString).	
]
