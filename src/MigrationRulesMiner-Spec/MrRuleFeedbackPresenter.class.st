Class {
	#name : #MrRuleFeedbackPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleFeedback',
		'isGoodRadio',
		'canBeIntegratedRadio',
		'commentText',
		'feedbackChangedCallback',
		'helpButton',
		'saveButton'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRuleFeedbackPresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 5;
		add: (SpBoxLayout newHorizontal
			add: #isGoodRadio;
			add: #canBeIntegratedRadio;
			add: '';
			add: (SpBoxLayout newVertical
				add: #helpButton height: self buttonHeight;
				yourself) width: self buttonWidth;
			yourself) height: 5 * self labelHeight;
		add: 'Comment' height: self labelHeight;
		add: #commentText height: 100;
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #saveButton width: self buttonWidth) height: self buttonHeight;
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
	
	isGoodRadio := MrRadioButtonGroup on: 'Is this a good rule?'.
	canBeIntegratedRadio := MrRadioButtonGroup on: 'Can this rule be integrated into the project?'.
	
	commentText := self newText.
	
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

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> resetRadioButtons: aCollectionOfRadioButtons [
	aCollectionOfRadioButtons do: [ :each | each state: false ]
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
