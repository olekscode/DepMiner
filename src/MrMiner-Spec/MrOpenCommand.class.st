Class {
	#name : #MrOpenCommand,
	#superclass : #MrCommand,
	#category : #'MrMiner-Spec-Commands'
}

{ #category : #default }
MrOpenCommand class >> defaultDescription [
	^ 'Open the file containing the rules and rule feedback'
]

{ #category : #default }
MrOpenCommand class >> defaultIconName [
	^ #glamorousOpen
]

{ #category : #default }
MrOpenCommand class >> defaultName [
	^ 'Open'
]

{ #category : #executing }
MrOpenCommand >> execute [
	| openFileDialog |
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		self open: selectedFile ].
	
	openFileDialog openWithSpec 
]

{ #category : #executing }
MrOpenCommand >> open: aFileReference [
	| experiment |
	experiment := aFileReference readStreamDo: [ :readStream |
		STON fromStream: readStream ].

	context addPageWithExperiment: experiment title: aFileReference basename.
]
