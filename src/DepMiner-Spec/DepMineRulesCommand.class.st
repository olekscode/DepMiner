Class {
	#name : #DepMineRulesCommand,
	#superclass : #DepCommand,
	#category : #'DepMiner-Spec-Commands'
}

{ #category : #default }
DepMineRulesCommand class >> defaultDescription [
	^ 'Mine migration rules from the commit history'
]

{ #category : #accessing }
DepMineRulesCommand class >> defaultIconName [
	^ #databaseAdd
]

{ #category : #default }
DepMineRulesCommand class >> defaultName [
	^ 'Mine'
]

{ #category : #'as yet unclassified' }
DepMineRulesCommand >> execute [
	MrCommitLoaderPresenter new
		whenResultsAreReadyDo: [ :experiment |
			context addPageWithExperiment: experiment title: '(not saved)'.
			context onChanged ];
		openWithSpec.
]
