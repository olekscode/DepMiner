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

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> collectMessageSendChanges [
	| methodModifications sendsInOldMethod sendsInNewMethod addedSends deletedSends changes |
	methodModifications := self collectMethodModifications.
	
	changes := methodModifications collect: [ :modification | 		
		sendsInNewMethod := self collectMessageSendsFrom: modification definition.
		sendsInOldMethod  := self collectMessageSendsFrom: modification oldNode.
		
		addedSends := sendsInNewMethod
			select: [ :newSend |
				sendsInOldMethod noneSatisfy: [ :oldSend |
					oldSend selector = newSend selector ] ]
			thenCollect: [ :addedSend | addedSend isAdded: true ].
			
		deletedSends := sendsInOldMethod
			select: [ :oldSend |
				sendsInNewMethod noneSatisfy: [ :newSend |
					newSend selector = oldSend selector ] ]
			thenCollect: [ :deletedSend | deletedSend isDeleted: true ].
	
		addedSends, deletedSends ].
	
	^ changes reject: [ :change | change isEmpty ].

]

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> collectMessageSendsFrom: aMethod [
	| visitor |
	visitor := MRMessageSendCollectingVisitor new.
	(RBParser parseMethod: aMethod sourceCode) acceptVisitor: visitor.
	^ visitor messageSends collect: [ :messageSend | messageSend sender: aMethod ].

]

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> collectMethodModifications [
	| packageNodes classNodes methodNodes methodOperations methodModifications |
	
	packageNodes := diffs flatCollect: [ :diff |
		diff tree children first children ].
	
	classNodes := packageNodes flatCollect: [ :node |
		node children ].
	
	methodNodes := classNodes flatCollect: [ :node |
		node children ].
	
	methodOperations := methodNodes collect: [ :node | node value ].
	
	methodModifications := methodOperations select: [ :op |
		op isModification and: [ 
			op definition isMethodDefinition and: [ 
				op oldNode isMethodDefinition ] ] ].
	
	^ methodModifications
]

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> collectTransactions [
	| changes |
	changes := self collectMessageSendChanges.
	^ changes collect: [ :messageSends | messageSends asSet ].
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

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> filterEmptyDiffs [
	diffs := diffs reject: [ :diff | diff tree isEmptyNode ].
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

{ #category : #'as yet unclassified' }
MigrationRulesMiner >> mineRulesWithSupport: aSupportThreshold [ 
	| transactions transactionsSource apriori |
	self loadCommits.
	self calculateDiffs.
	transactions := self collectTransactions.
	
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.

	apriori minSupport: aSupportThreshold.
	apriori findFrequentItemsets.
	
	^ apriori frequentItemsets 

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
