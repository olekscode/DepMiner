Extension { #name : #APrioriItemset }

{ #category : #'*MigrationRulesMiner' }
APrioriItemset >> asMigrationRule [
	| addedMessageSends deletedMessageSends |
	
	addedMessageSends := self
		select: [ :each | each beginsWith: 'added-send' ]
		thenCollect: [ :each | each copyFrom: 12 to: each size - 1 ].
		
	deletedMessageSends := self
		select: [ :each | each beginsWith: 'deleted-send' ]
		thenCollect: [ :each | each copyFrom: 14 to: each size - 1 ].
		
	^ MRMigrationRule new
		antecedent: deletedMessageSends asSet;
		consequent: addedMessageSends asSet;
		support: self support;
		yourself.
]
