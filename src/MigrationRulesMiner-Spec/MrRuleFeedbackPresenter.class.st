Class {
	#name : #MrRuleFeedbackPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleFeedback',
		'isGoodRadio',
		'canBeIntegratedRadio',
		'canBeExpressedWithTransformationRuleRadio',
		'isProposedTransformationRuleGoodRadio',
		'manualTransformationRuleText',
		'validateTransformationRuleButton',
		'helpTransformationRuleButton',
		'isInterestingCaseCheckbox',
		'commentText',
		'feedbackChangedCallback',
		'helpButton',
		'saveButton'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRuleFeedbackPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: (SpBoxLayout newVertical
			spacing: 10;
			add: (SpBoxLayout newHorizontal
				add: #isGoodRadio;
				add: '';
				yourself);
			add: (SpBoxLayout newHorizontal
				add: #canBeExpressedWithTransformationRuleRadio;
				add: #isProposedTransformationRuleGoodRadio;
				yourself);
			add: 'Propose a different transformation rule:' height: self labelHeight;
			add: #manualTransformationRuleText height: 100;
			add: 'Comment:' height: self labelHeight;
			add: #commentText height: 100;
			add: (SpBoxLayout newHorizontal
				add: '';
				add: #saveButton width: self buttonWidth;
				yourself) height: self buttonHeight;
			yourself);
		add: (SpBoxLayout newVertical
			add: #helpButton height: self buttonHeight;
			yourself) width: self buttonWidth;
		yourself.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> connectPresenters [
	super connectPresenters.
	
	helpButton action: [ MrFeedbackHelpPresenter new openWithSpec ].
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
	canBeIntegratedRadio := MrCanBeIntegratedQuestion new.
	canBeExpressedWithTransformationRuleRadio := MrCanBeExpressedWithTransformationRuleQuestion new.
	isProposedTransformationRuleGoodRadio := MrIsProposedTransformationRuleGoodQuestion new.
	
	manualTransformationRuleText := self newText.
	commentText := self newText.
	
	helpTransformationRuleButton := self newButton
		label: 'Help';
		icon: (self iconNamed: #help);
		yourself.
		
	validateTransformationRuleButton := self newButton
		label: 'Validate';
		yourself.
	
	helpButton := self newButton
		label: 'Help';
		icon: (self iconNamed: #help);
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
	ruleFeedback canBeIntegrated: canBeIntegratedRadio selectedOption.
	ruleFeedback comment: commentText text.
	
	feedbackChangedCallback value: ruleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> showRuleFeedback [ 
	isGoodRadio selectOption: ruleFeedback isGood.
	canBeIntegratedRadio selectOption: ruleFeedback canBeIntegrated.
		
	ruleFeedback comment
		ifNil: [ commentText text: '' ]
		ifNotNil: [ commentText text: ruleFeedback comment ].
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
