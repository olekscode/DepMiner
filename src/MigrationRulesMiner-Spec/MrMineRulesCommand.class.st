Class {
	#name : #MrMineRulesCommand,
	#superclass : #MrCommand,
	#category : #'MigrationRulesMiner-Spec-Commands'
}

{ #category : #default }
MrMineRulesCommand class >> defaultDescription [
	^ 'Mine migration rules from the commit history'
]

{ #category : #accessing }
MrMineRulesCommand class >> defaultIconName [
	^ #add
]

{ #category : #default }
MrMineRulesCommand class >> defaultName [
	^ 'Mine'
]

{ #category : #'as yet unclassified' }
MrMineRulesCommand >> execute [
	MrCommitLoaderPresenter new
		whenReseltsAreReadyDo: [ :experiment |
			context addPageWithExperiment: experiment title: '(not saved)' ];
		openWithSpec.
]
