Class {
	#name : #MrCommitPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'commit',
		'descriptionText'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrCommitPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #descriptionText;
		yourself.
]

{ #category : #accessing }
MrCommitPresenter >> commit: aCommit [
	commit := aCommit.
	self showCommit.
]

{ #category : #initialization }
MrCommitPresenter >> initializePresenters [ 
	descriptionText := self newText.
]

{ #category : #'as yet unclassified' }
MrCommitPresenter >> showCommit [
	| description |
	
	description := String streamContents: [ :stream |
		stream nextPutAll: commit sha.
		
		commit tags ifNotEmpty: [ 
			stream
				space;
				nextPut: $(;
				nextPutAll: (', ' join: commit tags);
				nextPut: $) ].
			
		stream
			cr;
			nextPutAll: commit message; cr;
			nextPutAll: 'by ';
			nextPutAll: commit author;
			nextPutAll: ' on ';
			nextPutAll: commit datetime asString ].
		
	descriptionText text: description.
	
		
]
