Extension { #name : #IceGitCommit }

{ #category : #'*MigrationRulesMiner' }
IceGitCommit >> asMrCommit [
	^ MrCommit new 
		sha: self id;
		message: self comment;
		datetime: self datetime;
		yourself
]
