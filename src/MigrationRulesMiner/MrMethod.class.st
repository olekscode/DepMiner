Class {
	#name : #MrMethod,
	#superclass : #Object,
	#instVars : [
		'className',
		'selector'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #comparing }
MrMethod >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject className = className and: [ 
		anObject selector = selector ]
]

{ #category : #accessing }
MrMethod >> className [
	^ className
]

{ #category : #accessing }
MrMethod >> className: anObject [
	className := anObject
]

{ #category : #comparing }
MrMethod >> hash [
	^ className hash bitXor: selector hash
]

{ #category : #printing }
MrMethod >> printOn: aStream [
	aStream
		nextPutAll: className;
		nextPutAll: '>>';
		nextPutAll: selector.
]

{ #category : #accessing }
MrMethod >> selector [
	^ selector
]

{ #category : #accessing }
MrMethod >> selector: anObject [
	selector := anObject
]
