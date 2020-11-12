Class {
	#name : #DepCommitTest,
	#superclass : #TestCase,
	#instVars : [
		'commit1',
		'commit2',
		'commit3',
		'commit4',
		'commit5',
		'commit6',
		'commit7',
		'commit8'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #running }
DepCommitTest >> setUp [
	super setUp.
	
	commit1 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
	
	"Same as commit1"	
	commit2 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different sha"
	commit3 := DepCommit new
		sha: '3206cc82d9991e2acdd10916247c114e1b173e77';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different message"
	commit4 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Lorem ipsum';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different author"
	commit5 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Stephane Ducasse';
		tags: #('1.0.1');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different tags"
	commit6 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('release' '2.0.0');
		date: '10-12-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different date"
	commit7 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '11-21-2020' asDate;
		time: '15:30' asTime;
		yourself.
		
	"Different date"
	commit8 := DepCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		date: '11-21-2020' asDate;
		time: '23:03' asTime;
		yourself.
]

{ #category : #tests }
DepCommitTest >> testEquality [
	self assert: commit2 equals: commit1.
	self deny: commit3 equals: commit1.
	self deny: commit4 equals: commit1.
	self deny: commit5 equals: commit1.
	self deny: commit6 equals: commit1.
	self deny: commit7 equals: commit1.
	self deny: commit8 equals: commit1.
]

{ #category : #tests }
DepCommitTest >> testHash [
	self assert: commit2 hash equals: commit1 hash.
	self deny: commit3 hash equals: commit1 hash.
	self deny: commit4 hash equals: commit1 hash.
	self deny: commit5 hash equals: commit1 hash.
	self deny: commit6 hash equals: commit1 hash.
	self deny: commit7 hash equals: commit1 hash.
	self deny: commit8 hash equals: commit1 hash.
]

{ #category : #tests }
DepCommitTest >> testSet [
	| set |
	set := { commit1 . commit2 . commit3 . commit4 . commit5 . commit6 . commit7 . commit8 } asSet.
	
	self assert: set size equals: 7.
	self assert: (set includes: commit1).
	self assert: (set includes: commit2).
	self assert: (set includes: commit3).
	self assert: (set includes: commit4).
	self assert: (set includes: commit5).
	self assert: (set includes: commit6).
	self assert: (set includes: commit7).
	self assert: (set includes: commit8).
]
