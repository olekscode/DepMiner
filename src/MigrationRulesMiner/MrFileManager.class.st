Class {
	#name : #MrFileManager,
	#superclass : #Object,
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrFileManager >> loadRulesFromFile: aFileReference [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MrFileManager >> saveRules: aCollectionOfRules toFile: aFileReference [
	self subclassResponsibility
]
