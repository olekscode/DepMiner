Class {
	#name : #MrStonFileManager,
	#superclass : #MrFileManager,
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrStonFileManager >> loadRulesFromFile: aFileReference [
	^ aFileReference readStreamDo: [ :readStream |
        STON fromStream: readStream ]
]

{ #category : #'as yet unclassified' }
MrStonFileManager >> saveRules: aCollectionOfRules toFile: aFileReference [
	aFileReference writeStreamDo: [ :writeStream |
        STON put: aCollectionOfRules onStream: writeStream ]
]
