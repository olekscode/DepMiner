Class {
	#name : #DepRecommendations,
	#superclass : #Object,
	#instVars : [
		'rules',
		'selectorsToDeprecate'
	],
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepRecommendations >> automatableRules [
	"Association rules for which the transformation rules can be generated automatically"
	^ rules select: [ :rule | rule isAutomatable ]
]

{ #category : #initialization }
DepRecommendations >> initialize [
	super initialize.
	selectorsToDeprecate := Dictionary new.
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
	
	self relevantRules
		select: [ :rule | rule hasTransformationRule ]
		thenDo: [ :rule |
			(selectorsToDeprecate
				at: rule deletedMethodCalls anyOne selector
				ifAbsentPut: [ OrderedCollection new ])
				add: rule transformationRule ].
]

{ #category : #accessing }
DepRecommendations >> selectorsToDeprecate [
	^ selectorsToDeprecate
]

{ #category : #'as yet unclassified' }
DepRecommendations >> transformationRules [
	"Transformation rules that were generated from association rules"
	^ self relevantRules
		select: [ :rule | rule hasTransformationRule ]
		thenCollect: [ :rule | rule transformationRule ]
]
