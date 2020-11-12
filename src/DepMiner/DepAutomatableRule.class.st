Class {
	#name : #DepAutomatableRule,
	#superclass : #DepAssociationRule,
	#instVars : [
		'transformationRule'
	],
	#category : #'DepMiner-Models'
}

{ #category : #testing }
DepAutomatableRule >> isAutomatable [
	^ true
]

{ #category : #accessing }
DepAutomatableRule >> transformationRule [
	^ transformationRule
]

{ #category : #accessing }
DepAutomatableRule >> transformationRule: anObject [
	transformationRule := anObject
]
