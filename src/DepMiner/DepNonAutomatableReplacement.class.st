Class {
	#name : #DepNonAutomatableReplacement,
	#superclass : #DepReplacement,
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepNonAutomatableReplacement >> generateDeprecationWithMessage: aDeprecationMessage [
	^ 'self deprecated: ''', aDeprecationMessage, '''.'
]

{ #category : #testing }
DepNonAutomatableReplacement >> isAutomatable [
	^ false
]
