Class {
	#name : #MrMethodCallTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MrMethodCallTest >> testEquality [ 
	| call1 call2 call3 |
	
	call1 := MrMethodCall new 
		selector: #collect:;
		yourself.
		
	call2 := MrMethodCall new 
		selector: #collect:;
		yourself.
		
	call3 := MrMethodCall new 
		selector: #isEmpty;
		yourself.
		
	self assert: call2 equals: call1.
	self deny: call3 equals: call1.
]
