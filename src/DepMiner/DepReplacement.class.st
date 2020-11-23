Class {
	#name : #DepReplacement,
	#superclass : #Object,
	#instVars : [
		'method',
		'rule'
	],
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepReplacement class >> for: aMethod definedBy: aRule [
	| concreteSubclass |
	
	concreteSubclass := aRule isAutomatable
		ifTrue: [ DepAutomatableReplacement ]
		ifFalse: [ DepNonAutomatableReplacement ].
	
	^ concreteSubclass new
		initializeMethod: aMethod
		rule: aRule;
		yourself.
]

{ #category : #'as yet unclassified' }
DepReplacement >> generateDeprecation [
	^ self generateDeprecationWithMessage: self generateDeprecationMessage
]

{ #category : #'as yet unclassified' }
DepReplacement >> generateDeprecationMessage [
	| selectors proposedReplacements |
	selectors := rule addedMethodCalls asOrderedCollection collect: [ :each | '#', each selector ].
	
	proposedReplacements := selectors size = 1
		ifTrue: [ selectors first ]
		ifFalse: [ (', ' join: selectors allButLast), ' and ', selectors last ].
	
	^ 'Use ', proposedReplacements, ' instead'
]

{ #category : #'as yet unclassified' }
DepReplacement >> generateDeprecationWithMessage: aDeprecationMessage [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
DepReplacement >> generateSourceCodeAfterDeprecation [
	self subclassResponsibility
]

{ #category : #initialization }
DepReplacement >> initializeMethod: aMethod rule: aRule [
	method := aMethod.
	rule := aRule.
]

{ #category : #testing }
DepReplacement >> isAutomatable [
	self subclassResponsibility
]

{ #category : #accessing }
DepReplacement >> method [
	^ method
]

{ #category : #accessing }
DepReplacement >> rule [
	^ rule
]
