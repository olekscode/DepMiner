Class {
	#name : #DepRecommendations,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #'DepMiner-Models'
}

{ #category : #accessing }
DepRecommendations >> rules [
	^ rules
]

{ #category : #accessing }
DepRecommendations >> rules: anObject [
	rules := anObject
]
