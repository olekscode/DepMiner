Class {
	#name : #MrMethodCallTest,
	#superclass : #TestCase,
	#instVars : [
		'call1',
		'call2',
		'call3'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrMethodCallTest >> setUp [
	super setUp.
	
	call1 := MrMethodCall new 
		selector: #collect:;
		yourself.
		
	call2 := MrMethodCall new 
		selector: #collect:;
		yourself.
		
	call3 := MrMethodCall new 
		selector: #isEmpty;
		yourself.
]

{ #category : #tests }
MrMethodCallTest >> testEquality [ 
	self assert: call2 equals: call1.
	self deny: call3 equals: call1.
]

{ #category : #tests }
MrMethodCallTest >> testHash [
	self assert: call2 hash equals: call1 hash.
	self deny: call3 hash equals: call1 hash.
]

{ #category : #tests }
MrMethodCallTest >> testSet [
	| set |
	set := { call1 . call2 . call3 } asSet.
	
	self assert: set size equals: 2.
	self assert: (set includes: call1).
	self assert: (set includes: call2).
	self assert: (set includes: call3).
]
