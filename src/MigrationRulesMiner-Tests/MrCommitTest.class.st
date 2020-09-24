Class {
	#name : #MrCommitTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MrCommitTest >> testEquality [
	| commit1 commit2 commit3 |
	
	commit1 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	commit2 := MrCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		tag: '1.0.1';
		datetime: '10-12-2020' asDateAndTime;
		yourself.
		
	commit3 := MrCommit new
		sha: '3206cc82d9991e2acdd10916247c114e1b173e77';
		message: 'Lorem ipsum';
		tag: '2.0.0';
		datetime: '11-21-2020' asDateAndTime;
		yourself.
		
	self assert: commit2 equals: commit1.
	self deny: commit3 equals: commit1.
]
