Class {
	#name : #MrRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule1',
		'rule2',
		'rule3'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrRuleTest >> setUp [ 
	super setUp.
	
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
]

{ #category : #tests }
MrRuleTest >> testEquality [ 
	self assert: rule2 equals: rule1.
	self deny: rule3 equals: rule1.
]

{ #category : #tests }
MrRuleTest >> testHash [
	self assert: rule2 hash equals: rule1 hash.
	self deny: rule3 hash equals: rule1 hash.
]

{ #category : #tests }
MrRuleTest >> testSet [
	| set |
	set := { rule1 . rule2 . rule3 } asSet.
	
	self assert: set size equals: 2.
	self assert: (set includes: rule1).
	self assert: (set includes: rule2).
	self assert: (set includes: rule3).
]
