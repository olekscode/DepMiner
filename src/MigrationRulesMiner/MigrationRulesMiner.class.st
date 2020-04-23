Class {
	#name : #MigrationRulesMiner,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'fromCommit',
		'toCommit',
		'commits',
		'failedCommits',
		'diffs'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MigrationRulesMiner >> branch [
	^ branch
]

{ #category : #accessing }
MigrationRulesMiner >> branchNamed: aBranchName [
	repository ifNil: [ Error signal: 'You must specify the repository first' ].
	branch := repository branchNamed: aBranchName.
]

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> calculateDiffs [
	failedCommits := OrderedCollection new.
	diffs := OrderedCollection new.

	commits
		do: [ :commit |
			[ diffs add: (commit diffTo: commit parent) ]
				on: Exception
				do: [ failedCommits add: commit ] ]
		displayingProgress: [ :commit | commit id ].
]

{ #category : #accessing }
MigrationRulesMiner >> commits [ 
	^ commits
]

{ #category : #accessing }
MigrationRulesMiner >> diffs [
	^ diffs
]

{ #category : #accessing }
MigrationRulesMiner >> failedCommits [
	^ failedCommits
]

{ #category : #accessing }
MigrationRulesMiner >> fromCommit [
	^ fromCommit
]

{ #category : #accessing }
MigrationRulesMiner >> fromCommitId: aCommitId [
	fromCommit := branch commits
		detect: [ :commit | commit id = aCommitId ]
		ifNone: [ Error signal: 'Commit with this ID was not found' ]
]

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> loadCommits [
	| commitWalk |
	
	commitWalk := (IceLibgitCommitWalk forRepository: repository)
		fromCommit: fromCommit;
		uptoCommit: toCommit;
		yourself.
		
	commits := OrderedCollection new.
	commitWalk commitsDo: [ :commit | commits add: commit ].
	
]

{ #category : #accessing }
MigrationRulesMiner >> repository [
	^ repository
]

{ #category : #accessing }
MigrationRulesMiner >> repositoryNamed: aRepositoryName [
	repository := IceRepository registry
		detect: [ :repo | repo name = aRepositoryName ]
		ifNone: [ Error signal: 'Repository named ''', aRepositoryName, '''was not found.' ].
]

{ #category : #accessing }
MigrationRulesMiner >> toCommit [
	^ toCommit
]

{ #category : #accessing }
MigrationRulesMiner >> toCommitId: aCommitId [
	toCommit := branch commits
		detect: [ :commit | commit id = aCommitId ]
		ifNone: [ Error signal: 'Commit with this ID was not found' ]
]
