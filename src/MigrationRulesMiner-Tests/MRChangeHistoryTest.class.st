Class {
	#name : #MRChangeHistoryTest,
	#superclass : #TestCase,
	#instVars : [
		'repository',
		'changeHistory',
		'branchName',
		'fromCommitId',
		'toCommitId'
	],
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #running }
MRChangeHistoryTest >> setUp [
	super setUp.
	
	repository := IceRepository registry 
		detect: [ :repo | repo name = 'MigrationRulesMiner' ].
		
	branchName := 'master'.
	fromCommitId := 'c0e03dcfe390a08b33f59efb6cf2c5913178ceea'.
	toCommitId := '4d882d2712e86d1271123d53bfcad858a324ce70'.
		
	changeHistory := MRChangeHistory new
		repository: repository;
		branchNamed: branchName;
		fromCommitId: fromCommitId;
		toCommitId: toCommitId;
		yourself.
]

{ #category : #tests }
MRChangeHistoryTest >> testBranch [
	"Should be able to get branch object by name"
	| branch |
	branch := changeHistory branch.
	
	self assert: branch class equals: IceGitLocalBranch.
	self assert: branch name equals: branchName.
]

{ #category : #tests }
MRChangeHistoryTest >> testCalculateDiffs [
	"Should calculate diffs between every two subsequent commits"
	| diffs |
	changeHistory loadCommits.
	changeHistory calculateDiffs.
	
	diffs := changeHistory diffs.
	
	self assert: diffs size equals: 10.
	
	diffs do: [ :each |
		self assert: each class equals: IceDiff ].
]

{ #category : #tests }
MRChangeHistoryTest >> testExtractMethodChanges [
	"Should method changes from commit diffs"
	| changes |
	changeHistory loadCommits.
	changeHistory calculateDiffs.
	changeHistory extractMethodChanges.
	
	changes := changeHistory methodChanges.
	
	self assert: changes size equals: 4.
	
	changes do: [ :each |
		self assert: each class equals: MRMethodChange ].
	
	self
		assert: (changes collect: [ :each | each methodName ])
		equals: (OrderedCollection withAll: {
			#visitMessageNode: .
			#testBranchNamed .
			#testBranchNamedNoRepository .
			#testRepositoryNamed }).
]

{ #category : #tests }
MRChangeHistoryTest >> testFromCommit [
	"Should be able to get the commit object by SHA"
	| commit |
	commit := changeHistory fromCommit.
	
	self assert: commit class equals: IceGitCommit.
	self assert: commit id equals: fromCommitId.
]

{ #category : #tests }
MRChangeHistoryTest >> testLoadCommits [
	"Should be able load all commits between the given two commits"
	| commits |
	changeHistory loadCommits.
	commits := changeHistory commits.
	
	self assert: commits size equals: 10.
	
	commits do: [ :each |
		self assert: each class equals: IceGitCommit ].
	
	self assert: commits first equals: changeHistory fromCommit.
	self assert: commits last equals: changeHistory toCommit.
]

{ #category : #tests }
MRChangeHistoryTest >> testToCommit [
	"Should be able to get the commit object by SHA"
	| commit |
	commit := changeHistory toCommit.
	
	self assert: commit class equals: IceGitCommit.
	self assert: commit id equals: toCommitId.
]
