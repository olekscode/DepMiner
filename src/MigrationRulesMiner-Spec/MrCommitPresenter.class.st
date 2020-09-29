Class {
	#name : #MrCommitPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'commit',
		'shaLabel',
		'messageLabel',
		'authorLabel',
		'tagsLabel',
		'datetimeLabel'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #shaLabel;
		add: #messageLabel;
		add: #authorLabel;
		add: #tagsLabel;
		add: #datetimeLabel;
		yourself.
]

{ #category : #accessing }
MrCommitPresenter >> authorLabel [
	^ authorLabel
]

{ #category : #accessing }
MrCommitPresenter >> datetimeLabel [
	^ datetimeLabel
]

{ #category : #initialization }
MrCommitPresenter >> initializePresenters [ 
	shaLabel := self newLabel.
	messageLabel := self newLabel.
	authorLabel := self newLabel.
	tagsLabel := self newLabel.
	datetimeLabel := self newLabel.
	
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
	shaLabel label: commit sha.
	messageLabel label: commit message.
	authorLabel label: commit author.	
	tagsLabel label: (', ' join: commit tags).
	datetimeLabel label: commit datetime asString.
]

{ #category : #accessing }
MrCommitPresenter >> tagsLabel [
	^ tagsLabel
]
