Class {
	#name : #DepNonAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#category : #'DepMiner-Spec-Views'
}

{ #category : #accessing }
DepNonAutomatableRecommendationPresenter >> replacements [
	^ recommendation nonAutomatableReplacements
]
