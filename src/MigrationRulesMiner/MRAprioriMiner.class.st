Class {
	#name : #MRAprioriMiner,
	#superclass : #Object,
	#instVars : [
		'changeHistory'
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
	^ changes collect: [ :each | each asAprioriTransaction ].
]

{ #category : #'as yet unclassified' }
MRAprioriMiner >> mineRulesWithSupport: aSupportThreshold [ 
	| transactions transactionsSource apriori rules |
	transactions := self collectTransactions.
	
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.

	apriori minSupport: aSupportThreshold.
	apriori findFrequentItemsets.
	apriori calculateItemsetMetrics: { APrioriSupportMetric }.
	
	rules := apriori frequentItemsets collect: [ :each | each asMigrationRule ].
	
	^ rules reject: [ :each |
		each antecedent isEmpty or:
		each consequent isEmpty ].

]
