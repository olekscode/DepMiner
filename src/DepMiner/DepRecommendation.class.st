Class {
	#name : #DepRecommendation,
	#superclass : #Object,
	#instVars : [
		'method',
		'automatableRulesDictionary',
		'nonAutomatableRulesDictionary'
	],
	#category : #'DepMiner-Models'
}

{ #category : #comparing }
DepRecommendation >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ automatableRulesDictionary = anObject automatableRulesDictionary 
		  and: [ 
			  method = anObject method and: [ 
				  nonAutomatableRulesDictionary
				  = anObject nonAutomatableRulesDictionary ] ]
]

{ #category : #'as yet unclassified' }
DepRecommendation >> applicableAutomatableRules [
	^ automatableRulesDictionary keys
]

{ #category : #'as yet unclassified' }
DepRecommendation >> applicableNonAutomatableRules [
	^ nonAutomatableRulesDictionary keys
]

{ #category : #accessing }
DepRecommendation >> automatableRulesDictionary [
	^ automatableRulesDictionary
]

{ #category : #'as yet unclassified' }
DepRecommendation >> chooseApplicableRulesFrom: aCollectionOfRelevantRules basedOn: aCollectionOfMethodsInNewVersion [

	| methodsOfSameClass methodsOfOtherClasses applicableRules replacementMethods |
	
	automatableRulesDictionary := Dictionary new.
	nonAutomatableRulesDictionary := Dictionary new.
	
	methodsOfSameClass := aCollectionOfMethodsInNewVersion
		select: [ :newVersionMethod | newVersionMethod className = method className ].
		
	methodsOfOtherClasses := aCollectionOfMethodsInNewVersion
		reject: [ :newVersionMethod | newVersionMethod className = method className ].
		
	applicableRules := aCollectionOfRelevantRules select: [ :rule |
		rule deletedMethodCalls anyOne selector = method selector ].

	applicableRules do: [ :rule |
		rule isAutomatable
			ifTrue: [ 
				methodsOfSameClass
					detect: [ :aMethod | aMethod selector = rule addedMethodCalls anyOne selector ]
					ifFound: [ :aMethod | automatableRulesDictionary at: rule put: aMethod ].
					
				methodsOfOtherClasses
					detect: [ :aMethod | aMethod selector = rule addedMethodCalls anyOne selector ]
					ifFound: [ :aMethod | nonAutomatableRulesDictionary at: rule put: { aMethod } ] ]
			ifFalse: [ 
				replacementMethods := aCollectionOfMethodsInNewVersion select: [ :aMethod |
					aMethod selector = rule addedMethodCalls anyOne selector ].
						
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

{ #category : #comparing }
DepRecommendation >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ automatableRulesDictionary hash bitXor:
		  (method hash bitXor: nonAutomatableRulesDictionary hash)
]

{ #category : #accessing }
DepRecommendation >> method [
	^ method
]

{ #category : #accessing }
DepRecommendation >> method: anObject [
	method := anObject
]

{ #category : #accessing }
DepRecommendation >> nonAutomatableRulesDictionary [
	^ nonAutomatableRulesDictionary
]

{ #category : #'as yet unclassified' }
DepRecommendation >> replacementMethodDefinedByAutomatableRule: aRule [
	^ automatableRulesDictionary at: aRule
]

{ #category : #'as yet unclassified' }
DepRecommendation >> replacementMethodsDefinedByNonAutomatableRule: aRule [
	^ nonAutomatableRulesDictionary at: aRule
]
