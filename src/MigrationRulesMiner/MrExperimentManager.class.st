Class {
	#name : #MrExperimentManager,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'experiment',
		'methodChanges'
	],
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #accessing }
MrExperimentManager >> experiment [
	^ experiment
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> loadMethodChangesFromRepository: aRepository branch: aBranch fromCommit: aFromCommit toCommit: aToCommit [
	| methodChangeCollector methodCallCollector |
	
	repository := aRepository.
	branch := aBranch.
	
	experiment := MrExperiment new
		repositoryName: repository name;
		repositoryUrl: repository origin httpsUrl;
		branchName: branch name;
		fromCommit: aFromCommit;
		toCommit: aToCommit;
		yourself.
	
	methodChangeCollector := MrMethodChangeCollector
		forRepository: repository
		branch: branch.
	
	methodChanges := methodChangeCollector
		collectMethodChangesFromCommit: experiment fromCommit
		toCommit: experiment toCommit.
		
	experiment numberOfTransactions: methodChanges size.
		
	methodCallCollector := MrMethodCallCollector new.
	
	methodChanges do: [ :change |
		methodCallCollector extractAddedAndDeletedMethodCallsFrom: change ].
]

{ #category : #'as yet unclassified' }
MrExperimentManager >> mineRulesWithMinCount: aMinCount minConfidence: aMinConfidence [
	| aprioriMiner mapper rules |
	
	experiment minCount: aMinCount.
	experiment minConfidence: aMinConfidence.

	aprioriMiner := MrAprioriMiner new.
	
	rules := aprioriMiner
		mineRulesFromMethodChanges: methodChanges
		withMinCount: experiment minCount.
		
	rules := rules select: [ :rule |
		rule confidence >= experiment minConfidence ].
		
	mapper := MrRuleMethodChangeMapper new.
	mapper mapRules: rules toMethodChanges: methodChanges.
	
	experiment rules: rules.
]
