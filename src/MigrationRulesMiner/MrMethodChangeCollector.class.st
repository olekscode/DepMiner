Class {
	#name : #MrMethodChangeCollector,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'failedCommits'
	],
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMethodChangeCollector class >> forRepository: aRepository branch: aBranch [
	^ self new initializeRepository: aRepository branch: aBranch; yourself. 
]

{ #category : #private }
MrMethodChangeCollector >> calculateDiffsForCommits: aCollectionOfIceCommits [
	| commit diffs |
	failedCommits := OrderedCollection new.
	diffs := OrderedCollection new.

	(1 to: aCollectionOfIceCommits size - 1)
		do: [ :i |
			commit := aCollectionOfIceCommits at: i.
			[ diffs add: (commit diffTo: commit parent) ]
				on: Exception
				do: [ failedCommits add: commit ] ]
		displayingProgress: [ :i | i asString, ' / ', aCollectionOfIceCommits size asString ].
		
	^ diffs
]

{ #category : #public }
MrMethodChangeCollector >> collectMethodChangesFromCommit: anOldestCommit toCommit: aNewestCommit [
	| oldestIceCommit newestIceCommit commits diffs |
	
	oldestIceCommit := self iceCommitFromSha: anOldestCommit sha.
	newestIceCommit := self iceCommitFromSha: aNewestCommit sha.
	
	commits := self loadIceCommitsFrom: oldestIceCommit to: newestIceCommit.
	diffs := self calculateDiffsForCommits: commits.
	
	^ self extractMethodChangesFromDiffs: diffs.
]

{ #category : #private }
MrMethodChangeCollector >> extractMethodChangesFromDiff: aDiff [
	| methodOperations |
	methodOperations := self extractOperationsFromDiff: aDiff.

	^ methodOperations
		select: [ :each | each isMethodChange ]
		thenCollect: [ :each |
			each asMethodChange
				commit: aDiff sourceVersion asMrCommit;
				yourself. ].
]

{ #category : #private }
MrMethodChangeCollector >> extractMethodChangesFromDiffs: aCollectionOfDiffs [
	| nonEmptyDiffs |
	
	nonEmptyDiffs := aCollectionOfDiffs reject: [ :diff |
		diff tree isEmptyNode ].
	
	^ nonEmptyDiffs flatCollect: [ :diff |
		self extractMethodChangesFromDiff: diff ].
]

{ #category : #private }
MrMethodChangeCollector >> extractOperationsFromDiff: aDiff [
	| packageNodes classNodes methodNodes |
	
	packageNodes := aDiff tree children first children.
	classNodes := packageNodes flatCollect: [ :node |node children ].
	methodNodes := classNodes flatCollect: [ :node | node children ].
	^ methodNodes collect: [ :node | node value ].
]

{ #category : #private }
MrMethodChangeCollector >> iceCommitFromSha: aCommitSha [
	^ branch commits
		detect: [ :commit | commit id = aCommitSha ]
		ifNone: [ Error signal: 'Commit with this SHA was not found' ]
]

{ #category : #initialization }
MrMethodChangeCollector >> initializeRepository: aRepository branch: aBranch [
	repository := aRepository.
	branch := aBranch.
	^ self
]

{ #category : #public }
MrMethodChangeCollector >> loadAllCommits [
	^ branch commits collect: [ :commit |
		commit asMrCommit ]
]

{ #category : #private }
MrMethodChangeCollector >> loadIceCommitsFrom: anOldestIceCommit to: aNewestIceCommit [
	| commits commitWalk |
	
	commitWalk := (IceLibgitCommitWalk forRepository: repository)
		fromCommit: anOldestIceCommit;
		uptoCommit: aNewestIceCommit;
		yourself.
		
	commits := OrderedCollection new.
	commitWalk commitsDo: [ :commit | commits add: commit ].
	commits add: aNewestIceCommit.
	
	^ commits
]