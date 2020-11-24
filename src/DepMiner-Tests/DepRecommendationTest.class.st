Class {
	#name : #DepRecommendationTest,
	#superclass : #TestCase,
	#instVars : [
		'method',
		'automatableReplacement',
		'nonAutomatableReplacement',
		'recommendation'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #'as yet unclassified' }
DepRecommendationTest >> recommendationClass [
	self subclassResponsibility
]

{ #category : #running }
DepRecommendationTest >> setUp [
	| automatableRule nonAutomatableRule |
	super setUp.
	
	method := DepMethod new
		packageName: 'Core';
		className: 'Collection';
		selector: 'withIndexDo:';
		yourself.
		
	automatableRule := DepAssociationRule
		withDeletedSelectors: #(withIndexDo:)
		addedSelectors: #(doWithIndex:).
		
	nonAutomatableRule := DepAssociationRule
		withDeletedSelectors: #(withIndexDo:)
		addedSelectors: #(do: collect:).
		
	automatableReplacement := DepAutomatableReplacement
		for: method
		definedBy: automatableRule.
		
	nonAutomatableReplacement := DepNonAutomatableReplacement
		for: method
		definedBy: nonAutomatableRule.
		
	recommendation := self recommendationClass new
		method: method;
		yourself.
]

{ #category : #tests }
DepRecommendationTest >> testGenerateSourceCodeFor: aRecommendation using: aReplacement expecting: anExpectedCode [
	| generatedCode expectedCode |
	generatedCode := aRecommendation generateSourceCodeUsing: aReplacement.
			
	"Replace all whitespaces with a single space"
	generatedCode := ' ' join: generatedCode substrings.
	expectedCode := ' ' join: anExpectedCode substrings.
	
	self assert: generatedCode equals: expectedCode
	
]

{ #category : #tests }
DepRecommendationTest >> testStonFor: aRecommendation [
	| originalObject stonString recoveredObject |
	
	originalObject := aRecommendation.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
]
