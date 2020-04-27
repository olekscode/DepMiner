Class {
	#name : #MRMigrationRuleJsonWriter,
	#superclass : #Object,
	#category : #MigrationRulesMiner
}

{ #category : #'as yet unclassified' }
MRMigrationRuleJsonWriter class >> loadRulesFromJson: aFileReference [
	| jsonString |
	jsonString := aFileReference contents.
	
	^ (STONJSON fromString: jsonString) collect: [ :each |
		MRMigrationRule new
			antecedent: (each at: 'antecedent');
			consequent: (each at: 'consequent');
			yourself ].
]

{ #category : #'as yet unclassified' }
MRMigrationRuleJsonWriter class >> saveRules: aCollectionOfRules toJson: aFileReference [
	| jsonString |
	
	jsonString := STONJSON toString: (aCollectionOfRules collect: [ :rule |
		{
			'antecedent' -> rule antecedent asArray .
			'consequent' -> rule consequent asArray
		} asDictionary ]) asArray.
	
	aFileReference writeStreamDo: [ :stream |
		stream nextPutAll: jsonString ].
]
