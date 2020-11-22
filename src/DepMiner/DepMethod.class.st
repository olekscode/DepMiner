Class {
	#name : #DepMethod,
	#superclass : #ClioMethod,
	#instVars : [
		'wasInOldVersion',
		'isInNewVersion',
		'wasModified',
		'oldSourceCode',
		'oldDeprecation'
	],
	#category : #'DepMiner-Models'
}

{ #category : #accessing }
DepMethod >> deprecation: anObject [
	deprecation := anObject
]

{ #category : #initialization }
DepMethod >> initialize [
	super initialize.
	wasInOldVersion := false.
	isInNewVersion := false.
	wasModified := false.
]

{ #category : #accessing }
DepMethod >> isInNewVersion [
	^ isInNewVersion
]

{ #category : #accessing }
DepMethod >> markAsModified [
	wasModified := true
]

{ #category : #accessing }
DepMethod >> markAsNewMethod [
	isInNewVersion := true
]

{ #category : #accessing }
DepMethod >> markAsOldMethod [
	wasInOldVersion := true
]

{ #category : #accessing }
DepMethod >> name [
	"Answer a string that will be displayed in the UI"
	^ selector
]

{ #category : #accessing }
DepMethod >> oldDeprecation [
	^ oldDeprecation
]

{ #category : #accessing }
DepMethod >> oldDeprecation: anObject [
	oldDeprecation := anObject
]

{ #category : #accessing }
DepMethod >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
DepMethod >> oldSourceCode: anObject [
	oldSourceCode := anObject
]

{ #category : #'as yet unclassified' }
DepMethod >> oldTransformationRule [
	^ oldDeprecation transformationRule
]

{ #category : #accessing }
DepMethod >> wasAdded [
	^ wasInOldVersion not and: isInNewVersion
]

{ #category : #accessing }
DepMethod >> wasDeleted [
	^ wasInOldVersion and: isInNewVersion not
]

{ #category : #accessing }
DepMethod >> wasDeprecatedInOldVersion [
	^ self wasModified
		ifTrue: [ oldDeprecation isNotNil ]
		ifFalse: [ deprecation isNotNil ]
]

{ #category : #accessing }
DepMethod >> wasInOldVersion [
	^ wasInOldVersion
]

{ #category : #testing }
DepMethod >> wasModified [
	^ wasModified
]

{ #category : #'as yet unclassified' }
DepMethod >> wasUnchanged [
	"Answer true if method did not change between the old and the new version of a project"
	^ self wasAdded not and: [ self wasDeleted not and: [ self wasModified not ] ]
]
