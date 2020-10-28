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
MrMinerController >> candidateCommitsForNewVersion [
	| commits |
	commits := model allCommits.
	
	model oldVersionCommit ifNotNil: [ 
		commits := commits select: [ :commit |
			commit date > model oldVersionCommit date or: [ 
				commit date = model oldVersionCommit date and: [ 
					commit time > model oldVersionCommit time ] ] ] ].
	
	^ commits
]

{ #category : #'as yet unclassified' }
MrMinerController >> candidateCommitsForOldVersion [
	model commitDictionary removeAll.

	model repository branch commits do: [ :iceCommit |
		model commitDictionary at: iceCommit id put: iceCommit asRefrainCommit ].
	
	model repository tags do: [ :tag |
		model commitDictionary
			at: tag commit id
			ifPresent: [ :commit | commit tags add: tag name ] ].
	
	^ model allCommits
]

{ #category : #'as yet unclassified' }
MrMinerController >> getGitHubRepository: aRepositoryName by: anOwnerName [
	[ ^ IceGitHubAPI new
		beAnonymous;
		getRepository: anOwnerName project: aRepositoryName ]
		on: LGitNoCredentialsProvided
		do: [ ^ nil ]
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadAddedMethods [
	model addedMethods: clio addedMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadChanges [
	refrain := Refrain
		repositoryName: model repository name
		branchName: model repository branch name
		firstCommit: model oldVersionCommit sha
		lastCommit: model newVersionCommit sha.
		
	clio := Clio
		for: model repository name
		between: model oldVersionCommit sha
		and: model newVersionCommit sha.
		
	self loadOldVersion.
	self loadNewVersion.
	self loadDeletedMethods.
	self loadAddedMethods.
	self loadUnchangedDeprecatedMethods.
	
	"refrain loadMethodChanges."
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadDeletedMethods [
	model deletedMethods: clio deletedMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadNewVersion [
	model newMethods: clio newMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadOldVersion [
	model oldMethods: clio oldMethods asArray.
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

{ #category : #'as yet unclassified' }
MrMinerController >> loadUnchangedDeprecatedMethods [
	model unchangedDeprecatedMethods: (clio unchangedMethods select: [ :method | method isDeprecated ]) asArray.
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
