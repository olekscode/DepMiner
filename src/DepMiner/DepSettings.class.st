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
