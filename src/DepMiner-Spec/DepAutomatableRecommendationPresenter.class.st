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
	| rule |
	rule := replacementsList selectedItem.
	
	rule ifNotNil: [
		self showCodeGeneratedBy: rule ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showCodeGeneratedBy: aRule [
	generatedCode text: (aRule snapshotOfSourceCodeWithGeneratedDeprecationFor: recommendation method)
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: recommendation applicableAutomatableRules.
	replacementsList selectIndex: 1.
]
