Class {
	#name : #DepProposedDeprecationRecommendation,
	#superclass : #DepRecommendation,
	#category : #'DepMiner-Models'
}

{ #category : #testing }
DepProposedDeprecationRecommendation >> canBeApplied [
	^ self isClassLoadedIntoTheImage: method className
]

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

{ #category : #'as yet unclassified' }
DepProposedDeprecationRecommendation >> raiseCanNotBeAppliedException [
	DepRecommendationCanNotBeAppliedError signal: ('The generated code can not be saved because the class ', method className, ' was not found in the image. Please make sure that you loaded the right version of the project').
]
