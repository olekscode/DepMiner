Class {
	#name : #DepNonAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#instVars : [
		'sourceCode'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepNonAutomatableRecommendationPresenter class >> codeLayout [ 
	^ SpBoxLayout newVertical
		add: 'Source code' height: self labelHeight;
		add: #sourceCode;
		yourself
]

{ #category : #initialization }
DepNonAutomatableRecommendationPresenter >> initializeCode [
	sourceCode := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		text: recommendation method sourceCode;
		yourself.
]

{ #category : #'as yet unclassified' }
DepNonAutomatableRecommendationPresenter >> onReplacementSelectionChanged [
	"Do nothing"
]

{ #category : #'as yet unclassified' }
DepNonAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: recommendation applicableNonAutomatableRules.
	replacementsList selectIndex: 1.
]
