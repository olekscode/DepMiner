Class {
	#name : #MrMethodChangeTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MrMethodChangeTest >> testEquality [ 
	| change1 change2 change3 |
	
	change1 := MrMethodChange new 
		method: MrMethod new;
		commit: MrCommit new;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: OrderedCollection new;
		deletedMethodCalls: OrderedCollection new;
		yourself.
		
	change2 := MrMethodChange new 
		method: MrMethod new;
		commit: MrCommit new;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: OrderedCollection new;
		deletedMethodCalls: OrderedCollection new;
		yourself.
		
	change3 := MrMethodChange new 
		method: MrMethod new;
		commit: MrCommit new;
		oldSourceCode: '5 - 6';
		newSourceCode: '5 minus: 6';
		addedMethodCalls: OrderedCollection new;
		deletedMethodCalls: OrderedCollection new;
		yourself.
		
	self assert: change2 equals: change1.
	self deny: change3 equals: change1.
]
