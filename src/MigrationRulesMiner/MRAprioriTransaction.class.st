Class {
	#name : #MRAprioriTransaction,
	#superclass : #Set,
	#category : #MigrationRulesMiner
}

{ #category : #'instance creation' }
MRAprioriTransaction class >> fromMessageSendChanges: changes [
	^ self new
		initializeWithMessageSendChanges: changes;
		yourself.
]

{ #category : #initialization }
MRAprioriTransaction >> initializeWithMessageSendChanges: changes [
	self addAll: (changes deletedMessageSends collect: [ :messageNode |
		'deleted-send(', messageNode selector, ')' ]).
	
	self addAll: (changes addedMessageSends collect: [ :messageNode |
		'added-send(', messageNode selector, ')' ]).
]
