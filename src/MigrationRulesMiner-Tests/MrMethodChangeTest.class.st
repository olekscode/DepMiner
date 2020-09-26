Class {
	#name : #MrMethodChangeTest,
	#superclass : #TestCase,
	#instVars : [
		'change1',
		'change2',
		'change3'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrMethodChangeTest >> setUp [
	super setUp.
	
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
]

{ #category : #tests }
MrMethodChangeTest >> testEquality [ 
	self assert: change2 equals: change1.
	self deny: change3 equals: change1.
]

{ #category : #tests }
MrMethodChangeTest >> testHash [
	self assert: change2 hash equals: change1 hash.
	self deny: change3 hash equals: change1 hash.
]

{ #category : #tests }
MrMethodChangeTest >> testSet [
	| set |
	set := { change1 . change2 . change3 } asSet.
	
	self assert: set size equals: 2.
	self assert: (set includes: change1).
	self assert: (set includes: change2).
	self assert: (set includes: change3).
]
