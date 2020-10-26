Class {
	#name : #MrMinerModel,
	#superclass : #Object,
	#instVars : [
		'repository'
	],
	#category : #'MrMiner-Models'
}

{ #category : #accessing }
MrMinerModel >> repository [
	^ repository
]

{ #category : #accessing }
MrMinerModel >> repository: anObject [
	repository := anObject
]
