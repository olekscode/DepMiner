Class {
	#name : #MRChangeHistory,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'fromCommit',
		'toCommit',
		'commits',
		'failedCommits',
		'diffs',
		'methodChanges'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRChangeHistory >> branch [
	^ branch
]

{ #category : #accessing }
MRChangeHistory >> branchNamed: aBranchName [
	repository ifNil: [ Error signal: 'You must specify the repository first' ].
	branch := repository branchNamed: aBranchName.
]

{ #category : #'as yet unclassified' }
MRChangeHistory >> calculateDiffs [
	failedCommits := OrderedCollection new.
	diffs := OrderedCollection new.

	commits
		do: [ :commit |
			[ diffs add: (commit diffTo: commit parent) ]
				on: Exception
				do: [ failedCommits add: commit ] ]
		displayingProgress: [ :commit | commit id ].
]

{ #category : #accessing }
MRChangeHistory >> commits [ 
	^ commits
]

{ #category : #accessing }
MRChangeHistory >> diffs [
	^ diffs
]

{ #category : #'as yet unclassified' }
MRChangeHistory >> extractMethodChanges [
	| packageNodes classNodes methodNodes methodOperations |
	
	packageNodes := diffs flatCollect: [ :diff |
		diff tree children first children ].
	
	classNodes := packageNodes flatCollect: [ :node |
		node children ].
	
	methodNodes := classNodes flatCollect: [ :node |
		node children ].
	
	methodOperations := methodNodes collect: [ :node | node value ].
	
	methodChanges := methodOperations
		select: [ :each |
			each isModification and: [ 
				each definition isMethodDefinition and: [ 
					each oldNode isMethodDefinition ] ] ]
		thenCollect: [ :each |
			each definition className = each oldNode className
				ifFalse: [ Error signal: 'Class was renamed' ].
				
			each definition name = each oldNode name
				ifFalse: [ Error signal: 'Method was renamed' ].
				
			MRMethodChange new
				className: each definition className;
				methodName: each definition name;
				oldMethodAst: (RBParser parseMethod: each oldNode sourceCode);
				newMethodAst: (RBParser parseMethod: each definition sourceCode);
				yourself ].
]

{ #category : #accessing }
MRChangeHistory >> failedCommits [
	^ failedCommits
]

{ #category : #'as yet unclassified' }
MRChangeHistory >> filterEmptyDiffs [
	diffs := diffs reject: [ :diff | diff tree isEmptyNode ].
]

{ #category : #accessing }
MRChangeHistory >> fromCommit [
	^ fromCommit
]

{ #category : #accessing }
MRChangeHistory >> fromCommitId: aCommitId [
	fromCommit := branch commits
		detect: [ :commit | commit id = aCommitId ]
		ifNone: [ Error signal: 'Commit with this ID was not found' ]
]

{ #category : #'as yet unclassified' }
MRChangeHistory >> loadCommits [
	| commitWalk |
	
	commitWalk := (IceLibgitCommitWalk forRepository: repository)
		fromCommit: fromCommit;
		uptoCommit: toCommit;
		yourself.
		
	commits := OrderedCollection new.
	commitWalk commitsDo: [ :commit | commits add: commit ].
	
]

{ #category : #accessing }
MRChangeHistory >> methodChanges [
	^ methodChanges
]

{ #category : #accessing }
MRChangeHistory >> repository [
	^ repository
]

{ #category : #accessing }
MRChangeHistory >> repository: aRepository [
	repository := aRepository
]

{ #category : #accessing }
MRChangeHistory >> repositoryNamed: aRepositoryName [
	repository := IceRepository registry
		detect: [ :repo | repo name = aRepositoryName ]
		ifNone: [ Error signal: 'Repository named ''', aRepositoryName, '''was not found.' ].
]

{ #category : #accessing }
MRChangeHistory >> toCommit [
	^ toCommit
]

{ #category : #accessing }
MRChangeHistory >> toCommitId: aCommitId [
	toCommit := branch commits
		detect: [ :commit | commit id = aCommitId ]
		ifNone: [ Error signal: 'Commit with this ID was not found' ]
]
