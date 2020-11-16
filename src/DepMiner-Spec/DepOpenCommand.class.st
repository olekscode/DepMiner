Class {
	#name : #DepOpenCommand,
	#superclass : #DepCommand,
	#category : #'DepMiner-Spec-Commands'
}

{ #category : #default }
DepOpenCommand class >> defaultDescription [
	^ 'Open the file containing the settings, project history, and recommendation'
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
	| openFileDialog modelDictionary |
	
	openFileDialog := FDOpenFileDialog new whenSelected: [ :selectedFile |
		modelDictionary := selectedFile readStreamDo: [ :readStream |
			STON fromStream: readStream ].

		context
			loadWithSettings: (modelDictionary at: 'settings')
			projectHistory: (modelDictionary at: 'projectHistory')
			recommendations: (modelDictionary at: 'recommendations') ].
	
	openFileDialog openWithSpec 
]
