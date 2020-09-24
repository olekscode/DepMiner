Class {
	#name : #MRSortCommand,
	#superclass : #MRCommand,
	#category : #'MigrationRulesMiner-Spec-Commands'
}

{ #category : #default }
MRSortCommand class >> defaultDescription [
	^ 'Sort rules'
]

{ #category : #default }
MRSortCommand class >> defaultIconName [ 
	^ #changeSorter
]

{ #category : #default }
MRSortCommand class >> defaultName [ 
	^ 'Sort'
]

{ #category : #executing }
MRSortCommand >> execute [
	Transcript open
]
