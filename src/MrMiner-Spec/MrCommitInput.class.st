Class {
	#name : #MrCommitInput,
	#superclass : #SpPresenter,
	#instVars : [
		'selectButton',
		'textInput'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrCommitInput class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: #textInput;
			add: #selectButton width: self inputTextHeight;
			yourself) height: (self inputTextHeight - 7);
		yourself.
]

{ #category : #examples }
MrCommitInput class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #accessing }
MrCommitInput >> action: aBlock [
	selectButton action: aBlock
]

{ #category : #initialization }
MrCommitInput >> initializePresenters [
	super initializePresenters.
	
	textInput := self newTextInput.
	
	selectButton := self newButton
		icon: (self iconNamed: #smallFind);
		yourself.
]

{ #category : #showing }
MrCommitInput >> text [
	^ textInput text
]

{ #category : #showing }
MrCommitInput >> text: aCommitSha [
	textInput text: aCommitSha
]
