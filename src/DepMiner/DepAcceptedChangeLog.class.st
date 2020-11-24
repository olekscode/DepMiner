Class {
	#name : #DepAcceptedChangeLog,
	#superclass : #Object,
	#instVars : [
		'datetime',
		'recommendation',
		'replacement',
		'proposedCode',
		'savedCode'
	],
	#category : #'DepMiner-Models'
}

{ #category : #accessing }
DepAcceptedChangeLog >> datetime [
	^ datetime
]

{ #category : #accessing }
DepAcceptedChangeLog >> datetime: anObject [
	datetime := anObject
]

{ #category : #accessing }
DepAcceptedChangeLog >> proposedCode [
	^ proposedCode
]

{ #category : #accessing }
DepAcceptedChangeLog >> proposedCode: anObject [
	proposedCode := anObject
]

{ #category : #accessing }
DepAcceptedChangeLog >> recommendation [
	^ recommendation
]

{ #category : #accessing }
DepAcceptedChangeLog >> recommendation: anObject [
	recommendation := anObject
]

{ #category : #accessing }
DepAcceptedChangeLog >> replacement [
	^ replacement
]

{ #category : #accessing }
DepAcceptedChangeLog >> replacement: anObject [
	replacement := anObject
]

{ #category : #accessing }
DepAcceptedChangeLog >> savedCode [
	^ savedCode
]

{ #category : #accessing }
DepAcceptedChangeLog >> savedCode: anObject [
	savedCode := anObject
]
