Extension { #name : #IceGitCommit }

{ #category : #'*DepMiner' }
IceGitCommit >> asDepCommit [
	^ DepCommit new 
		sha: self id;
		message: self comment;
		author: self author;
		date: self datetime asDate;
		time: self datetime asTime;
		yourself
]
