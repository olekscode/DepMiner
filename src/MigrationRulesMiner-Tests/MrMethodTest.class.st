Class {
	#name : #MrMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'method1',
		'method2',
		'method3',
		'method4'
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
		
	"Same as method1"
	method2 := MrMethod new 
		className: 'Object';
		selector: 'new';
		yourself.
		
	"Different className"
	method3 := MrMethod new 
		className: 'Collection';
		selector: 'new';
		yourself.
		
	"Different selector"
	method4 := MrMethod new 
		className: 'Object';
		selector: 'initialize';
		yourself.
]

{ #category : #tests }
MrMethodTest >> testEquality [ 
	self assert: method2 equals: method1.
	self deny: method3 equals: method1.
	self deny: method4 equals: method1.
]

{ #category : #tests }
MrMethodTest >> testHash [
	self assert: method2 hash equals: method1 hash.
	self deny: method3 hash equals: method1 hash.
	self deny: method4 hash equals: method1 hash.
]

{ #category : #tests }
MrMethodTest >> testSet [
	| set |
	set := { method1 . method2 . method3 . method4 } asSet.
	
	self assert: set size equals: 3.
	self assert: (set includes: method1).
	self assert: (set includes: method2).
	self assert: (set includes: method3).
	self assert: (set includes: method4).
]
