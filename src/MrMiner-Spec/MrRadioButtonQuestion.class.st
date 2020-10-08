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
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrRadioButtonQuestion class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: #helpLink width: 17;
			add: #textLabel;
			yourself) height: self labelHeight;
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

{ #category : #protocol }
MrRadioButtonQuestion >> disable [
	self buttons do: [ :each | each disable ].
	helpLink disable.
	textLabel disable.
]

{ #category : #protocol }
MrRadioButtonQuestion >> enable [
	self buttons do: [ :each | each enable ].
	helpLink enable.
	textLabel enable.
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
		label: '[?]';
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
		ifFound: [ :radio | radio state: true ]
		ifNone: [ notSureButton state: true ].
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

{ #category : #enumerating }
MrRadioButtonQuestion >> whenNoDo: aBlock [
	noButton whenActivatedDo: aBlock
]

{ #category : #enumerating }
MrRadioButtonQuestion >> whenNoOrNotSureDo: aBlock [
	yesButton whenDeactivatedDo: aBlock
]

{ #category : #enumerating }
MrRadioButtonQuestion >> whenYesDo: aBlock [
	yesButton whenActivatedDo: aBlock
]

{ #category : #enumerating }
MrRadioButtonQuestion >> whenYesOrNotSureDo: aBlock [
	noButton whenDeactivatedDo: aBlock
]
