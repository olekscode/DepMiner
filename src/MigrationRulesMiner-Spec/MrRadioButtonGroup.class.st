Class {
	#name : #MrRadioButtonGroup,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'textLabel',
		'yesButton',
		'noButton',
		'notSureButton'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRadioButtonGroup class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #textLabel height: self labelHeight;
		add: #yesButton height: self labelHeight;
		add: #noButton height: self labelHeight;
		add: #notSureButton height: self labelHeight;
		yourself.
]

{ #category : #accessing }
MrRadioButtonGroup >> buttons [
	^ { yesButton }, yesButton associatedRadioButtons
]

{ #category : #initialization }
MrRadioButtonGroup >> initializePresenters [
	super initializePresenters.
	
	textLabel := self newLabel
		label: text;
		yourself.
	
	yesButton := self newRadioButton.
	noButton := self newRadioButton.
	notSureButton := self newRadioButton.
	
	yesButton associatedRadioButtons: { noButton . notSureButton }.
	notSureButton state: true.
	
	yesButton label: 'Yes'.
	noButton label: 'No'.
	notSureButton label: 'Not sure'. 
]

{ #category : #enumerating }
MrRadioButtonGroup >> selectOption: aString [
	self buttons
		detect: [ :radio | radio label = aString ]
		ifFound: [ :radio | radio state: true ].
]

{ #category : #accessing }
MrRadioButtonGroup >> selectedOption [
	^ self buttons
		detect: [ :radio | radio state ]
		ifFound: [ :radio | radio label ]
		ifNone: [ nil ]
]

{ #category : #'accessing model' }
MrRadioButtonGroup >> setModelBeforeInitialization: aString [
	text := aString
]
