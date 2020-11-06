Class {
	#name : #DepProjectHistory,
	#superclass : #Object,
	#instVars : [
		'commits',
		'methods'
	],
	#category : #'MrMiner-Models'
}

{ #category : #enumerating }
DepProjectHistory >> commitThatMatches: aShaShortShaOrTag ifNone: anAbsentBlock [
	"Return a commit that has a SHA, short SHA, or a tag that matches the given string. If none, evaluate the given block"
	
	^ commits at: aShaShortShaOrTag
		ifAbsent: [ commits values
			detect: [ :commit | commit matches: aShaShortShaOrTag ]
			ifNone: [ anAbsentBlock value ] ]
]

{ #category : #accessing }
DepProjectHistory >> commits [
	^ commits
]

{ #category : #accessing }
DepProjectHistory >> commits: aCommitDictionary [
	commits := aCommitDictionary
]

{ #category : #initialization }
DepProjectHistory >> initialize [
	super initialize.
	commits := Dictionary new.
	methods := Dictionary new.
]

{ #category : #accessing }
DepProjectHistory >> methods [
	^ methods
]
