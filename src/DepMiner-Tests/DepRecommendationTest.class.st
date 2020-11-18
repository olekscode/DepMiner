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
		yourself.
]

{ #category : #tests }
DepRecommendationTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := recommendation.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
	
	"After parsing a metod from a STON string, we need to parse its source code again."
	recoveredObject parseSourceCode.
	recoveredObject parseOldSourceCode.
	
	self assert: recoveredObject ast equals: originalObject ast.
	self assert: recoveredObject oldAst equals: originalObject oldAst.
]
