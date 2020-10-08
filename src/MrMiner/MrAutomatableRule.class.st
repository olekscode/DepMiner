Class {
	#name : #MrAutomatableRule,
	#superclass : #MrRule,
	#instVars : [
		'transformationRule'
	],
	#category : #'MrMiner-Models'
}

{ #category : #testing }
MrAutomatableRule >> isAutomatable [
	^ true
]

{ #category : #accessing }
MrAutomatableRule >> transformationRule [
	^ transformationRule
]

{ #category : #accessing }
MrAutomatableRule >> transformationRule: anObject [
	transformationRule := anObject
]
