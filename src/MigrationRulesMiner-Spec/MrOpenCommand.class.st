Class {
	#name : #MrOpenCommand,
	#superclass : #MrCommand,
	#category : #'MigrationRulesMiner-Spec-Commands'
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
	| openFileDialog rules |
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		rules := selectedFile readStreamDo: [ :readStream |
        STON fromStream: readStream ].

		context addPageWithRules: rules title: selectedFile basename ].
	
	openFileDialog openWithSpec 
]
