Class {
	#name : #MrMethodTreeLeafModel,
	#superclass : #MrMethodTreeModel,
	#instVars : [
		'value'
	],
	#category : #'MrMiner-Spec-ViewModels'
}

{ #category : #private }
MrMethodTreeLeafModel >> numberOfMethods [
	^ 1
]

{ #category : #accessing }
MrMethodTreeLeafModel >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #evaluating }
MrMethodTreeLeafModel >> value [
	^ value
]

{ #category : #accessing }
MrMethodTreeLeafModel >> value: anObject [
	value := anObject
]
