Class {
	#name : #MrMinerModel,
	#superclass : #Object,
	#instVars : [
		'repository',
		'commitDictionary',
		'oldVersionCommit',
		'newVersionCommit',
		'oldMethods',
		'newMethods',
		'deletedMethods',
		'addedMethods',
		'oldDeprecatedMethods',
		'newDeprecatedMethods',
		'unchangedDeprecatedMethods',
		'rules',
		'methodsToDeprecate'
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

{ #category : #'as yet unclassified' }
MrMinerModel >> allCommits [
	^ commitDictionary values
]

{ #category : #accessing }
MrMinerModel >> commitDictionary [
	^ commitDictionary
]

{ #category : #accessing }
MrMinerModel >> deletedMethods [
	^ deletedMethods
]

{ #category : #accessing }
MrMinerModel >> deletedMethods: anObject [
	deletedMethods := anObject
]

{ #category : #initialization }
MrMinerModel >> initialize [
	super initialize.
	commitDictionary := Dictionary new.
]

{ #category : #accessing }
MrMinerModel >> newDeprecatedMethods [
	^ newDeprecatedMethods
]

{ #category : #accessing }
MrMinerModel >> newDeprecatedMethods: anObject [
	newDeprecatedMethods := anObject
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
MrMinerModel >> oldDeprecatedMethods [
	^ oldDeprecatedMethods
]

{ #category : #accessing }
MrMinerModel >> oldDeprecatedMethods: anObject [
	oldDeprecatedMethods := anObject
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

{ #category : #accessing }
MrMinerModel >> rules [
	^ rules
]

{ #category : #accessing }
MrMinerModel >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
MrMinerModel >> unchangedDeprecatedMethods [
	^ unchangedDeprecatedMethods
]

{ #category : #accessing }
MrMinerModel >> unchangedDeprecatedMethods: anObject [
	unchangedDeprecatedMethods := anObject
]
