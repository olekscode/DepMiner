Class {
	#name : #DepSettings,
	#superclass : #Object,
	#instVars : [
		'ownerName',
		'projectName',
		'oldCommitSha',
		'newCommitSha',
		'minCount',
		'minConfidence'
	],
	#category : #'DepMiner-Models'
}

{ #category : #comparing }
DepSettings >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ minConfidence = anObject minConfidence and: [ 
		  minCount = anObject minCount and: [ 
			  newCommitSha = anObject newCommitSha and: [ 
				  oldCommitSha = anObject oldCommitSha and: [ 
					  ownerName = anObject ownerName and: [ 
						  projectName = anObject projectName ] ] ] ] ]
]

{ #category : #comparing }
DepSettings >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ minConfidence hash bitXor:
		  (minCount hash bitXor: (newCommitSha hash bitXor:
				    (oldCommitSha hash bitXor:
					     (ownerName hash bitXor: projectName hash))))
]

{ #category : #accessing }
DepSettings >> minConfidence [
	^ minConfidence
]

{ #category : #accessing }
DepSettings >> minConfidence: anObject [
	minConfidence := anObject
]

{ #category : #accessing }
DepSettings >> minCount [
	^ minCount
]

{ #category : #accessing }
DepSettings >> minCount: anObject [
	minCount := anObject
]

{ #category : #accessing }
DepSettings >> newCommitSha [
	^ newCommitSha
]

{ #category : #accessing }
DepSettings >> newCommitSha: anObject [
	newCommitSha := anObject
]

{ #category : #accessing }
DepSettings >> oldCommitSha [
	^ oldCommitSha
]

{ #category : #accessing }
DepSettings >> oldCommitSha: anObject [
	oldCommitSha := anObject
]

{ #category : #accessing }
DepSettings >> ownerName [
	^ ownerName
]

{ #category : #accessing }
DepSettings >> ownerName: anObject [
	ownerName := anObject
]

{ #category : #accessing }
DepSettings >> projectName [
	^ projectName
]

{ #category : #accessing }
DepSettings >> projectName: anObject [
	projectName := anObject
]
