Class {
	#name : #DepRecommendationTreePresenter,
	#superclass : #DepTreePresenter,
	#category : #'DepMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
DepRecommendationTreePresenter >> classNameToDisplayFor: aClassName [
	^ (DepRecommendation isClassLoadedIntoTheImage: aClassName)
		ifTrue: [ aClassName ]
		ifFalse: [ aClassName, ' (not loaded)' ]
]

{ #category : #'as yet unclassified' }
DepRecommendationTreePresenter >> methodToDisplayFor: anItem [
	^ anItem method
]
