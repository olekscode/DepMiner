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
	Transcript open
]
