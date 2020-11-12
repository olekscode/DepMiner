Extension { #name : #APrioriAssociationRule }

{ #category : #'*DepMiner' }
APrioriAssociationRule >> asDepAssociationRule [
	^ DepAssociationRule new
		deletedMethodCalls: key asSet;
		addedMethodCalls: value asSet;
		count: self count;
		confidence: self confidence;
		lift: self lift.
]
