Class {
	#name : #DepMissingRuleRecommendationTest,
	#superclass : #DepRecommendationTest,
	#category : #'DepMiner-Tests-Models'
}

{ #category : #'as yet unclassified' }
DepMissingRuleRecommendationTest >> recommendationClass [
	^ DepMissingRuleRecommendation
]

{ #category : #running }
DepMissingRuleRecommendationTest >> setUp [ 
	super setUp.
	
	method
		sourceCode: 'withIndexDo: aBlock
			"Just like do: except that the iteration index supplies the second argument to the block"
			"Support collection enumeration with a counter, even though not ordered"
			| index |
			self deprecated: ''This method is deprecated. You should call #doWithIndex:''.
			index := 0.
			self do: [:item | elementAndIndexBlock value: item value: (index := index+1)]';
		extractDeprecationsFromAst.
]

{ #category : #tests }
DepMissingRuleRecommendationTest >> testGenerateSourceCodeUsingAutomatableReplacement [
	| expectedCode |
		
	expectedCode := 'withIndexDo: aBlock
			"Just like do: except that the iteration index supplies the second argument to the block"
			"Support collection enumeration with a counter, even though not ordered"
			| index |
			self
				deprecated: ''This method is deprecated. You should call #doWithIndex:''
				transformWith: ''`@rec withIndexDo: `@arg'' -> ''`@rec doWithIndex: `@arg''.
			index := 0.
			self do: [ :item | elementAndIndexBlock value: item value: (index := index + 1) ]'.
			
	self
		testGenerateSourceCodeFor: recommendation
		using: automatableReplacement
		expecting: expectedCode 
	
]

{ #category : #tests }
DepMissingRuleRecommendationTest >> testGenerateSourceCodeUsingNonAutomatableReplacement [
	self
		testGenerateSourceCodeFor: recommendation
		using: nonAutomatableReplacement
		expecting: method sourceCode 
	
]

{ #category : #tests }
DepMissingRuleRecommendationTest >> testSton [
	self testStonFor: recommendation
]
