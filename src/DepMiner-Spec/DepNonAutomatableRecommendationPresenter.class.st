Class {
	#name : #DepNonAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#category : #'DepMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
DepNonAutomatableRecommendationPresenter >> showImplementationOfReplacementProposedBy: aRule [
	
]

{ #category : #'as yet unclassified' }
DepNonAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: recommendation applicableNonAutomatableRules.
	replacementsList selectIndex: 1.
]
