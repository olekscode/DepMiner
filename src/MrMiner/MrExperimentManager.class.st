Class {
	#name : #MrExperimentManager,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'experiment',
		'methodChanges'
	],
	#category : #'MrMiner-Controllers'
}

{ #category : #accessing }
MrExperimentManager >> branch: aBranch [
	branch := aBranch.
	experiment branchName: branch name.
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> collectOldApiMethodNames [
	| currentCommit oldCommit packages selectors |
	
	currentCommit := repository head commit.
	oldCommit := repository commitAt: experiment fromCommit sha.
	
	oldCommit fetchPackageNames ifEmpty: [
		Error signal: 'This commit had no packages. Please choose a later commit' ].
	
	repository branch commit: oldCommit.
	repository checkoutAllPackages.
	
	packages := repository loadedPackages collect: [ :each | Smalltalk image packages detect: [ :package | package name = each name ] ].
	
	selectors := packages flatCollect: [ :package |
		package methods collect: [ :method | method selector ] ].
	
	repository branch commit: currentCommit.
	repository checkoutAllPackages.
	
	^ selectors asSet.
]

{ #category : #accessing }
MrExperimentManager >> experiment [
	^ experiment
]

{ #category : #initialization }
MrExperimentManager >> initialize [
	super initialize.
	experiment := MrExperiment new.
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> loadAllCommits [
	| commits |
	commits := branch commits collect: [ :each | each asMrCommit ].
	
	repository tags do: [ :tag |
		commits
			detect: [ :commit | commit sha = tag commit id ]
			ifFound: [ :commit | commit tags add: tag name ] ].
	
	^ commits
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> loadMethodChangesFromCommit: aFromCommit toCommit: aToCommit [
	| methodChangeCollector methodCallCollector oldApiMethodNames |
	
	experiment
		fromCommit: aFromCommit;
		toCommit: aToCommit.
	
	methodChangeCollector := RefrainMethodChangeCollector
		forRepository: repository
		branch: branch.
	
	methodChanges := methodChangeCollector
		collectMethodChangesFromCommit: experiment fromCommit
		toCommit: experiment toCommit.
		
	experiment numberOfTransactions: methodChanges size.
		
	methodCallCollector := RefrainMethodCallCollector new.
	
	methodChanges do: [ :change |
		methodCallCollector extractAddedAndDeletedMethodCallsFrom: change ].
	
	oldApiMethodNames := self collectOldApiMethodNames.
	
	methodChanges := methodChanges select: [ :change |
		change deletedMethodCalls anySatisfy: [ :call |
			oldApiMethodNames includes: call selector ] ].
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> mineRulesWithMinCount: aMinCount minConfidence: aMinConfidence [
	| aprioriMiner associationRules rules rulesBuilder |
	
	experiment minCount: aMinCount.
	experiment minConfidence: aMinConfidence.

	aprioriMiner := RefrainAprioriMiner new.
	
	associationRules := aprioriMiner
		mineRulesFromMethodChanges: methodChanges
		withMinCount: experiment minCount.
		
	associationRules := associationRules select: [ :rule |
		rule confidence >= experiment minConfidence ].
	
	rulesBuilder := MrRulesBuilder new.
	rules := rulesBuilder buildMigrationRulesFromAssociationRules: associationRules.
	rulesBuilder mapRules: rules toMethodChanges: methodChanges.
	
	experiment rules: (self sortRules: rules).
]

{ #category : #accessing }
MrExperimentManager >> repository: aRepository [
	repository := aRepository.
	
	experiment
		repositoryName: repository name;
		repositoryUrl: repository origin httpsUrl.
]

{ #category : #sorting }
MrExperimentManager >> sortRules: aCollectionOfRules [
	"Sort first by lift then by confidence then by count"
	^ aCollectionOfRules sorted: [ :a :b |
		a lift > b lift or: [ 
			a lift = b lift and: [ a confidence > b confidence or: [ 
				a confidence = b confidence and: [ a count > b count ] ] ] ] ].
]
