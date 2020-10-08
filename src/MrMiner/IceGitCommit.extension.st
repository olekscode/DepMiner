Extension { #name : #IceGitCommit }

{ #category : #'*MrMiner' }
IceGitCommit >> asMrCommit [
	^ MrCommit new 
		sha: self id;
		message: self comment;
		author: self author;
		datetime: self datetime;
		yourself
]
