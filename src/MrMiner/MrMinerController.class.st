Class {
	#name : #MrMinerController,
	#superclass : #Object,
	#instVars : [
		'settings',
		'projectHistory',
		'recommendations',
		'repository',
		'refrain',
		'clio'
	],
	#category : #'MrMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMinerController >> candidateCommitsForNewVersion [
	| commits |
	
	commits := projectHistory sortedCommits.
	
	projectHistory commitDictionary
		at: settings oldCommitSha
		ifPresent: [ :oldCommit |
			commits := commits select: [ :commit |
				commit date > oldCommit date or: [ 
					commit date = oldCommit date and: [ 
						commit time > oldCommit time ] ] ] ].
	^ commits
]

{ #category : #'as yet unclassified' }
MrMinerController >> candidateCommitsForOldVersion [
	^ projectHistory sortedCommits
]

{ #category : #'as yet unclassified' }
MrMinerController >> extractAllCommitsFromRepository [
	| iceCommits |
	
	iceCommits := (repository allBranches flatCollect: [ :branch | branch commits ]) asSet.
	projectHistory commitDictionary removeAll.
	
	iceCommits do: [ :iceCommit |
		projectHistory commitDictionary at: iceCommit id put: iceCommit asDepCommit ].
	
	repository tags do: [ :tag |
		projectHistory commitDictionary
			at: tag commit id
			ifPresent: [ :commit | commit tags add: tag name ] ].
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadChanges [
	refrain := Refrain
		repository: repository
		firstCommit: settings oldCommitSha
		lastCommit: settings newCommitSha.
		
	clio := Clio
		forRepository: repository
		between: settings oldCommitSha
		and: settings newCommitSha.
		
	self loadOldVersion.
	self loadNewVersion.
	self loadModifiedMethods.
	
	refrain loadMethodChanges.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadGitHubRepository [
	[ ^ IceGitHubAPI new
		beAnonymous;
		getRepository: settings ownerName project: settings projectName ]
		on: LGitNoCredentialsProvided
		do: [ ^ nil ]
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadModifiedMethods [
	| oldMethod newMethod |
	
	clio modifiedMethods do: [ :assoc |
		oldMethod := assoc key.
		newMethod := assoc value.
		
		projectHistory addMethodIfDoesNotExist: newMethod.
			
		(projectHistory methodDictionary at: newMethod signature)
			markAsModified;
			oldSourceCode: oldMethod sourceCode;
			oldAst: oldMethod ast;
			oldDeprecation: oldMethod deprecation ].
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadNewVersion [
	clio newMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsNewMethod ].
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadOldVersion [
	clio oldMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsOldMethod ].
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadProject [
	"Load a project from GitHub or select the existing one"
	
	repository := IceRepository registry
		detect: [ :repo |
			repo isValid and: [
				repo location path parent basename = settings ownerName and: [
					repo name = settings projectName ] ] ]
		ifFound: [ :repo | repo ]
		ifNone: [ self loadGitHubRepository ].
		
	self extractAllCommitsFromRepository.
	
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

{ #category : #'as yet unclassified' }
MrMinerController >> mineRulesWithMinCount: aMinCount minConfidence: aMinConfidence [
	refrain minNumberOfRepetitions: aMinCount.
	refrain mineRules.
	
	recommendations rules: (refrain rules select: [ :rule | rule confidence >= aMinConfidence ]).
]

{ #category : #accessing }
MrMinerController >> projectHistory: anObject [
	projectHistory := anObject
]

{ #category : #accessing }
MrMinerController >> recommendations: anObject [
	recommendations := anObject
]

{ #category : #accessing }
MrMinerController >> settings: anObject [
	settings := anObject
]
