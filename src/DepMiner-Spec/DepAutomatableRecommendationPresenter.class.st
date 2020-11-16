Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#category : #'DepMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showImplementationOfReplacementProposedBy: aRule [
	| replacementMethod |
	replacementMethod := recommendation replacementMethodDefinedByAutomatableRule: aRule.
	
	replacementCode text: replacementMethod sourceCode.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: recommendation applicableAutomatableRules.
	replacementsList selectIndex: 1.
]
