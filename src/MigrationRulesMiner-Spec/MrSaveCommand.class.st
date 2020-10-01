Class {
	#name : #MrSaveCommand,
	#superclass : #MrCommand,
	#category : #'MigrationRulesMiner-Spec-Commands'
}

{ #category : #accessing }
MrSaveCommand class >> defaultDescription [
	^ 'Save rules and rule feedback into a file'
]

{ #category : #accessing }
MrSaveCommand class >> defaultIconName [ 
	^ #glamorousSave
]

{ #category : #accessing }
MrSaveCommand class >> defaultName [ 
	^ 'Save'
]

{ #category : #executing }
MrSaveCommand >> execute [
	| saveFileDialog |
	context currentExperiment fileReference
		ifNotNil: [ self save ]
		ifNil: [ 
			saveFileDialog := FDSaveFileDialog new whenSelected: [ :selectedFile |
				context currentExperiment fileReference: selectedFile.
				self save ].
		
			saveFileDialog openWithSpec ].
	
]

{ #category : #files }
MrSaveCommand >> save [
	context currentExperiment fileReference writeStreamDo: [ :writeStream |
		STON put: context currentExperiment onStream: writeStream  ].
	
	context onFileSaved.
]
