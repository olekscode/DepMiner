Class {
	#name : #MrMethodCallCollector,
	#superclass : #Object,
	#category : #'MigrationRulesMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMethodCallCollector >> collectMethodCallsFrom: aSourceCode [
	| ast visitor |
	ast := RBParser parseMethod: aSourceCode.
	
	visitor := MrMethodCallCollectingVisitor new.
	ast acceptVisitor: visitor.
	^ visitor methodCalls asSet
]

{ #category : #'as yet unclassified' }
MrMethodCallCollector >> extractAddedAndDeletedMethodCallsFrom: aMethodChange [
	| oldCalls newCalls |
	
	oldCalls := self collectMethodCallsFrom: aMethodChange oldSourceCode.
	newCalls := self collectMethodCallsFrom: aMethodChange newSourceCode.
	
	aMethodChange addedMethodCalls: (newCalls difference: oldCalls).
	aMethodChange deletedMethodCalls: (oldCalls difference: newCalls).
	
	
]
