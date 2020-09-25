Class {
	#name : #MrAprioriMiner,
	#superclass : #Object,
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrAprioriMiner >> convertAssociationRulesToMigrationRules: aCollectionOfRules [
	^ aCollectionOfRules collect: [ :rule |
		MrRule new
			deletedMethodCalls: rule key asSet;
			addedMethodCalls: rule value asSet;
			count: rule count;
			confidence: rule confidence;
			lift: rule lift;
			yourself ].
]

{ #category : #'as yet unclassified' }
MrAprioriMiner >> filterAssociationRules: aCollectionOfRules [
	| filteredRules |
	
	filteredRules := aCollectionOfRules reject: [ :rule |
		rule key isEmpty or:
		rule value isEmpty ].
	
	filteredRules := filteredRules select: [ :rule |
		(rule key allSatisfy: [ :each | each isDeleted ]) and: [
			rule value allSatisfy: [ :each | each isAdded ] ] ].
	
	^ filteredRules 
]

{ #category : #'as yet unclassified' }
MrAprioriMiner >> mineRulesFromMethodChanges: aCollectionOfMethodChanges withMinCount: aCountThreshold [ 
	| transactions transactionsSource apriori rules |
	
	transactions := self transactionsFromMethodChanges: aCollectionOfMethodChanges.
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.

	apriori minCount: aCountThreshold.
	apriori findFrequentItemsets.
	apriori buildAssociationRules.
	
	apriori calculateAssociationRuleMetrics: { 
		APrioriCountMetric .
		APrioriConfidenceMetric .
		APrioriLiftMetric }.
	
	rules := self filterAssociationRules: apriori associationRules.
	^ self convertAssociationRulesToMigrationRules: rules.

]

{ #category : #'as yet unclassified' }
MrAprioriMiner >> transactionsFromMethodChanges: aCollectionOfMethodChanges [
	^ aCollectionOfMethodChanges
		select: [ :each | each addedMethodCalls isNotEmpty and: [ each deletedMethodCalls isNotEmpty ] ]
		thenCollect: [ :each | (each addedMethodCalls union: each deletedMethodCalls) asItemset ].
]
