Class {
	#name : #MrRadioButtonQuestion,
	#superclass : #SpPresenter,
	#instVars : [
		'textLabel',
		'helpLink',
		'yesButton',
		'noButton',
		'notSureButton'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRadioButtonQuestion class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #textLabel height: self labelHeight;
		add: #helpLink height: self labelHeight;
		add: #yesButton height: self labelHeight;
		add: #noButton height: self labelHeight;
		add: #notSureButton height: self labelHeight;
		yourself.
]

{ #category : #accessing }
MrRadioButtonQuestion >> buttons [
	^ { yesButton }, yesButton associatedRadioButtons
]

{ #category : #initialization }
MrRadioButtonQuestion >> connectPresenters [	
	helpLink action: [ 
		(MrHelpPresenter on: self helpText) openWithSpec ].
]

{ #category : #accessing }
MrRadioButtonQuestion >> helpText [
	self subclassResponsibility
]

{ #category : #initialization }
MrRadioButtonQuestion >> initializePresenters [
	super initializePresenters.
	
	textLabel := self newLabel
		label: self text;
		yourself.
		
	helpLink := self newLink
		label: '(help)';
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
MrRadioButtonQuestion >> selectOption: aString [
	self buttons
		detect: [ :radio | radio label = aString ]
		ifFound: [ :radio | radio state: true ].
]

{ #category : #accessing }
MrRadioButtonQuestion >> selectedOption [
	^ self buttons
		detect: [ :radio | radio state ]
		ifFound: [ :radio | radio label ]
		ifNone: [ nil ]
]

{ #category : #accessing }
MrRadioButtonQuestion >> text [
	self subclassResponsibility
]
