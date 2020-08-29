Class {
	#name : #MRMigrationRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'commitLoader',
		'aprioriMiner'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRMigrationRulesBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #commitLoader;
		add: #aprioriMiner;
		yourself.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> aprioriMiner [
	^ aprioriMiner
]

{ #category : #accessing }
MRMigrationRulesBrowser >> aprioriMiner: anObject [
	aprioriMiner := anObject
]

{ #category : #accessing }
MRMigrationRulesBrowser >> commitLoader [
	^ commitLoader
]

{ #category : #accessing }
MRMigrationRulesBrowser >> commitLoader: anObject [
	commitLoader := anObject
]

{ #category : #initialization }
MRMigrationRulesBrowser >> initializeWidgets [
	commitLoader := MRCommitLoaderPresenter new.
	aprioriMiner := MRAprioriMinerPresenter new.
]
