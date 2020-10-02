Class {
	#name : #MrRuleFeedbackPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleFeedback',
		'isReasonableYes',
		'isReasonableNo',
		'isReasonableNotSure',
		'canBeAcceptedYes',
		'canBeAcceptedNotSure',
		'commentText',
		'feedbackChangedCallback',
		'canBeAcceptedNo',
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
			add: (SpBoxLayout newVertical
				add: 'Is this rule reasonable?' height: self labelHeight;
				add: #isReasonableYes height: self labelHeight;
				add: #isReasonableNo height: self labelHeight;
				add: #isReasonableNotSure height: self labelHeight;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'Can it be accepted?' height: self labelHeight;
				add: #canBeAcceptedYes height: self labelHeight;
				add: #canBeAcceptedNo height: self labelHeight;
				add: #canBeAcceptedNotSure height: self labelHeight;
				yourself);
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
MrRuleFeedbackPresenter >> initializePresenters [ 
	super initializePresenters.
	
	isReasonableYes := self newRadioButton.
	isReasonableNo := self newRadioButton.
	isReasonableNotSure := self newRadioButton.
	
	isReasonableYes associatedRadioButtons: { isReasonableNo . isReasonableNotSure }.
	
	isReasonableYes label: 'Yes'.
	isReasonableNo label: 'No'.
	isReasonableNotSure label: 'Not sure'.
	
	canBeAcceptedYes := self newRadioButton.
	canBeAcceptedNo := self newRadioButton.
	canBeAcceptedNotSure := self newRadioButton.
	
	canBeAcceptedYes associatedRadioButtons: { canBeAcceptedNo . canBeAcceptedNotSure }.
	
	canBeAcceptedYes label: 'Yes'.
	canBeAcceptedNo label: 'No'.
	canBeAcceptedNotSure label: 'Not sure'.
	
	commentText := self newText.
	
	helpButton := self newButton
		label: 'Help';
		icon: (self iconNamed: #help);
		yourself.
		
	saveButton := self newButton
		label: 'Save';
		yourself.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> saveFeedback [
]

{ #category : #'accessing model' }
MrRuleFeedbackPresenter >> setModelBeforeInitialization: aRuleFeedback [
	ruleFeedback := aRuleFeedback
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
