Class {
	#name : #MrMinerController,
	#superclass : #Object,
	#instVars : [
		'model',
		'refrain',
		'clio'
	],
	#category : #'MrMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMinerController >> addedMethodsTree [
	^ self clioMethodsToVersionTrees: model addedMethods
]

{ #category : #'as yet unclassified' }
MrMinerController >> candidateCommitsForNewVersion [
	| commits |
	commits := self candidateCommitsForOldVersion.
	
	model oldVersionCommit ifNotNil: [ 
		commits := commits select: [ :commit |
			commit date > model oldVersionCommit date or: [ 
				commit date = model oldVersionCommit date and: [ 
					commit time > model oldVersionCommit time ] ] ] ].
	
	^ commits
]

{ #category : #'as yet unclassified' }
MrMinerController >> candidateCommitsForOldVersion [
	^ model repository branch commits collect: [ :each | each asRefrainCommit ]
]

{ #category : #'as yet unclassified' }
MrMinerController >> clioMethodsToVersionTrees: aCollectionOfClioMethods [
	| packages classTree methodTree |
	
	packages := aCollectionOfClioMethods collect: [ :method |
		MrMethodTreeModel new
			name: method packageName;
			iconName: #package;
			yourself ].
		
	packages := packages asSet asArray.
		
	aCollectionOfClioMethods do: [ :method |
		classTree := MrMethodTreeModel new
			name: method className;
			iconName: #class;
			yourself.
			
		packages
			detect: [ :package | package name = method packageName ]
			ifFound: [ :package | package addChild: classTree ] ].
		
	aCollectionOfClioMethods do: [ :method |
		methodTree := MrMethodTreeLeafModel new
			name: method selector;
			value: method;
			iconName: #method;
			yourself.
			
		packages
			detect: [ :package | package name = method packageName ]
			ifFound: [ :package | package children
				detect: [ :aClass | aClass name = method className ]
				ifFound: [ :aClass | aClass addChild: methodTree ] ] ].
		
	^ packages
]

{ #category : #'as yet unclassified' }
MrMinerController >> deletedMethodsTree [
	^ self clioMethodsToVersionTrees: model deletedMethods
]

{ #category : #'as yet unclassified' }
MrMinerController >> getGitHubRepository: aRepositoryName by: anOwnerName [
	[ ^ IceGitHubAPI new
		beAnonymous;
		getRepository: anOwnerName project: aRepositoryName ]
		on: LGitNoCredentialsProvided
		do: [ ^ nil ]
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadAddedMethods [
	model addedMethods: clio addedMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadChanges [
	refrain := Refrain
		repositoryName: model repository name
		branchName: model repository branch name
		firstCommit: model oldVersionCommit sha
		lastCommit: model newVersionCommit sha.
		
	clio := Clio
		for: model repository name
		between: model oldVersionCommit sha
		and: model newVersionCommit sha.
		
	self loadOldVersion.
	self loadNewVersion.
	self loadDeletedMethods.
	self loadAddedMethods.
	
	refrain loadMethodChanges.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadDeletedMethods [
	model deletedMethods: clio deletedMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadNewVersion [
	model newMethods: clio newMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadOldVersion [
	model oldMethods: clio oldMethods asArray.
]

{ #category : #'as yet unclassified' }
MrMinerController >> loadProject: aProjectName by: anOwnerName [
	| repository |
	
	repository := IceRepository registry
		detect: [ :repo |
			repo isValid and: [
				repo location path parent basename = anOwnerName and: [
					repo name = aProjectName ] ] ]
		ifFound: [ :repo | repo ]
		ifNone: [ self getGitHubRepository: aProjectName by: anOwnerName ].
		
	model repository: repository.
]

{ #category : #accessing }
MrMinerController >> minNumberOfRepetitions: aNumber [
	refrain minNumberOfRepetitions: aNumber
]

{ #category : #'as yet unclassified' }
MrMinerController >> mineRules [
	| methodCallCollector |
	
	methodCallCollector := MrMinerSelectorCollector new
		oldSelectors: (clio oldMethods collect: [ :method | method selector ]);
		newSelectors: (clio newMethods collect: [ :method | method selector ]);
		yourself.
		
	refrain entityCollector: methodCallCollector.
	^ refrain mineRepetitiveChanges.
]

{ #category : #accessing }
MrMinerController >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
MrMinerController >> newVersionTree [
	^ self clioMethodsToVersionTrees: model newMethods
]

{ #category : #'as yet unclassified' }
MrMinerController >> oldVersionTree [
	^ self clioMethodsToVersionTrees: model oldMethods
]
