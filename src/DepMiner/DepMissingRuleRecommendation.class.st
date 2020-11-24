Class {
	#name : #DepMissingRuleRecommendation,
	#superclass : #DepRecommendation,
	#category : #'DepMiner-Models'
}

{ #category : #testing }
DepMissingRuleRecommendation >> canBeApplied [
	^ self isMethodLoadedIntoTheImage: method
]

{ #category : #'as yet unclassified' }
DepMissingRuleRecommendation >> generateSourceCodeUsing: aReplacement [
	| transformationRule transformationRuleString ast rewriterRule |
	
	aReplacement isAutomatable
		ifFalse: [ ^ method sourceCode ].
		
	transformationRule := aReplacement rule transformationRule.
		
	transformationRuleString := '<1p> -> <2p>'
		expandMacrosWith: transformationRule antecedent
		with: transformationRule consequent.
		
	rewriterRule := RBParseTreeRewriter new 
		replace: 'self deprecated: `@message'
		with: ('self deprecated: `@message transformWith: {1}' format: {transformationRuleString});
		yourself.
		
	ast := method ast copy.
	
	RecursionStopper during: [
		(rewriterRule executeTree: ast)
			ifFalse: [ ^ Error signal: 'Failed to transform the method' ] ].

	^ ast formattedCode
]

{ #category : #'as yet unclassified' }
DepMissingRuleRecommendation >> raiseCanNotBeAppliedException [
	DepRecommendationCanNotBeAppliedError signal: ('The generated code can not be saved because the method ', method signature, ' was not found in the image. Please make sure that you loaded the right version of the project').
]
