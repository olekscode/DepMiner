Class {
	#name : #DepOpenCommand,
	#superclass : #DepCommand,
	#category : #'DepMiner-Spec-Commands'
}

{ #category : #default }
DepOpenCommand class >> defaultDescription [
	^ 'Open the file containing the rules and rule feedback'
]

{ #category : #default }
DepOpenCommand class >> defaultIconName [
	^ #glamorousOpen
]

{ #category : #default }
DepOpenCommand class >> defaultName [
	^ 'Open'
]

{ #category : #executing }
DepOpenCommand >> execute [
	| openFileDialog |
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		self open: selectedFile ].
	
	openFileDialog openWithSpec 
]

{ #category : #executing }
DepOpenCommand >> open: aFileReference [
	| experiment |
	experiment := aFileReference readStreamDo: [ :readStream |
		STON fromStream: readStream ].

	experiment fileReference: aFileReference.
	context addPageWithExperiment: experiment title: aFileReference basename.
]
