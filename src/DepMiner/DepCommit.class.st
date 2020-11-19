Class {
	#name : #DepCommit,
	#superclass : #Object,
	#instVars : [
		'sha',
		'date',
		'time',
		'message',
		'tags',
		'author'
	],
	#category : #'DepMiner-Models'
}

{ #category : #comparing }
DepCommit >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject sha = sha and: [ 
		anObject message = message and: [ 
			anObject tags = tags and: [ 
				anObject date = date and: [
					anObject time = time and: [
						anObject author = author ] ] ] ] ]
]

{ #category : #accessing }
DepCommit >> author [
	^ author
]

{ #category : #accessing }
DepCommit >> author: anObject [
	author := anObject
]

{ #category : #accessing }
DepCommit >> date [
	^ date
]

{ #category : #accessing }
DepCommit >> date: anObject [
	date := anObject
]

{ #category : #comparing }
DepCommit >> hash [
	| fields |
	fields := { sha . message . tags . date . time . author }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #initialization }
DepCommit >> initialize [
	super initialize.
	tags := OrderedCollection new.
]

{ #category : #testing }
DepCommit >> matches: aString [
	"Answer true if a given string matches this commit's SHA, short SHA, or one of its tags"

	^ self sha = aString or: [ 
		  self shortSha = aString or: [ self tags includes: aString ] ]
]

{ #category : #accessing }
DepCommit >> message [
	^ message
]

{ #category : #accessing }
DepCommit >> message: anObject [
	message := anObject
]

{ #category : #printing }
DepCommit >> printOn: aStream [
	aStream nextPutAll: sha
]

{ #category : #accessing }
DepCommit >> sha [
	^ sha
]

{ #category : #accessing }
DepCommit >> sha: anObject [
	sha := anObject
]

{ #category : #'as yet unclassified' }
DepCommit >> shortSha [
	^ sha copyFrom: 1 to: 7
]

{ #category : #'as yet unclassified' }
DepCommit >> tagOrShortSha [
	^ tags
		ifNotEmpty: [ tags anyOne ]
		ifEmpty: [ self shortSha ]
]

{ #category : #accessing }
DepCommit >> tags [
	^ tags
]

{ #category : #accessing }
DepCommit >> tags: anObject [
	tags := anObject
]

{ #category : #accessing }
DepCommit >> time [
	^ time
]

{ #category : #accessing }
DepCommit >> time: anObject [
	time := anObject
]
