Class {
	#name : #MRMigrationRule,
	#superclass : #Object,
	#instVars : [
		'antecedent',
		'consequent',
		'count',
		'confidence',
		'lift'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRMigrationRule >> antecedent [
	^ antecedent
]

{ #category : #accessing }
MRMigrationRule >> antecedent: anObject [
	antecedent := anObject
]

{ #category : #'as yet unclassified' }
MRMigrationRule >> asAutomatableMigrationRule [
	^ MRAutomatableMigrationRule newFrom: self.
	
]

{ #category : #'as yet unclassified' }
MRMigrationRule >> canBeAutomated [
	^ (antecedent size = 1) and: [
		(consequent size = 1) and: [
			(antecedent first allSatisfy: [ :each | each isAlphaNumeric or: [ each = $: ] ]) and: [
				(consequent first allSatisfy: [ :each | each isAlphaNumeric or: [ each = $: ] ]) and: [
					(antecedent first occurrencesOf: $:) = (consequent first occurrencesOf: $:) ] ] ] ]
]

{ #category : #accessing }
MRMigrationRule >> confidence [
	^ confidence
]

{ #category : #accessing }
MRMigrationRule >> confidence: anObject [
	confidence := anObject
]

{ #category : #accessing }
MRMigrationRule >> consequent [
	^ consequent
]

{ #category : #accessing }
MRMigrationRule >> consequent: anObject [
	consequent := anObject
]

{ #category : #accessing }
MRMigrationRule >> count [
	^ count
]

{ #category : #accessing }
MRMigrationRule >> count: anObject [
	count := anObject
]

{ #category : #accessing }
MRMigrationRule >> lift [
	^ lift
]

{ #category : #accessing }
MRMigrationRule >> lift: anObject [
	lift := anObject
]

{ #category : #printing }
MRMigrationRule >> printOn: aStream [
	aStream
		nextPut: ${;
		nextPutAll: (', ' join: antecedent);
		nextPutAll: '} => {';
		nextPutAll: (', ' join: consequent);
		nextPut: $}.
]
