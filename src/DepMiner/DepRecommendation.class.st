Class {
	#name : #DepRecommendation,
	#superclass : #DepMethod,
	#instVars : [
		'automatableRulesDictionary',
		'nonAutomatableRulesDictionary'
	],
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepRecommendation >> applicableAutomatableRules [
	^ automatableRulesDictionary keys
]

{ #category : #'as yet unclassified' }
DepRecommendation >> applicableNonAutomatableRules [
	^ nonAutomatableRulesDictionary keys
]

{ #category : #'as yet unclassified' }
DepRecommendation >> chooseApplicableRulesFrom: aCollectionOfRelevantRules basedOn: aCollectionOfMethodsInNewVersion [

	| methodsOfSameClass methodsOfOtherClasses applicableRules replacementMethods |
	
	automatableRulesDictionary := Dictionary new.
	nonAutomatableRulesDictionary := Dictionary new.
	
	methodsOfSameClass := aCollectionOfMethodsInNewVersion
		select: [ :method | method className = className ].
		
	methodsOfOtherClasses := aCollectionOfMethodsInNewVersion
		reject: [ :method | method className = className ].
		
	applicableRules := aCollectionOfRelevantRules select: [ :rule |
		rule deletedMethodCalls anyOne selector = selector ].

	applicableRules do: [ :rule |
		rule isAutomatable
			ifTrue: [ 
				methodsOfSameClass
					detect: [ :method | method selector = rule addedMethodCalls anyOne selector ]
					ifFound: [ :method | automatableRulesDictionary at: rule put: method ].
					
				methodsOfOtherClasses
					detect: [ :method | method selector = rule addedMethodCalls anyOne selector ]
					ifFound: [ :method | nonAutomatableRulesDictionary at: rule put: { method } ] ]
			ifFalse: [ 
				replacementMethods := aCollectionOfMethodsInNewVersion select: [ :method |
					method selector = rule addedMethodCalls anyOne selector ].
						
				nonAutomatableRulesDictionary at: rule put: replacementMethods ] ]
]

{ #category : #testing }
DepRecommendation >> hasApplicableAutomatableRules [
	^ automatableRulesDictionary isNotEmpty
]

{ #category : #testing }
DepRecommendation >> hasApplicableNonAutomatableRules [
	^ nonAutomatableRulesDictionary isNotEmpty
]

{ #category : #'as yet unclassified' }
DepRecommendation >> replacementMethodDefinedByAutomatableRule: aRule [
	^ automatableRulesDictionary at: aRule
]

{ #category : #'as yet unclassified' }
DepRecommendation >> replacementMethodsDefinedByNonAutomatableRule: aRule [
	^ nonAutomatableRulesDictionary at: aRule
]
