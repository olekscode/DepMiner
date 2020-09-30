Class {
	#name : #MrExperiment,
	#superclass : #Object,
	#instVars : [
		'repositoryName',
		'repositoryUrl',
		'branchName',
		'fromCommit',
		'toCommit',
		'minCount',
		'minConfidence',
		'numberOfTransactions',
		'rules',
		'feedbackAuthor'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #accessing }
MrExperiment >> branchName [
	^ branchName
]

{ #category : #accessing }
MrExperiment >> branchName: anObject [
	branchName := anObject
]

{ #category : #accessing }
MrExperiment >> feedbackAuthor [
	^ feedbackAuthor
]

{ #category : #accessing }
MrExperiment >> feedbackAuthor: anObject [
	feedbackAuthor := anObject
]

{ #category : #accessing }
MrExperiment >> fromCommit [
	^ fromCommit
]

{ #category : #accessing }
MrExperiment >> fromCommit: anObject [
	fromCommit := anObject
]

{ #category : #accessing }
MrExperiment >> minConfidence [
	^ minConfidence
]

{ #category : #accessing }
MrExperiment >> minConfidence: anObject [
	minConfidence := anObject
]

{ #category : #accessing }
MrExperiment >> minCount [
	^ minCount
]

{ #category : #accessing }
MrExperiment >> minCount: anObject [
	minCount := anObject
]

{ #category : #accessing }
MrExperiment >> numberOfTransactions [
	^ numberOfTransactions
]

{ #category : #accessing }
MrExperiment >> numberOfTransactions: anObject [
	numberOfTransactions := anObject
]

{ #category : #accessing }
MrExperiment >> repositoryName [
	^ repositoryName
]

{ #category : #accessing }
MrExperiment >> repositoryName: anObject [
	repositoryName := anObject
]

{ #category : #accessing }
MrExperiment >> repositoryUrl [
	^ repositoryUrl
]

{ #category : #accessing }
MrExperiment >> repositoryUrl: anObject [
	repositoryUrl := anObject
]

{ #category : #accessing }
MrExperiment >> rules [
	^ rules
]

{ #category : #accessing }
MrExperiment >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
MrExperiment >> toCommit [
	^ toCommit
]

{ #category : #accessing }
MrExperiment >> toCommit: anObject [
	toCommit := anObject
]
