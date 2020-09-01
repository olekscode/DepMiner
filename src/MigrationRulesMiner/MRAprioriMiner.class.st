Class {
	#name : #MRAprioriMiner,
	#superclass : #Object,
	#instVars : [
		'changeHistory',
		'transactions',
		'apriori',
		'rules'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRAprioriMiner >> changeHistory [
	^ changeHistory
]

{ #category : #accessing }
MRAprioriMiner >> changeHistory: anObject [
	changeHistory := anObject
]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> collectMessageSendChanges [
	| sendsInOldMethod sendsInNewMethod addedSends deletedSends changes |
	
	changes := changeHistory methodChanges collect: [ :change | 		
		sendsInOldMethod  := self collectMessageSendsFrom: change oldMethodAst.
		sendsInNewMethod := self collectMessageSendsFrom: change newMethodAst.
		
		addedSends := sendsInNewMethod
			select: [ :newSend |
				sendsInOldMethod noneSatisfy: [ :oldSend |
					oldSend selector = newSend selector ] ].
			
		deletedSends := sendsInOldMethod
			select: [ :oldSend |
				sendsInNewMethod noneSatisfy: [ :newSend |
					newSend selector = oldSend selector ] ].
	
		MRMessageSendChanges new
			methodChange: change;
			deletedMessageSends: deletedSends;
			addedMessageSends: addedSends;
			yourself ].
	
	^ changes reject: [ :change |
		change deletedMessageSends isEmpty or:
		change addedMessageSends isEmpty ].

]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> collectMessageSendsFrom: anAst [
	| visitor |
	visitor := MRMessageSendCollectingVisitor new.
	anAst acceptVisitor: visitor.
	^ visitor messageSends

]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> collectTransactions [
	| changes |
	changes := self collectMessageSendChanges.
	transactions := changes collect: [ :each | each asAprioriTransaction ].
]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> convertAssociationRulesToMigrationRules: aCollectionOfRules [
	| antecedent consequent |
	
	^ aCollectionOfRules collect: [ :rule |
		antecedent := rule key collect: [ :each |
			each copyFrom: 14 to: each size - 1 ].
		
		consequent := rule value collect: [ :each |
			each copyFrom: 12 to: each size - 1 ].
		
		MRMigrationRule new
			antecedent: antecedent;
			consequent: consequent;
			count: rule count;
			confidence: rule confidence;
			lift: rule lift;
			yourself ].
]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> filterAssociationRules: aCollectionOfRules [
	| filteredRules |
	
	filteredRules := aCollectionOfRules reject: [ :rule |
		rule key isEmpty or:
		rule value isEmpty ].
	
	filteredRules := filteredRules select: [ :rule |
		(rule key allSatisfy: [ :each | each beginsWith: 'deleted' ]) and: [
			rule value allSatisfy: [ :each | each beginsWith: 'added' ] ] ].
	
	^ filteredRules 
]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> mineRulesWithMinCount: aCountThreshold [ 
	| transactionsSource |
	
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
	rules := self convertAssociationRulesToMigrationRules: rules.

]

{ #category : #accessing }
MRAprioriMiner >> rules [
	^ rules
]
