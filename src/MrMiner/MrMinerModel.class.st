Class {
	#name : #MrMinerModel,
	#superclass : #Object,
	#instVars : [
		'repository',
		'oldVersionCommit',
		'newVersionCommit',
		'oldMethods',
		'newMethods'
	],
	#category : #'MrMiner-Models'
}

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
