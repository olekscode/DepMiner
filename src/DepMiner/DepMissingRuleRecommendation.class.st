Class {
	#name : #DepMissingRuleRecommendation,
	#superclass : #DepRecommendation,
	#category : #'DepMiner-Models'
}

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
