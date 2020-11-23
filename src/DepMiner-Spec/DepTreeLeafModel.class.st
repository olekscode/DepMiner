Class {
	#name : #DepTreeLeafModel,
	#superclass : #DepTreeModel,
	#instVars : [
		'value'
	],
	#category : #'DepMiner-Spec-ViewModels'
}

{ #category : #private }
DepTreeLeafModel >> numberOfLeaves [
	^ 1
]

{ #category : #'as yet unclassified' }
DepTreeLeafModel >> receiveClickActionFrom: aView [
	aView onLeafClicked: self valueToInspect
]

{ #category : #evaluating }
DepTreeLeafModel >> value [
	^ value
]

{ #category : #accessing }
DepTreeLeafModel >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
DepTreeLeafModel >> valueToInspect [
	^ value
]
