Class {
	#name : #MrCommitSelect,
	#superclass : #SpPresenter,
	#instVars : [
		'textEdit',
		'selectButton'
	],
	#category : #'MrMiner-Spec-NewViews'
}

{ #category : #specs }
MrCommitSelect class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: #textEdit;
			add: #selectButton width: self inputTextHeight;
			yourself) height: (self inputTextHeight - 7);
		yourself.
]

{ #category : #examples }
MrCommitSelect class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #initialization }
MrCommitSelect >> connectPresenters [
	super connectPresenters.
	
	selectButton action: [  ]
]

{ #category : #initialization }
MrCommitSelect >> initializePresenters [
	super initializePresenters.
	
	textEdit := self newTextInput.
	
	selectButton := self newButton
		icon: (self iconNamed: #smallFind);
		yourself.
]

{ #category : #showing }
MrCommitSelect >> show: aCommitSha [
	textEdit text: aCommitSha
]
