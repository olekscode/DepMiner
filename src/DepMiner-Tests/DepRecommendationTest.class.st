Class {
	#name : #DepRecommendationTest,
	#superclass : #TestCase,
	#instVars : [
		'recommendation'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #running }
DepRecommendationTest >> setUp [
	super setUp.
	
	recommendation := DepRecommendation new
		packageName: 'Core';
		className: 'Collection';
		selector: 'withIndexDo:';
		sourceCode: 'withIndexDo: aBlock
			self
				deprecated: ''Use #doWithIndex: instead''
				transformWith: ''`@rec withIndexDo: `@arg'' -> ''`@rec doWithIndex: `@arg''.
			^ self doWithIndex: aBlock';
		extractDeprecationsFromAst;
		yourself.
]

{ #category : #tests }
DepRecommendationTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := recommendation.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
]
