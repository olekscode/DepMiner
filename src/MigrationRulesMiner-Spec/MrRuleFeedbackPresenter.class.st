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
		'canBeAcceptedNo'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRuleFeedbackPresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical 
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
			yourself) height: 5 * self labelHeight;
		add: 'Comment' height: self labelHeight;
		add: #commentText;
		yourself.
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> canBeAcceptedNo [
	^ canBeAcceptedNo
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> canBeAcceptedNotSure [
	^ canBeAcceptedNotSure
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> canBeAcceptedYes [
	^ canBeAcceptedYes
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> commentText [
	^ commentText
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
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> isReasonableNo [
	^ isReasonableNo
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> isReasonableNotSure [
	^ isReasonableNotSure
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> isReasonableYes [
	^ isReasonableYes
]

{ #category : #'accessing model' }
MrRuleFeedbackPresenter >> setModelBeforeInitialization: aRuleFeedback [
	ruleFeedback := aRuleFeedback
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
