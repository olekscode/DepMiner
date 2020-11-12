Class {
	#name : #DepMethodTreeLeafModel,
	#superclass : #DepMethodTreeModel,
	#instVars : [
		'value'
	],
	#category : #'DepMiner-Spec-ViewModels'
}

{ #category : #private }
DepMethodTreeLeafModel >> numberOfMethods [
	^ 1
]

{ #category : #accessing }
DepMethodTreeLeafModel >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #'as yet unclassified' }
DepMethodTreeLeafModel >> receiveClickActionFrom: aView [
	aView onMethodClicked: self valueToInspect
]

{ #category : #evaluating }
DepMethodTreeLeafModel >> value [
	^ value
]

{ #category : #accessing }
DepMethodTreeLeafModel >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
DepMethodTreeLeafModel >> valueToInspect [
	^ value
]
