Extension { #name : #IceGitCommit }

{ #category : #'*MrMiner' }
IceGitCommit >> asDepCommit [
	^ DepCommit new 
		sha: self id;
		message: self comment;
		author: self author;
		date: self datetime asDate;
		time: self datetime asTime;
		yourself
]
