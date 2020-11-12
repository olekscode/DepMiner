Class {
	#name : #DepSaveCommand,
	#superclass : #DepCommand,
	#category : #'DepMiner-Spec-Commands'
}

{ #category : #accessing }
DepSaveCommand class >> defaultDescription [
	^ 'Save rules and rule feedback into a file'
]

{ #category : #accessing }
DepSaveCommand class >> defaultIconName [ 
	^ #glamorousSave
]

{ #category : #accessing }
DepSaveCommand class >> defaultName [ 
	^ 'Save'
]

{ #category : #executing }
DepSaveCommand >> execute [
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
DepSaveCommand >> save [
	context currentExperiment fileReference writeStreamDo: [ :writeStream |
		STON put: context currentExperiment onStream: writeStream  ].
	
	context onSaved.
]
