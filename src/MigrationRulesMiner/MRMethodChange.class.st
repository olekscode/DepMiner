Class {
	#name : #MRMethodChange,
	#superclass : #Object,
	#instVars : [
		'className',
		'methodName',
		'oldMethodAst',
		'newMethodAst'
	],
	#category : #MigrationRulesMiner
}

{ #category : #accessing }
MRMethodChange >> className [
	^ className
]

{ #category : #accessing }
MRMethodChange >> className: anObject [
	className := anObject
]

{ #category : #accessing }
MRMethodChange >> methodName [
	^ methodName
]

{ #category : #accessing }
MRMethodChange >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
MRMethodChange >> newMethodAst [
	^ newMethodAst
]

{ #category : #accessing }
MRMethodChange >> newMethodAst: anObject [
	newMethodAst := anObject
]

{ #category : #accessing }
MRMethodChange >> oldMethodAst [
	^ oldMethodAst
]

{ #category : #accessing }
MRMethodChange >> oldMethodAst: anObject [
	oldMethodAst := anObject
]
