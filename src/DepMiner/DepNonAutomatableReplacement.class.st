Class {
	#name : #DepNonAutomatableReplacement,
	#superclass : #DepReplacement,
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepNonAutomatableReplacement >> generateDeprecationWithMessage: aDeprecationMessage [
	^ 'self deprecated: ''', aDeprecationMessage, '''.'
]

{ #category : #'as yet unclassified' }
DepNonAutomatableReplacement >> generateSourceCodeAfterDeprecation [

	^ (RBSequenceNode statements: method ast statements) formattedCode.
]

{ #category : #testing }
DepNonAutomatableReplacement >> isAutomatable [
	^ false
]
