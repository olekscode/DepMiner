Class {
	#name : #MrMineRulesCommand,
	#superclass : #MrCommand,
	#category : #'MrMiner-Spec-Commands'
}

{ #category : #default }
MrMineRulesCommand class >> defaultDescription [
	^ 'Mine migration rules from the commit history'
]

{ #category : #accessing }
MrMineRulesCommand class >> defaultIconName [
	"^ #databaseAdd"
	^ #glamourousInspect
]

{ #category : #default }
MrMineRulesCommand class >> defaultName [
	^ 'Mine'
]

{ #category : #'as yet unclassified' }
MrMineRulesCommand >> execute [
	MrCommitLoaderPresenter new
		whenResultsAreReadyDo: [ :experiment |
			context addPageWithExperiment: experiment title: '(not saved)'.
			context onChanged ];
		openWithSpec.
]
