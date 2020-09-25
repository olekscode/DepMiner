Class {
	#name : #MrRuleMethodChangeMapper,
	#superclass : #Object,
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrRuleMethodChangeMapper >> mapRules: aCollectionOfRules toMethodChanges: aCollectionOfMethodChanges [
	aCollectionOfRules do: [ :rule |
		rule methodChanges: (aCollectionOfMethodChanges select: [ :methodChange |
			(methodChange deletedMethodCalls includesAll: rule deletedMethodCalls) and: [ 
				methodChange addedMethodCalls includesAll: rule addedMethodCalls ] ]) ]
]
