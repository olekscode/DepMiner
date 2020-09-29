Extension { #name : #IceGitCommit }

{ #category : #'*MigrationRulesMiner' }
IceGitCommit >> asMrCommit [
	^ MrCommit new 
		sha: self id;
		message: self comment;
		author: self author;
		tags: (self tags collect: [ :each | each name ]);
		datetime: self datetime;
		yourself
]
