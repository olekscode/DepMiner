Class {
	#name : #MrRuleFeedbackPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleFeedback',
		'isGoodRadio',
		'canBeExpressedWithTransformationRuleRadio',
		'isProposedTransformationRuleGoodRadio',
		'manualTransformationRuleText',
		'validateTransformationRuleButton',
		'helpTransformationRuleButton',
		'canBeDeprecationRadio',
		'isInterestingCaseCheckbox',
		'commentText',
		'feedbackChangedCallback',
		'saveButton'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrRuleFeedbackPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 10;
		add: #isGoodRadio;
		add: (SpBoxLayout newHorizontal
			add: #canBeExpressedWithTransformationRuleRadio;
			add: #isProposedTransformationRuleGoodRadio;
			yourself);
		add: (SpBoxLayout newVertical
			spacing: 5; 
			add: 'Propose a different transformation rule:' height: self labelHeight;
			add: #manualTransformationRuleText height: 100;
			add: (SpBoxLayout newHorizontal 
				spacing: 2;
				add: '';
				add: #validateTransformationRuleButton width: self buttonWidth;
				add: #helpTransformationRuleButton width: self buttonWidth;
				yourself) height: self buttonHeight;
			yourself);
		add: #canBeDeprecationRadio;
		add: 'Comment:' height: self labelHeight;
		add: #commentText height: 100;
		add: (SpBoxLayout newHorizontal
			add: #isInterestingCaseCheckbox;
			add: #saveButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> connectPresenters [
	super connectPresenters.

	saveButton action: [ self saveFeedback ].
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializeEmptyRuleFeedback [
	ruleFeedback := MrRuleFeedback new.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializePresenters [ 
	super initializePresenters.
	
	isGoodRadio := MrIsGoodQuestion new.
	canBeExpressedWithTransformationRuleRadio := MrCanBeExpressedWithTransformationRuleQuestion new.
	isProposedTransformationRuleGoodRadio := MrIsProposedTransformationRuleGoodQuestion new.
	canBeDeprecationRadio := MrCanBeDeprecationQuestion new.
	
	manualTransformationRuleText := self newText.
	commentText := self newText.
	
	helpTransformationRuleButton := self newButton
		label: 'Help';
		icon: (self iconNamed: #help);
		yourself.
		
	validateTransformationRuleButton := self newButton
		label: 'Validate';
		yourself.
		
	isInterestingCaseCheckbox := self newCheckBox
		label: 'Mark this rule as an interesting case that could be discussed';
		yourself.
		
	saveButton := self newButton
		label: 'Save';
		yourself.
		
	self initializeEmptyRuleFeedback.
	self showRuleFeedback.
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> ruleFeedback: anObject [
	anObject
		ifNotNil: [ ruleFeedback := anObject ]
		ifNil: [ self initializeEmptyRuleFeedback ].
		
	self showRuleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> saveFeedback [
	ruleFeedback isGood: isGoodRadio selectedOption.
	ruleFeedback comment: commentText text.
	
	feedbackChangedCallback value: ruleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> showRuleFeedback [ 
	isGoodRadio selectOption: ruleFeedback isGood.
		
	ruleFeedback comment
		ifNil: [ commentText text: '' ]
		ifNotNil: [ commentText text: ruleFeedback comment ].
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
