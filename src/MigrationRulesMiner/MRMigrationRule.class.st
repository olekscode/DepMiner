Class {
	#name : #MRMigrationRule,
	#superclass : #Object,
	#instVars : [
		'antecedent',
		'consequent',
		'support'
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

{ #category : #accessing }
MRMigrationRule >> consequent [
	^ consequent
]

{ #category : #accessing }
MRMigrationRule >> consequent: anObject [
	consequent := anObject
]

{ #category : #accessing }
MRMigrationRule >> support [
	^ support
]

{ #category : #accessing }
MRMigrationRule >> support: anObject [
	support := anObject
]
