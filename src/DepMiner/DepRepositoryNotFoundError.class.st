Class {
	#name : #DepRepositoryNotFoundError,
	#superclass : #Error,
	#instVars : [
		'ownerName',
		'projectName'
	],
	#category : #'DepMiner-Exceptions'
}

{ #category : #signalling }
DepRepositoryNotFoundError class >> signalForOwnerName: anOwnerName projectName: aProjectName [
	^ self new
		ownerName: anOwnerName;
		projectName: aProjectName;
		signal.
]

{ #category : #accessing }
DepRepositoryNotFoundError >> messageText [
	^ messageText ifNil: [ messageText := self standardMessageText ]
]

{ #category : #accessing }
DepRepositoryNotFoundError >> ownerName: anObject [
	ownerName := anObject
]

{ #category : #accessing }
DepRepositoryNotFoundError >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
DepRepositoryNotFoundError >> standardMessageText [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'The repository ';
			nextPutAll: ownerName;
			nextPut: $/;
			nextPutAll: projectName;
			nextPutAll: ' was not found in the system. Please load it with Iceberg' ]
]
