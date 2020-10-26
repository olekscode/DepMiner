Class {
	#name : #MrMinerController,
	#superclass : #Object,
	#instVars : [
		'model',
		'refrain',
		'clio'
	],
	#category : #'MrMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMinerController class >> repository: aRepositoryName branch: aBranchName oldCommit: anOldCommitSha newCommit: aNewCommitSha [
	^ self new
		initializeRepository: aRepositoryName
		branch: aBranchName
		oldCommit: anOldCommitSha
		newCommit: aNewCommitSha;
		yourself.
]

{ #category : #'as yet unclassified' }
MrMinerController >> deletedDeprecatedMethods [
	^ clio deletedMethods select: [ :each | each isDeprecated ]
]

{ #category : #'as yet unclassified' }
MrMinerController >> getGitHubRepository: aRepositoryName by: anOwnerName [
	[ ^ IceGitHubAPI new
		beAnonymous;
		getRepository: anOwnerName project: aRepositoryName ]
		on: LGitNoCredentialsProvided
		do: [ ^ nil ]
]

{ #category : #initialization }
MrMinerController >> initializeRepository: aRepositoryName branch: aBranchName oldCommit: anOldCommitSha newCommit: aNewCommitSha [
	
	refrain := Refrain
		repositoryName: aRepositoryName
		branchName: aBranchName
		firstCommit: anOldCommitSha
		lastCommit: aNewCommitSha.
		
	clio := Clio
		for: aRepositoryName
		between: anOldCommitSha
		and: aNewCommitSha. 
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadProject: aProjectName by: anOwnerName [
	| repository |
	
	repository := IceRepository registry
		detect: [ :repo |
			repo isValid and: [
				repo location path parent basename = anOwnerName and: [
					repo name = aProjectName ] ] ]
		ifFound: [ :repo | repo ]
		ifNone: [ self getGitHubRepository: aProjectName by: anOwnerName ].
		
	model repository: repository.
]

{ #category : #accessing }
MrMinerController >> minNumberOfRepetitions: aNumber [
	refrain minNumberOfRepetitions: aNumber
]

{ #category : #'as yet unclassified' }
MrMinerController >> mineRules [
	| methodCallCollector |
	
	methodCallCollector := MrMinerSelectorCollector new
		oldSelectors: (clio oldMethods collect: [ :method | method selector ]);
		newSelectors: (clio newMethods collect: [ :method | method selector ]);
		yourself.
		
	refrain entityCollector: methodCallCollector.
	^ refrain mineRepetitiveChanges.
]

{ #category : #accessing }
MrMinerController >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
MrMinerController >> newMethods [
	^ clio newMethods
]

{ #category : #'as yet unclassified' }
MrMinerController >> oldMethods [
	^ clio oldMethods
]

{ #category : #'as yet unclassified' }
MrMinerController >> preservedDeprecatedMethods [
	^ clio unchangedMethods select: [ :each | each isDeprecated ]
]
