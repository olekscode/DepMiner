Class {
	#name : #MrRuleTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MrRuleTest >> testEquality [ 
	| rule1 rule2 rule3 |
	
	rule1 := MrRule new 
		addedMethodCalls: #(isEmpty not);
		deletedMethodCalls: #(isNotEmpty);
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		yourself.
		
	rule2 := MrRule new 
		addedMethodCalls: #(isEmpty not);
		deletedMethodCalls: #(isNotEmpty);
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		yourself.
		
	rule3 := MrRule new 
		addedMethodCalls: #(lf);
		deletedMethodCalls: #(lineEnding);
		count: 25;
		confidence: 0.6;
		lift: 0.7;
		yourself.
		
	self assert: rule2 equals: rule1.
	self deny: rule3 equals: rule1.
]
