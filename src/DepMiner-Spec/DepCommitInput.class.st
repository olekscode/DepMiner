Class {
	#name : #DepCommitInput,
	#superclass : #SpPresenter,
	#instVars : [
		'selectButton',
		'textInput'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepCommitInput class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: #textInput;
			add: #selectButton width: self inputTextHeight;
			yourself) height: (self inputTextHeight - 7);
		yourself.
]

{ #category : #examples }
DepCommitInput class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #accessing }
DepCommitInput >> action: aBlock [
	selectButton action: aBlock
]

{ #category : #initialization }
DepCommitInput >> initializePresenters [
	super initializePresenters.
	
	textInput := self newTextInput.
	
	selectButton := self newButton
		icon: (self iconNamed: #smallFind);
		yourself.
]

{ #category : #showing }
DepCommitInput >> text [
	^ textInput text
]

{ #category : #showing }
DepCommitInput >> text: aCommitSha [
	textInput text: aCommitSha
]
