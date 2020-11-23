Class {
	#name : #DepProposedDeprecationRecommendationTest,
	#superclass : #DepRecommendationTest,
	#category : #'DepMiner-Tests-Models'
}

{ #category : #'as yet unclassified' }
DepProposedDeprecationRecommendationTest >> recommendationClass [
	^ DepProposedDeprecationRecommendation
]

{ #category : #running }
DepProposedDeprecationRecommendationTest >> setUp [ 
	super setUp.
	
	method
		sourceCode: 'withIndexDo: aBlock
			"Just like do: except that the iteration index supplies the second argument to the block"
			"Support collection enumeration with a counter, even though not ordered"
			| index |
			index := 0.
			self do: [:item | elementAndIndexBlock value: item value: (index := index+1)]';
		extractDeprecationsFromAst.
]

{ #category : #tests }
DepProposedDeprecationRecommendationTest >> testGenerateSourceCodeUsingAutomatableReplacement [
	| expectedCode |
		
	expectedCode := 'withIndexDo: aBlock
			"Just like do: except that the iteration index supplies the second argument to the block"
			"Support collection enumeration with a counter, even though not ordered"
			self
				deprecated: ''Use #doWithIndex: instead''
				transformWith: ''`@rec withIndexDo: `@arg'' -> ''`@rec doWithIndex: `@arg''.
			^ self doWithIndex: aBlock'.
			
	self
		testGenerateSourceCodeFor: recommendation
		using: automatableReplacement
		expecting: expectedCode 
	
]

{ #category : #tests }
DepProposedDeprecationRecommendationTest >> testGenerateSourceCodeUsingNonAutomatableReplacement [
	| expectedCode |
		
	expectedCode := 'withIndexDo: aBlock
			"Just like do: except that the iteration index supplies the second argument to the block"
			"Support collection enumeration with a counter, even though not ordered"
			| index |
			self deprecated: ''Use #do: and #collect: instead''.
			index := 0.
			self do: [ :item | elementAndIndexBlock value: item value: (index := index + 1) ]'.
			
	self
		testGenerateSourceCodeFor: recommendation
		using: nonAutomatableReplacement
		expecting: expectedCode 
	
]

{ #category : #tests }
DepProposedDeprecationRecommendationTest >> testSton [
	self testStonFor: recommendation
]
