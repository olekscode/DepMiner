Class {
	#name : #DepImplementationsBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'methods',
		'classesList',
		'sourceCode'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepImplementationsBrowser class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 2;
		add: (SpBoxLayout newVertical
			add: 'Classes' height: self labelHeight;
			add: #classesList;
			yourself) width: 150;
		add: (SpBoxLayout newVertical
			add: 'Implementation' height: self labelHeight;
			add: #sourceCode;
			yourself);
		yourself.
]

{ #category : #accessing }
DepImplementationsBrowser class >> preferredExtent [
	^ 800@400
]

{ #category : #initialization }
DepImplementationsBrowser >> connectPresenters [
	super connectPresenters.
	
	classesList whenSelectionChangedDo: [ :selectionMode |
		sourceCode text: classesList selectedItem sourceCode ].
]

{ #category : #initialization }
DepImplementationsBrowser >> initializePresenters [
	super initializePresenters.
	
	classesList := self newList
		display: [ :method | method className ];
		yourself.
		
	sourceCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
		
	self showMethods.
]

{ #category : #initialization }
DepImplementationsBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self windowTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #'accessing model' }
DepImplementationsBrowser >> setModelBeforeInitialization: aCollectionOfMethods [
	methods := aCollectionOfMethods
]

{ #category : #'as yet unclassified' }
DepImplementationsBrowser >> showMethods [
	classesList items: methods.
]

{ #category : #initialization }
DepImplementationsBrowser >> windowTitle [
	^ 'Implementations of ', methods first selector, ' in the new version of a project'
]
