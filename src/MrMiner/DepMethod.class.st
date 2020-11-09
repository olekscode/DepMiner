Class {
	#name : #DepMethod,
	#superclass : #Object,
	#instVars : [
		'className',
		'selector',
		'sourceCode',
		'ast',
		'isDeprecated',
		'wasAdded',
		'wasDeleted'
	],
	#category : #'MrMiner-Models'
}

{ #category : #comparing }
DepMethod >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ ast = anObject ast and: [ 
		  className = anObject className and: [ 
			  isDeprecated = anObject isDeprecated and: [ 
				  selector = anObject selector and: [ 
					  sourceCode = anObject sourceCode and: [ 
						  wasAdded = anObject wasAdded and: [ 
							  wasDeleted = anObject wasDeleted ] ] ] ] ] ]
]

{ #category : #converting }
DepMethod >> asModifiedMethod [
	| newMethod |
	
	newMethod := DepModifiedMethod new
		className: className;
		selector: selector;
		sourceCode: sourceCode;
		ast: ast;
		yourself.
		
	self wasAdded ifTrue: [ newMethod markAsAdded ].
	self wasDeleted ifTrue: [ newMethod markAsDeleted ].
	self isDeprecated ifTrue: [ newMethod markAsDeprecated ].
	
	^ newMethod
]

{ #category : #accessing }
DepMethod >> ast [
	^ ast
]

{ #category : #accessing }
DepMethod >> ast: anObject [
	ast := anObject
]

{ #category : #accessing }
DepMethod >> className [
	^ className
]

{ #category : #accessing }
DepMethod >> className: anObject [
	className := anObject
]

{ #category : #comparing }
DepMethod >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ ast hash bitXor: (className hash bitXor:
			   (isDeprecated hash bitXor: (selector hash bitXor:
					     (sourceCode hash bitXor:
						      (wasAdded hash bitXor: wasDeleted hash)))))
]

{ #category : #initialization }
DepMethod >> initialize [
	super initialize.
	wasAdded := false.
	wasDeleted := false.
	isDeprecated := false.
]

{ #category : #accessing }
DepMethod >> isDeprecated [
	^ isDeprecated
]

{ #category : #accessing }
DepMethod >> markAsAdded [
	wasDeleted := false.
	wasAdded := true.
]

{ #category : #accessing }
DepMethod >> markAsDeleted [
	wasDeleted := true.
	wasAdded := false.
]

{ #category : #accessing }
DepMethod >> markAsDeprecated [
	isDeprecated := true
]

{ #category : #accessing }
DepMethod >> selector [
	^ selector
]

{ #category : #accessing }
DepMethod >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
DepMethod >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
DepMethod >> sourceCode: anObject [
	sourceCode := anObject
]

{ #category : #accessing }
DepMethod >> wasAdded [
	^ wasAdded
]

{ #category : #accessing }
DepMethod >> wasDeleted [
	^ wasDeleted
]

{ #category : #testing }
DepMethod >> wasModified [
	^ false
]

{ #category : #'as yet unclassified' }
DepMethod >> wasUnchanged [
	"Answer true if method did not change between the old and the new version of a project"
	^ self wasAdded not and: [ self wasDeleted not and: [ self wasModified not ] ]
]
