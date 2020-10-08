Class {
	#name : #MrHelpPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'helpText',
		'okButton'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrHelpPresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 2;
		add: #helpText;
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #okButton width: 50;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #accessing }
MrHelpPresenter class >> defaultTitle [
	^ 'Help'
]

{ #category : #accessing }
MrHelpPresenter class >> preferredExtent [ 
	^ 400@300
]

{ #category : #initialization }
MrHelpPresenter >> connectPresenters [
	super connectPresenters.
	
	okButton action: [ self window close ].
]

{ #category : #initialization }
MrHelpPresenter >> initializePresenters [ 
	super initializePresenters.
	
	helpText := self newText
		text: text;
		beNotEditable;
		yourself.
	
	okButton := self newButton
		label: 'OK';
		yourself.
]

{ #category : #initialization }
MrHelpPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #'accessing model' }
MrHelpPresenter >> setModelBeforeInitialization: aString [
	text := aString
]
