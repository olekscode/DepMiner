Class {
	#name : #DepMinerController,
	#superclass : #Object,
	#instVars : [
		'settings',
		'projectHistory',
		'recommendations',
		'repository',
		'refrain',
		'clio'
	],
	#category : #'DepMiner-Controllers'
}

{ #category : #'as yet unclassified' }
DepMinerController >> buildRulesFrom: aCollectionOfSimpleRules [
	| rules rulesBuilder |
	
	rules := aCollectionOfSimpleRules collect: [ :simpleRule | simpleRule asDepAssociationRule ].
	
	rulesBuilder := DepRulesBuilder new.
	rulesBuilder mapRules: rules toMethodChanges: projectHistory relevantMethodChanges.
	
	rules do: [ :rule |
		(rulesBuilder canGenerateTransformationRuleFrom: rule) ifTrue: [ 
			rule transformationRule: (rulesBuilder generateTransformationRuleFrom: rule) ] ].
	
	^ rules
]

{ #category : #'as yet unclassified' }
DepMinerController >> candidateCommitsForNewVersion [
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
DepMinerController >> candidateCommitsForOldVersion [
	^ projectHistory sortedCommits
]

{ #category : #'as yet unclassified' }
DepMinerController >> extractAllCommitsFromRepository [
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
DepMinerController >> loadChanges [
	| methodCallCollector |
		
	clio := Clio
		forRepository: repository
		between: settings oldCommitSha
		and: settings newCommitSha.
		
	self loadOldVersion.
	self loadNewVersion.
	self loadModifiedMethods.
	
	refrain := Refrain
		repository: repository
		firstCommit: settings oldCommitSha
		lastCommit: settings newCommitSha.
	
	methodCallCollector := DepSelectorCollector new
		oldSelectors: (clio oldMethods collect: [ :method | method selector ]);
		newSelectors: (clio newMethods collect: [ :method | method selector ]);
		yourself.
		
	refrain entityCollector: methodCallCollector.
	refrain loadMethodChanges.
	
	projectHistory methodChanges: refrain methodChanges.
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadGitHubRepository [
	[ ^ IceGitHubAPI new
		beAnonymous;
		getRepository: settings ownerName project: settings projectName ]
		on: LGitNoCredentialsProvided
		do: [ ^ nil ]
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadModifiedMethods [
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
DepMinerController >> loadNewVersion [
	clio newMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsNewMethod ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadOldVersion [
	clio oldMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsOldMethod ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadProject [
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
DepMinerController >> mineRulesWithMinCount: aMinCount minConfidence: aMinConfidence [
	| rules |
	refrain minNumberOfRepetitions: aMinCount.
	refrain mineRules.
	
	rules := refrain rules select: [ :rule | rule confidence >= aMinConfidence ].
	recommendations rules: (self buildRulesFrom: rules).
]

{ #category : #accessing }
DepMinerController >> projectHistory: anObject [
	projectHistory := anObject
]

{ #category : #accessing }
DepMinerController >> recommendations: anObject [
	recommendations := anObject
]

{ #category : #accessing }
DepMinerController >> settings: anObject [
	settings := anObject
]
