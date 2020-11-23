Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#category : #'DepMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> replacements [
	^ recommendation automatableReplacements
]
