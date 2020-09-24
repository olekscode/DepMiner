Class {
	#name : #MrMethodCall,
	#superclass : #Object,
	#instVars : [
		'selector'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #comparing }
MrMethodCall >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject selector = selector
]

{ #category : #comparing }
MrMethodCall >> hash [ 
	^ selector hash
]

{ #category : #printing }
MrMethodCall >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: selector;
		nextPut: $).
]

{ #category : #accessing }
MrMethodCall >> selector [
	^ selector
]

{ #category : #accessing }
MrMethodCall >> selector: anObject [
	selector := anObject
]
