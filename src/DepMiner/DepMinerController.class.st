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

{ #category : #adding }
DepMinerController >> addMethod: aMethod ifDoesNotExistInto: aMethodDictionary [
	aMethodDictionary at: aMethod signature
		ifAbsentPut: [ aMethod asDepMethod ]
]

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
	| clio methodDictionary |
	
	clio := Clio
		forRepository: aRepository
		between: settings oldCommitSha
		and: settings newCommitSha.
		
	methodDictionary := Dictionary new.
		
	self loadNewVersionInto: methodDictionary using: clio.
	self loadOldVersionInto: methodDictionary using: clio.
	self loadModifiedMethodsInto: methodDictionary using: clio.
	
	projectHistory methods: (methodDictionary values sorted: [ :a :b |
		a signature < b signature ]).
	
	projectHistory extractNewVersionClassSelectors.
	projectHistory extractNewVersionClassPackages.
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadModifiedMethodsInto: aMethodDictionary using: aClio [
	| oldMethod newMethod |
	
	aClio modifiedMethods do: [ :assoc |
		oldMethod := assoc key.
		newMethod := assoc value.
		
		self addMethod: newMethod ifDoesNotExistInto: aMethodDictionary.
			
		(aMethodDictionary at: newMethod signature)
			markAsModified;
			oldSourceCode: oldMethod sourceCode;
			oldDeprecation: oldMethod deprecation ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadNewVersionInto: aMethodDictionary using: aClio [
	aClio newMethods do: [ :method |
		self addMethod: method ifDoesNotExistInto: aMethodDictionary.
			
		(aMethodDictionary at: method signature)
			markAsNewMethod ].
]

{ #category : #'as yet unclassified' }
DepMinerController >> loadOldVersionInto: aMethodDictionary using: aClio [
	aClio oldMethods do: [ :method |
		self addMethod: method ifDoesNotExistInto: aMethodDictionary.
			
		(aMethodDictionary at: method signature)
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
	| methodsToDeprecate depRecommendations newMethod relevantSelectors |
	
	methodsToDeprecate := projectHistory methods select: [ :method |
		method wasDeleted and: [
			method isDeprecated not and: [
				projectHistory classNamesInNewVersion includes: method className ] ] ].
	
	"There must be at least one rule that can be applied to this method"
	methodsToDeprecate := methodsToDeprecate select: [ :method |
		recommendations relevantRules anySatisfy: [ :rule |
			rule deletedMethodCalls anyOne selector = method selector ] ].
	
	depRecommendations := methodsToDeprecate collect: [ :method |
		newMethod := method copy;
			packageName: (projectHistory newVersionClassPackagesDictionary at: method className);
			yourself.
			
		relevantSelectors := (Smalltalk classNamed: method className)
			ifNotNil: [ :aClass | aClass allMethods collect: [ :each | each selector ] ]
			ifNil: [ projectHistory newVersionClassSelectorsDictionary at: method className ].
		
		DepProposedDeprecationRecommendation new
			method: newMethod;
			chooseApplicableRulesFrom: recommendations relevantRules
			basedOn: relevantSelectors;
			yourself ].
		
	recommendations methodsToDeprecate: depRecommendations.
]

{ #category : #'as yet unclassified' }
DepMinerController >> recommendMethodsWithMissingRules [
	| methodsWithMissingRules depRecommendations relevantSelectors |
	
	methodsWithMissingRules := projectHistory methods select: [ :method |
		method isInNewVersion and: [
			method isDeprecated and: [
				method hasTransformationRule not ] ] ].
	
	"There must be at least one rule that can be applied to this method"
	methodsWithMissingRules := methodsWithMissingRules select: [ :method |
		recommendations relevantRules anySatisfy: [ :rule |
			rule deletedMethodCalls anyOne selector = method selector ] ].
	
	depRecommendations := methodsWithMissingRules collect: [ :method |
		relevantSelectors := (Smalltalk classNamed: method className)
			ifNotNil: [ :aClass | aClass allMethods collect: [ :each | each selector ] ]
			ifNil: [ projectHistory newVersionClassSelectorsDictionary at: method className ].
		
		DepMissingRuleRecommendation new
			method: method;
			chooseApplicableRulesFrom: recommendations relevantRules
			basedOn: relevantSelectors;
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
