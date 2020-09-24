Class {
	#name : #MrMethodTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MrMethodTest >> testEquality [ 
	| method1 method2 method3 method4 method5 |
	
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
		
	self assert: method2 equals: method1.
	self deny: method3 equals: method1.
	self deny: method4 equals: method1.
	self deny: method5 equals: method1.
]
