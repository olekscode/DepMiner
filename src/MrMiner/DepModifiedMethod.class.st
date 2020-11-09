Class {
	#name : #DepModifiedMethod,
	#superclass : #DepMethod,
	#instVars : [
		'wasDeprecatedInOldVersion',
		'oldSourceCode',
		'oldAst'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
DepModifiedMethod >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	super = anObject ifFalse: [ ^ false ].
	
	^ oldSourceCode = anObject oldSourceCode and: [ 
		oldAst = anObject oldAst and: [ 
			wasDeprecatedInOldVersion = anObject wasDeprecatedInOldVersion ] ]
]

{ #category : #comparing }
DepModifiedMethod >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: (oldSourceCode hash bitXor:
			   (oldAst hash bitXor: (wasDeprecatedInOldVersion hash)))
]

{ #category : #initialization }
DepModifiedMethod >> initialize [
	super initialize.
	wasDeprecatedInOldVersion := false.
]

{ #category : #testing }
DepModifiedMethod >> isModified [
	^ true
]

{ #category : #'as yet unclassified' }
DepModifiedMethod >> markAsDeprecatedInOldVersion [
	wasDeprecatedInOldVersion := true
]

{ #category : #accessing }
DepModifiedMethod >> oldAst [
	^ oldAst
]

{ #category : #accessing }
DepModifiedMethod >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
DepModifiedMethod >> wasDeprecatedInOldVersion [
	^ wasDeprecatedInOldVersion
]
