Class {
	#name : #MrCommit,
	#superclass : #Object,
	#instVars : [
		'sha',
		'datetime',
		'message',
		'tags',
		'author'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
MrCommit >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject sha = sha and: [ 
		anObject message = message and: [ 
			anObject tags = tags and: [ 
				anObject datetime = datetime and: [ 
					anObject author = author ] ] ] ]
]

{ #category : #accessing }
MrCommit >> author [
	^ author
]

{ #category : #accessing }
MrCommit >> author: anObject [
	author := anObject
]

{ #category : #accessing }
MrCommit >> datetime [
	^ datetime
]

{ #category : #accessing }
MrCommit >> datetime: anObject [
	datetime := anObject
]

{ #category : #comparing }
MrCommit >> hash [
	| fields |
	fields := { sha . message . tags . datetime . author }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #initialization }
MrCommit >> initialize [
	super initialize.
	tags := OrderedCollection new.
]

{ #category : #accessing }
MrCommit >> message [
	^ message
]

{ #category : #accessing }
MrCommit >> message: anObject [
	message := anObject
]

{ #category : #printing }
MrCommit >> printOn: aStream [
	aStream nextPutAll: sha
]

{ #category : #accessing }
MrCommit >> sha [
	^ sha
]

{ #category : #accessing }
MrCommit >> sha: anObject [
	sha := anObject
]

{ #category : #'as yet unclassified' }
MrCommit >> shortSha [
	^ sha copyFrom: 1 to: 7
]

{ #category : #accessing }
MrCommit >> tags [
	^ tags
]

{ #category : #accessing }
MrCommit >> tags: anObject [
	tags := anObject
]
