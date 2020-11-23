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
