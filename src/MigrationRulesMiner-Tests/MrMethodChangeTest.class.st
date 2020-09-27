Class {
	#name : #MrMethodChangeTest,
	#superclass : #TestCase,
	#instVars : [
		'change1',
		'change2',
		'change3',
		'change4',
		'change5',
		'change6',
		'change7',
		'change8'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrMethodChangeTest >> setUp [
	| method1 method2 commit1 commit2 call1 call2 call3 call4 call5 |
	super setUp.
	
	method1 := MrMethod new 
		className: #Collection;
		selector: #do:;
		yourself.
		
	method2 := MrMethod new 
		className: #Object;
		selector: #new;
		yourself.
		
	commit1 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
	
	commit2 := MrCommit new
		sha: '3206cc82d9991e2acdd10916247c114e1b173e77';
		message: 'Lorem ipsum';
		tag: '2.0.0';
		datetime: '11-21-2020' asDateAndTime;
		yourself.	
	
	call1 := MrMethodCall new
		selector: #add:;
		makeAdded;
		yourself.
		
	call2 := MrMethodCall new
		selector: #insert:;
		makeDeleted;
		yourself.
		
	call3 := MrMethodCall new 
		selector: #remove:;
		makeAdded;
		yourself.
		
	call4 := MrMethodCall new 
		selector: #delete:;
		makeDeleted;
		yourself.
		
	call5 := MrMethodCall new
		selector: #sum;
		makeAdded;
		yourself.
	
	change1 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Same as change1"
	change2 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different method"
	change3 := MrMethodChange new 
		method: method2;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different commit"
	change4 := MrMethodChange new 
		method: method1;
		commit: commit2;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different oldSourceCode"
	change5 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '3 * 5 asFloat';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different newSourceCode"
	change6 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '5 minus: 4';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different addedMethodCalls"
	change7 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call5 };
		deletedMethodCalls: { call2 };
		yourself.
		
	"Different deletedMethodCalls"
	change8 := MrMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedMethodCalls: { call1 . call3 };
		deletedMethodCalls: { call4 };
		yourself.
]

{ #category : #tests }
MrMethodChangeTest >> testEquality [ 
	self assert: change2 equals: change1.
	self deny: change3 equals: change1.
	self deny: change4 equals: change1.
	self deny: change5 equals: change1.
	self deny: change6 equals: change1.
	self deny: change7 equals: change1.
	self deny: change8 equals: change1.
]

{ #category : #tests }
MrMethodChangeTest >> testHash [
	self assert: change2 hash equals: change1 hash.
	self deny: change3 hash equals: change1 hash.
	self deny: change4 hash equals: change1 hash.
	self deny: change5 hash equals: change1 hash.
	self deny: change6 hash equals: change1 hash.
	self deny: change7 hash equals: change1 hash.
	self deny: change8 hash equals: change1 hash.
]

{ #category : #tests }
MrMethodChangeTest >> testSet [
	| set |
	set := { change1 . change2 . change3 . change4 . change5 . change6 . change7 . change8 } asSet.
	
	self assert: set size equals: 7.
	self assert: (set includes: change1).
	self assert: (set includes: change2).
	self assert: (set includes: change3).
	self assert: (set includes: change4).
	self assert: (set includes: change5).
	self assert: (set includes: change6).
	self assert: (set includes: change7).
	self assert: (set includes: change8).
]
