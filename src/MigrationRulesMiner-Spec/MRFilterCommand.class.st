Class {
	#name : #MRFilterCommand,
	#superclass : #MRCommand,
	#category : #'MigrationRulesMiner-Spec-Commands'
}

{ #category : #default }
MRFilterCommand class >> defaultDescription [
	^ 'Filter rules'
]

{ #category : #default }
MRFilterCommand class >> defaultIconName [
	^ #glamorousTable
]

{ #category : #default }
MRFilterCommand class >> defaultName [
	^ 'Filter'
]

{ #category : #executing }
MRFilterCommand >> execute [
	Transcript open
]
