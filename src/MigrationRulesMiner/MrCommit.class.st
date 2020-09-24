Class {
	#name : #MrCommit,
	#superclass : #Object,
	#instVars : [
		'sha',
		'tag',
		'datetime',
		'message'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #comparing }
MrCommit >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject sha = sha and: [ 
		anObject message = message and: [ 
			anObject tag = tag and: [ 
				anObject datetime = datetime ] ] ]
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
	fields := { sha . message . tag . datetime }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
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

{ #category : #accessing }
MrCommit >> tag [
	^ tag
]

{ #category : #accessing }
MrCommit >> tag: anObject [
	tag := anObject
]
