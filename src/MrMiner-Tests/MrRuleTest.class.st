Class {
	#name : #MrRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule1',
		'rule2',
		'rule3',
		'rule4',
		'rule5',
		'rule6',
		'rule7',
		'rule8'
	],
	#category : #'MrMiner-Tests-Models'
}

{ #category : #running }
MrRuleTest >> setUp [ 
	| call1 call2 call3 call4 call5 method1 method2 commit1 commit2 change1 change2 |
	super setUp.
	
	call1 := RefrainMethodCall new
		selector: #add:;
		makeAdded;
		yourself.
		
	call2 := RefrainMethodCall new
		selector: #insert:;
		makeDeleted;
		yourself.
		
	call3 := RefrainMethodCall new 
		selector: #remove:;
		makeAdded;
		yourself.
		
	call4 := RefrainMethodCall new 
		selector: #delete:;
		makeDeleted;
		yourself.
		
	call5 := RefrainMethodCall new
		selector: #sum;
		makeAdded;
		yourself.
		
	method1 := RefrainMethod new 
		className: #Collection;
		selector: #do:;
		yourself.
		
	method2 := RefrainMethod new 
		className: #Object;
		selector: #new;
		yourself.
		
	commit1 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tags: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
	
	commit2 := DepCommit new
		sha: '3206cc82d9991e2acdd10916247c114e1b173e77';
		message: 'Lorem ipsum';
		tags: '2.0.0';
		datetime: '11-21-2020' asDateAndTime;
		yourself.	
		
	change1 := RefrainMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	change2 := RefrainMethodChange new 
		method: method2;
		commit: commit2;
		oldSourceCode: '3 * 5 asFloat';
		newSourceCode: '5 minus: 4';
		addedMethodCalls: { call1 . call5 };
		deletedMethodCalls: { call4 };
		yourself.
	
	rule1 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Same as rule1"
	rule2 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Different addedMethodCalls"
	rule3 := MrRule new 
		addedMethodCalls: { call1 . call5 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Different deletedMethodCalls"
	rule4 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call4 };
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Different count"
	rule5 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 25;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Different confidence"
	rule6 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.75;
		lift: 0.75;
		methodChanges: { change1 };
		yourself.
		
	"Different lift"
	rule7 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.5;
		lift: 0.3;
		methodChanges: { change1 };
		yourself.
		
	"Different methodChanges"
	rule8 := MrRule new 
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		count: 20;
		confidence: 0.5;
		lift: 0.75;
		methodChanges: { change2 };
		yourself.
]

{ #category : #tests }
MrRuleTest >> testEquality [ 
	self assert: rule2 equals: rule1.
	self deny: rule3 equals: rule1.
	self deny: rule4 equals: rule1.
	self deny: rule5 equals: rule1.
	self deny: rule6 equals: rule1.
	self deny: rule7 equals: rule1.
	self deny: rule8 equals: rule1.
]

{ #category : #tests }
MrRuleTest >> testHash [
	self assert: rule2 hash equals: rule1 hash.
	self deny: rule3 hash equals: rule1 hash.
	self deny: rule4 hash equals: rule1 hash.
	self deny: rule5 hash equals: rule1 hash.
	self deny: rule6 hash equals: rule1 hash.
	self deny: rule7 hash equals: rule1 hash.
	self deny: rule8 hash equals: rule1 hash.
]

{ #category : #tests }
MrRuleTest >> testSet [
	| set |
	set := { rule1 . rule2 . rule3 . rule4 . rule5 . rule6 . rule7 . rule8 } asSet.
	
	self assert: set size equals: 7.
	self assert: (set includes: rule1).
	self assert: (set includes: rule2).
	self assert: (set includes: rule3).
	self assert: (set includes: rule4).
	self assert: (set includes: rule5).
	self assert: (set includes: rule6).
	self assert: (set includes: rule7).
	self assert: (set includes: rule8).
]
