Class {
	#name : #MigrationRulesMinerTest,
	#superclass : #TestCase,
	#category : #'MigrationRulesMiner-Tests'
}

{ #category : #tests }
MigrationRulesMinerTest >> testBranchNamed [
	| repositoryName branchName miner |
	repositoryName := #MRAprioriMiner.
	branchName := 'master'.
	
	miner := MRAprioriMiner new
		repositoryNamed: repositoryName;
		branchNamed: branchName;
		yourself.
	
	self assert: (miner branch isKindOf: IceGitLocalBranch).
	self assert: miner branch name equals: branchName.
]

{ #category : #tests }
MigrationRulesMinerTest >> testBranchNamedNoRepository [	
	self
		should: [
			MRAprioriMiner new
				branchNamed: 'master';
				yourself ]
		raise: Error.
]

{ #category : #tests }
MigrationRulesMinerTest >> testRepositoryNamed [
	| repositoryName miner |
	repositoryName := #MRAprioriMiner.
	
	miner := MRAprioriMiner new
		repositoryNamed: repositoryName;
		yourself.
	
	self assert: (miner repository isKindOf: IceLibgitRepository).
	self assert: miner repository name equals: repositoryName.
]
