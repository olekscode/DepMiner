Class {
	#name : #DepProposedDeprecationRecommendation,
	#superclass : #DepRecommendation,
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepProposedDeprecationRecommendation >> generateSourceCodeUsing: aReplacement [
	| generatedDeprecationAst generatedImplementationAst newAst |
	
	generatedDeprecationAst := RBParser parseExpression: aReplacement generateDeprecation.
	generatedImplementationAst := RBParser parseExpression: aReplacement generateSourceCodeAfterDeprecation.
	
	newAst := method ast copy.
	
	"TODO: Find a cleaner way of doing this"
	aReplacement isAutomatable
		ifTrue: [ newAst body temporaries removeAll ].
	
	newAst statements:
		{ generatedDeprecationAst },
		(generatedImplementationAst isSequence
			ifTrue: [ generatedImplementationAst statements ]
			ifFalse: [ { generatedImplementationAst } ]).
		
	^ newAst formattedCode
]
