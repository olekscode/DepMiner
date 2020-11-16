Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepRecommendationPresenter,
	#instVars : [
		'generatedCode',
		'replacementCode'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepAutomatableRecommendationPresenter class >> codeLayout [ 
	^ SpBoxLayout newVertical
		add: 'Generated code' height: self labelHeight;
		add: #generatedCode;
		add: 'Implementation of a proposed replacement' height: self labelHeight;
		add: #replacementCode;
		yourself
]

{ #category : #initialization }
DepAutomatableRecommendationPresenter >> initializeCode [
	generatedCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
		
	replacementCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> onReplacementSelectionChanged [
	| rule |
	rule := replacementsList selectedItem.
	
	rule ifNotNil: [
		self showCodeGeneratedBy: rule.
		self showImplementationOfReplacementProposedBy: rule ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showCodeGeneratedBy: aRule [
	generatedCode text: (aRule snapshotOfSourceCodeWithGeneratedDeprecationFor: recommendation)
]

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
