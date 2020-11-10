Class {
	#name : #DepRecommendations,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #'MrMiner-Models'
}

{ #category : #accessing }
DepRecommendations >> rules [
	^ rules
]

{ #category : #accessing }
DepRecommendations >> rules: anObject [
	rules := anObject
]
