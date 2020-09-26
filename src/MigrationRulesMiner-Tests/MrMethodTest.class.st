Class {
	#name : #MrMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'method1',
		'method2',
		'method3',
		'method4',
		'method5'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrMethodTest >> setUp [
	super setUp.
	
	method1 := MrMethod new 
		className: 'Object';
		selector: 'new';
		yourself.
		
	method2 := MrMethod new 
		className: 'Object';
		selector: 'new';
		yourself.
		
	method3 := MrMethod new 
		className: 'Object';
		selector: 'initialize';
		yourself.
		
	method4 := MrMethod new 
		className: 'Collection';
		selector: 'new';
		yourself.
		
	method5 := MrMethod new 
		className: 'Collection';
		selector: 'initialize';
		yourself.
]

{ #category : #tests }
MrMethodTest >> testEquality [ 
	self assert: method2 equals: method1.
	self deny: method3 equals: method1.
	self deny: method4 equals: method1.
	self deny: method5 equals: method1.
]

{ #category : #tests }
MrMethodTest >> testHash [
	self assert: method2 hash equals: method1 hash.
	self deny: method3 hash equals: method1 hash.
	self deny: method4 hash equals: method1 hash.
	self deny: method5 hash equals: method1 hash.
]

{ #category : #tests }
MrMethodTest >> testSet [
	| set |
	set := { method1 . method2 . method3 . method4 . method5 } asSet.
	
	self assert: set size equals: 4.
	self assert: (set includes: method1).
	self assert: (set includes: method2).
	self assert: (set includes: method3).
	self assert: (set includes: method4).
	self assert: (set includes: method5).
]
