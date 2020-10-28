Class {
	#name : #MrMinerModel,
	#superclass : #Object,
	#instVars : [
		'repository',
		'oldVersionCommit',
		'newVersionCommit',
		'oldMethods',
		'newMethods',
		'deletedMethods',
		'addedMethods'
	],
	#category : #'MrMiner-Models'
}

{ #category : #accessing }
MrMinerModel >> addedMethods [
	^ addedMethods
]

{ #category : #accessing }
MrMinerModel >> addedMethods: anObject [
	addedMethods := anObject
]

{ #category : #accessing }
MrMinerModel >> deletedMethods [
	^ deletedMethods
]

{ #category : #accessing }
MrMinerModel >> deletedMethods: anObject [
	deletedMethods := anObject
]

{ #category : #accessing }
MrMinerModel >> newMethods [
	^ newMethods
]

{ #category : #accessing }
MrMinerModel >> newMethods: anObject [
	newMethods := anObject
]

{ #category : #accessing }
MrMinerModel >> newVersionCommit [
	^ newVersionCommit
]

{ #category : #accessing }
MrMinerModel >> newVersionCommit: anObject [
	newVersionCommit := anObject
]

{ #category : #accessing }
MrMinerModel >> oldMethods [
	^ oldMethods
]

{ #category : #accessing }
MrMinerModel >> oldMethods: anObject [
	oldMethods := anObject
]

{ #category : #accessing }
MrMinerModel >> oldVersionCommit [
	^ oldVersionCommit
]

{ #category : #accessing }
MrMinerModel >> oldVersionCommit: anObject [
	oldVersionCommit := anObject
]

{ #category : #accessing }
MrMinerModel >> repository [
	^ repository
]

{ #category : #accessing }
MrMinerModel >> repository: anObject [
	repository := anObject
]
