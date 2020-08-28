Class {
	#name : #MRAutomatableMigrationRule,
	#superclass : #MRMigrationRule,
	#instVars : [
		'transformationRule',
		'numberOfArguments'
	],
	#category : #MigrationRulesMiner
}

{ #category : #'instance creation' }
MRAutomatableMigrationRule class >> newFrom: aMigrationRule [
	^ self new initializeMigrationRule: aMigrationRule; yourself 
]

{ #category : #'as yet unclassified' }
MRAutomatableMigrationRule >> generateTransformationRuleExpressionFrom: aSelector [
	numberOfArguments = 0 ifTrue: [ 
		^ '`@rec ', aSelector ].
	
	numberOfArguments = 1 ifTrue: [ 
		^ '`@rec ', aSelector, '`@arg' ].
	
	^ '`@rec ', ' ' join: (((aSelector splitOn: $:) copyFrom: 1 to: numberOfArguments) withIndexCollect: [ :selectorPart :i | selectorPart, ': `@arg', i asString ]).
]

{ #category : #initialization }
MRAutomatableMigrationRule >> initializeMigrationRule: aMigrationRule [
	antecedent := aMigrationRule antecedent.
	consequent := aMigrationRule consequent.
	count := aMigrationRule count.
	confidence := aMigrationRule confidence.
	lift := aMigrationRule lift.
	
	numberOfArguments := antecedent first occurrencesOf: $:.
	self initializeTransformationRule.
]

{ #category : #initialization }
MRAutomatableMigrationRule >> initializeTransformationRule [ 
	transformationRule := PDTransformationRule new
		antecedent: (self generateTransformationRuleExpressionFrom: antecedent first);
		consequent: (self generateTransformationRuleExpressionFrom: consequent first);
		yourself.
]

{ #category : #accessing }
MRAutomatableMigrationRule >> numberOfArguments [
	^ numberOfArguments
]

{ #category : #accessing }
MRAutomatableMigrationRule >> transformationRule [
	^ transformationRule
]
