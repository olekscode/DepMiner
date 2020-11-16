Class {
	#name : #DepRecommendations,
	#superclass : #Object,
	#instVars : [
		'rules',
		'methodsToDeprecate',
		'methodsWithMissingRules'
	],
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepRecommendations >> automatableRules [
	"Association rules for which the transformation rules can be generated automatically"
	^ rules select: [ :rule | rule isAutomatable ]
]

{ #category : #accessing }
DepRecommendations >> methodsToDeprecate [
	^ methodsToDeprecate
]

{ #category : #accessing }
DepRecommendations >> methodsToDeprecate: anObject [
	methodsToDeprecate := anObject
]

{ #category : #accessing }
DepRecommendations >> methodsWithMissingRules [
	^ methodsWithMissingRules
]

{ #category : #accessing }
DepRecommendations >> methodsWithMissingRules: anObject [
	methodsWithMissingRules := anObject
]

{ #category : #'as yet unclassified' }
DepRecommendations >> relevantRules [
	"Rules that can be used to propose deprecations or add transformation rules to existing deprecations"
	^ rules select: [ :rule | rule isRelevant ]
]

{ #category : #accessing }
DepRecommendations >> rules [
	^ rules
]

{ #category : #accessing }
DepRecommendations >> rules: anObject [
	rules := anObject.
]

{ #category : #'as yet unclassified' }
DepRecommendations >> transformationRules [
	"Transformation rules that were generated from association rules"
	^ self relevantRules
		select: [ :rule | rule hasTransformationRule ]
		thenCollect: [ :rule | rule transformationRule ]
]
