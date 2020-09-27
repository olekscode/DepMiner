Class {
	#name : #MrCommitTest,
	#superclass : #TestCase,
	#instVars : [
		'commit1',
		'commit2',
		'commit3',
		'commit4',
		'commit5',
		'commit6'
	],
	#category : #'MigrationRulesMiner-Tests-Models'
}

{ #category : #running }
MrCommitTest >> setUp [
	super setUp.
	
	commit1 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
	
	"Same as commit1"	
	commit2 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	"Different sha"
	commit3 := MrCommit new
		sha: '3206cc82d9991e2acdd10916247c114e1b173e77';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	"Different message"
	commit4 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Lorem ipsum';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	"Different tag"
	commit5 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '2.0.0';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	"Different datetime"
	commit6 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '11-21-2020' asDateAndTime;
		yourself.
]

{ #category : #tests }
MrCommitTest >> testEquality [
	self assert: commit2 equals: commit1.
	self deny: commit3 equals: commit1.
	self deny: commit4 equals: commit1.
	self deny: commit5 equals: commit1.
	self deny: commit6 equals: commit1.
]

{ #category : #tests }
MrCommitTest >> testHash [
	self assert: commit2 hash equals: commit1 hash.
	self deny: commit3 hash equals: commit1 hash.
	self deny: commit4 hash equals: commit1 hash.
	self deny: commit5 hash equals: commit1 hash.
	self deny: commit6 hash equals: commit1 hash.
]

{ #category : #tests }
MrCommitTest >> testSet [
	| set |
	set := { commit1 . commit2 . commit3 . commit4 . commit5 . commit6 } asSet.
	
	self assert: set size equals: 5.
	self assert: (set includes: commit1).
	self assert: (set includes: commit2).
	self assert: (set includes: commit3).
	self assert: (set includes: commit4).
	self assert: (set includes: commit5).
	self assert: (set includes: commit6).
]
