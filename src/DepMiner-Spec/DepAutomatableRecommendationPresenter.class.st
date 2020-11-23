Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#instVars : [
		'generatedCode'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepAutomatableRecommendationPresenter class >> codeLayout [ 
	^ SpBoxLayout newVertical
		add: 'Source code with generated deprecation' height: self labelHeight;
		add: #generatedCode;
		yourself
]

{ #category : #initialization }
DepAutomatableRecommendationPresenter >> initializeCode [
	generatedCode := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		yourself.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> onReplacementSelectionChanged [
	| replacement |
	replacement := replacementsList selectedItem.
	
	replacement ifNotNil: [
		self showCodeGeneratedBy: replacement ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showCodeGeneratedBy: aReplacement [
	generatedCode text: (recommendation snapshotOfSourceCodeWithDeprecationGeneratedBy: aReplacement rule)
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: recommendation automatableReplacements.
	replacementsList selectIndex: 1.
]
