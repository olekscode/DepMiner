Class {
	#name : #DepMinerController,
	#superclass : #Object,
	#instVars : [
		'settings',
		'projectHistory',
		'recommendations'
	],
	#category : #'DepMiner-Controllers'
}

{ #category : #'as yet unclassified' }
DepMinerController >> buildRulesFrom: aCollectionOfSimpleRules [
	| rules |
	
	rules := aCollectionOfSimpleRules collect: [ :simpleRule | simpleRule asDepAssociationRule ].
	
	self mapRules: rules toMethodChanges: projectHistory relevantMethodChanges.
	
	rules do: [ :rule |
		rule isAutomatable
			ifTrue: [ rule generateTransformationRule ] ].
	
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
	| repository iceCommits |
	
	[ repository := self getRepository ] on: DepRepositoryNotFoundError do: [ :err |
		self inform: err messageText.
		^ self ].
	
	iceCommits := (repository allBranches flatCollect: [ :branch | branch commits ]) asSet.
	projectHistory commitDictionary removeAll.
	
	iceCommits do: [ :iceCommit |
		projectHistory commitDictionary at: iceCommit id put: iceCommit asDepCommit ].
	
	repository tags do: [ :tag |
		projectHistory commitDictionary
			at: tag commit id
			ifPresent: [ :commit | commit tags add: tag name ] ].
]

{ #category : #accessing }
DepMinerController >> getRepository [
	^ IceRepository registry
		detect: [ :repo |
			repo isValid and: [
				repo location path parent basename = settings ownerName and: [
					repo name = settings projectName ] ] ]
		ifNone: [
			DepRepositoryNotFoundError
				signalForOwnerName: settings ownerName
				projectName: settings projectName ].
]

{ #category : #testing }
DepMinerController >> isMethodLoadedIntoTheImage: aMethod [
	"Answer true if the given method can be found in the image"
	
	| methodClass |
	
	methodClass := Smalltalk classNamed: aMethod className.
	methodClass ifNil: [ ^ false ].
	
	[ methodClass methodNamed: aMethod selector asSymbol ]
		on: KeyNotFound
		do: [ ^ false ].
		
	^ true
]

{ #category : #testing }
DepMinerController >> isProjectLoadedAtTheRightVersion [
	"Answer true if the project that is being analysed is loaded into the system at the version specified by newCommitSha"
	
	| repository |
	
	[ repository := self getRepository ]
		on: DepRepositoryNotFoundError
		do: [ ^ false ].
		
	^ repository workingCopy referenceCommit id = settings newCommitSha
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadChanges [
	| repository |
	
	repository := self getRepository.
		
	self loadMethodsFrom: repository.
	self loadMethodChangesFrom: repository.
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
DepMinerController >> loadMethodChangesFrom: aRepository [
	| refrain methodCallCollector |
	
	refrain := Refrain
		repository: aRepository
		firstCommit: settings oldCommitSha
		lastCommit: settings newCommitSha.
	
	methodCallCollector := DepSelectorCollector new
		oldSelectors: projectHistory oldSelectors;
		newSelectors: projectHistory newSelectors;
		yourself.
		
	refrain
		entityCollector: methodCallCollector;
		maxNumberOfAddedAndDeletedEntitiesInMethodChange: 3.
		
	refrain loadMethodChanges.
	
	projectHistory totalNumberOfMethodChanges: refrain methodChanges size.
	projectHistory relevantMethodChanges: refrain relevantMethodChanges.
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadMethodsFrom: aRepository [
	| clio |
	
	clio := Clio
		forRepository: aRepository
		between: settings oldCommitSha
		and: settings newCommitSha.
		
	self loadOldVersionUsing: clio.
	self loadNewVersionUsing: clio.
	self loadModifiedMethodsUsing: clio.
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadModifiedMethodsUsing: aClio [
	| oldMethod newMethod |
	
	aClio modifiedMethods do: [ :assoc |
		oldMethod := assoc key.
		newMethod := assoc value.
		
		projectHistory addMethodIfDoesNotExist: newMethod.
			
		(projectHistory methodDictionary at: newMethod signature)
			markAsModified;
			oldSourceCode: oldMethod sourceCode;
			oldDeprecation: oldMethod deprecation ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadNewVersionUsing: aClio [
	aClio newMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsNewMethod ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadOldVersionUsing: aClio [
	aClio oldMethods do: [ :method |
		projectHistory addMethodIfDoesNotExist: method.
			
		(projectHistory methodDictionary at: method signature)
			markAsOldMethod ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadProject [
	self extractAllCommitsFromRepository.
	
]

{ #category : #'as yet unclassified' }
DepMinerController >> mapRules: aCollectionOfRules toMethodChanges: aCollectionOfMethodChanges [
	aCollectionOfRules do: [ :rule |
		rule methodChanges: (aCollectionOfMethodChanges select: [ :methodChange |
			(methodChange deletedEntities asArray includesAll: rule deletedMethodCalls) and: [ 
				methodChange addedEntities asArray includesAll: rule addedMethodCalls ] ]) ]
]

{ #category : #'as yet unclassified' }
DepMinerController >> mineRules [
	| repository refrain rules |
	
	repository := self getRepository.
	
	refrain := Refrain
		repository: repository
		firstCommit: settings oldCommitSha
		lastCommit: settings newCommitSha.
	
	refrain
		relevantMethodChanges: projectHistory relevantMethodChanges;
		minNumberOfRepetitions: settings minCount.
		
	refrain mineRules.
	
	rules := refrain rules select: [ :rule | rule confidence >= settings minConfidence ].
	recommendations rules: (self buildRulesFrom: rules).
	
	self recommendMethodsToDeprecate.
	self recommendMethodsWithMissingRules.
]

{ #category : #accessing }
DepMinerController >> projectHistory: anObject [
	projectHistory := anObject
]

{ #category : #'as yet unclassified' }
DepMinerController >> recommendMethodsToDeprecate [
	| methodsToDeprecate methodsInNewVersion depRecommendations |
	
	methodsToDeprecate := projectHistory sortedMethods select: [ :method |
		method wasDeleted and: [
			method isDeprecated not and: [
				recommendations relevantRules anySatisfy: [ :rule |
					rule deletedMethodCalls anyOne selector = method selector ] ] ] ].
	
	methodsInNewVersion := projectHistory sortedMethods select: [ :method |
		method isInNewVersion ].
	
	depRecommendations := methodsToDeprecate collect: [ :method |
		method asDepRecommendation
			chooseApplicableRulesFrom: recommendations relevantRules
			basedOn: methodsInNewVersion;
			yourself ].
		
	recommendations methodsToDeprecate: depRecommendations.
]

{ #category : #'as yet unclassified' }
DepMinerController >> recommendMethodsWithMissingRules [
	| methodsWithMissingRules methodsInNewVersion depRecommendations |
	
	methodsInNewVersion := projectHistory sortedMethods select: [ :method |
		method isInNewVersion ].
	
	methodsWithMissingRules := methodsInNewVersion select: [ :method |
		method isDeprecated and: [ method hasTransformationRule not ] ].
	
	depRecommendations := methodsWithMissingRules collect: [ :method |
		method asDepRecommendation
			chooseApplicableRulesFrom: recommendations relevantRules
			basedOn: methodsInNewVersion;
			yourself ].
		
	recommendations methodsWithMissingRules: depRecommendations.
]

{ #category : #accessing }
DepMinerController >> recommendations: anObject [
	recommendations := anObject
]

{ #category : #accessing }
DepMinerController >> settings: anObject [
	settings := anObject
]
