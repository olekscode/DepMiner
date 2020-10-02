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

{ #category : #testing }
MrRuleFeedbackPresenter >> canBeAcceptedRadioButtons [
	^ { canBeAcceptedYes }, canBeAcceptedYes associatedRadioButtons
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> connectPresenters [
	super connectPresenters.
	
	helpButton action: [ MrFeedbackHelpPresenter new openWithSpec ].
	saveButton action: [ self saveFeedback ].
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializeCanBeAcceptedRadioButtons [
	canBeAcceptedYes := self newRadioButton.
	canBeAcceptedNo := self newRadioButton.
	canBeAcceptedNotSure := self newRadioButton.
	
	canBeAcceptedYes associatedRadioButtons: { canBeAcceptedNo . canBeAcceptedNotSure }.
	canBeAcceptedNotSure state: true.
	
	canBeAcceptedYes label: 'Yes'.
	canBeAcceptedNo label: 'No'.
	canBeAcceptedNotSure label: 'Not sure'.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializeEmptyRuleFeedback [
	ruleFeedback := MrRuleFeedback new.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializeIsReasonableRadioButtons [
	isReasonableYes := self newRadioButton.
	isReasonableNo := self newRadioButton.
	isReasonableNotSure := self newRadioButton.
	
	isReasonableYes associatedRadioButtons: { isReasonableNo . isReasonableNotSure }.
	isReasonableNotSure state: true.
	
	isReasonableYes label: 'Yes'.
	isReasonableNo label: 'No'.
	isReasonableNotSure label: 'Not sure'.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializePresenters [ 
	super initializePresenters.
	
	self initializeIsReasonableRadioButtons.
	self initializeCanBeAcceptedRadioButtons.
	
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

{ #category : #testing }
MrRuleFeedbackPresenter >> isReasonableRadioButtons [
	^ { isReasonableYes }, isReasonableYes associatedRadioButtons
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
	ruleFeedback isReasonable:
		(self isReasonableRadioButtons
			detect: [ :radio | radio state ]
			ifFound: [ :radio | radio label ]
			ifNone: [ nil ]).
		
	ruleFeedback canBeAccepted:
		(self canBeAcceptedRadioButtons
			detect: [ :radio | radio state ]
			ifFound: [ :radio | radio label ]
			ifNone: [ nil ]).
	
	ruleFeedback comment: commentText text.
	feedbackChangedCallback value: ruleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> showRuleFeedback [ 
	ruleFeedback isReasonable
		ifNil: [ isReasonableNotSure state: true ]
		ifNotNil: [ 
			(self isReasonableRadioButtons
				detect: [ :radio | radio label = ruleFeedback isReasonable ])
				state: true ].
		
	ruleFeedback canBeAccepted
		ifNil: [ canBeAcceptedNotSure state: true ]
		ifNotNil: [ 
			(self canBeAcceptedRadioButtons
				detect: [ :radio | radio label = ruleFeedback canBeAccepted ])
				state: true ].
		
	ruleFeedback comment
		ifNil: [ commentText text: '' ]
		ifNotNil: [ commentText text: ruleFeedback comment ].
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
