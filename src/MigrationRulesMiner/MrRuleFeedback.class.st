Class {
	#name : #MrRuleFeedback,
	#superclass : #Object,
	#instVars : [
		'isReasonable',
		'canBeAccepted',
		'comment'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #accessing }
MrRuleFeedback >> canBeAccepted [
	^ canBeAccepted
]

{ #category : #accessing }
MrRuleFeedback >> canBeAccepted: anObject [
	canBeAccepted := anObject
]

{ #category : #accessing }
MrRuleFeedback >> comment [
	^ comment
]

{ #category : #accessing }
MrRuleFeedback >> comment: anObject [
	comment := anObject
]

{ #category : #accessing }
MrRuleFeedback >> isReasonable [
	^ isReasonable
]

{ #category : #accessing }
MrRuleFeedback >> isReasonable: anObject [
	isReasonable := anObject
]
