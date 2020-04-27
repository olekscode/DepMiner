Class {
	#name : #MRMessageSendChanges,
	#superclass : #Object,
	#instVars : [
		'methodChange',
		'addedMessageSends',
		'deletedMessageSends'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRMessageSendChanges >> addedMessageSends [
	^ addedMessageSends
]

{ #category : #accessing }
MRMessageSendChanges >> addedMessageSends: anObject [
	addedMessageSends := anObject
]

{ #category : #converting }
MRMessageSendChanges >> asAprioriTransaction [
	^ MRAprioriTransaction fromMessageSendChanges: self
]

{ #category : #accessing }
MRMessageSendChanges >> deletedMessageSends [
	^ deletedMessageSends
]

{ #category : #accessing }
MRMessageSendChanges >> deletedMessageSends: anObject [
	deletedMessageSends := anObject
]

{ #category : #accessing }
MRMessageSendChanges >> methodChange [
	^ methodChange
]

{ #category : #accessing }
MRMessageSendChanges >> methodChange: anObject [
	methodChange := anObject
]
