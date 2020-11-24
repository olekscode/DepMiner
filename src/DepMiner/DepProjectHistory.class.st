Class {
	#name : #DepProjectHistory,
	#superclass : #Object,
	#instVars : [
		'commitDictionary',
		'methods',
		'newVersionClassSelectorsDictionary',
		'totalNumberOfMethodChanges',
		'relevantMethodChanges'
	],
	#category : #'DepMiner-Models'
}

{ #category : #accessing }
DepProjectHistory >> commitDictionary [
	^ commitDictionary
]

{ #category : #enumerating }
DepProjectHistory >> commitThatMatches: aShaShortShaOrTag ifNone: anAbsentBlock [
	"Return a commit that has a SHA, short SHA, or a tag that matches the given string. If none, evaluate the given block"
	
	^ commitDictionary at: aShaShortShaOrTag
		ifAbsent: [ commitDictionary values
			detect: [ :commit | commit matches: aShaShortShaOrTag ]
			ifNone: [ anAbsentBlock value ] ]
]

{ #category : #'as yet unclassified' }
DepProjectHistory >> extractNewVersionClassSelectors [
	newVersionClassSelectorsDictionary removeAll.
	
	methods do: [ :method |
		(newVersionClassSelectorsDictionary
			at: method className
			ifAbsentPut: [ OrderedCollection new ])
			add: method selector ]
]

{ #category : #initialization }
DepProjectHistory >> initialize [
	super initialize.
	commitDictionary := Dictionary new.
	newVersionClassSelectorsDictionary := Dictionary new.
]

{ #category : #accessing }
DepProjectHistory >> methods [
	^ methods
]

{ #category : #accessing }
DepProjectHistory >> methods: anObject [
	methods := anObject
]

{ #category : #'as yet unclassified' }
DepProjectHistory >> newMethods [
	^ self methods select: [ :method | method isInNewVersion ]
]

{ #category : #'as yet unclassified' }
DepProjectHistory >> newSelectors [
	^ (self newMethods collect: [ :method | method selector ]) asSet
]

{ #category : #accessing }
DepProjectHistory >> newVersionClassSelectorsDictionary [
	^ newVersionClassSelectorsDictionary
]

{ #category : #'as yet unclassified' }
DepProjectHistory >> oldMethods [
	^ self methods select: [ :method | method wasInOldVersion ]
]

{ #category : #'as yet unclassified' }
DepProjectHistory >> oldSelectors [
	^ (self oldMethods collect: [ :method | method selector ]) asSet
]

{ #category : #accessing }
DepProjectHistory >> relevantMethodChanges [
	^ relevantMethodChanges
]

{ #category : #accessing }
DepProjectHistory >> relevantMethodChanges: anObject [
	relevantMethodChanges := anObject
]

{ #category : #sorting }
DepProjectHistory >> sortMethodsAndClearMethodDictionary [
	"Method dictionary is only used for collecting methods. After all methods have been collected, they can be sorted and stored in an array"
]

{ #category : #accessing }
DepProjectHistory >> sortedCommits [
	^ commitDictionary values sorted: [ :a :b |
		a date > b date or: [
			a date = b date and: [ a time > b time ] ] ]
]

{ #category : #accessing }
DepProjectHistory >> totalNumberOfMethodChanges [
	^ totalNumberOfMethodChanges
]

{ #category : #accessing }
DepProjectHistory >> totalNumberOfMethodChanges: anObject [
	totalNumberOfMethodChanges := anObject
]
