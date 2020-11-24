Class {
	#name : #DepRecommendation,
	#superclass : #Object,
	#instVars : [
		'method',
		'replacements'
	],
	#category : #'DepMiner-Models'
}

{ #category : #comparing }
DepRecommendation >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ replacements = anObject replacements 
]

{ #category : #'as yet unclassified' }
DepRecommendation >> applyWith: aReplacement [
	| generatedCode methodClass protocol |
	
	self canBeApplied
		ifFalse: [ self raiseCanNotBeAppliedException ].
	
	generatedCode := self generateSourceCodeUsing: aReplacement.
	methodClass := Smalltalk classNamed: method className.
	
	protocol := [ (methodClass methodNamed: method selector asSymbol) protocol ]
		on: KeyNotFound
		do: [ 'generated' ].
	
	Author 
		useAuthor: 'DepMiner'
		during: [ methodClass compile: generatedCode classified: protocol ].
		
	self inform: ('Method ', method signature, ' was saved').
]

{ #category : #'as yet unclassified' }
DepRecommendation >> automatableReplacements [
	^ replacements select: [ :each | each isAutomatable ]
]

{ #category : #testing }
DepRecommendation >> canBeApplied [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
DepRecommendation >> chooseApplicableRulesFrom: aCollectionOfRelevantRules [

	replacements := aCollectionOfRelevantRules
		select: [ :rule | rule deletedMethodCalls anyOne selector = method selector ]
		thenCollect: [ :rule | DepReplacement for: method definedBy: rule ]
]

{ #category : #'as yet unclassified' }
DepRecommendation >> generateSourceCodeUsing: aReplacement [
	self subclassResponsibility
]

{ #category : #testing }
DepRecommendation >> hasAutomatableReplacements [
	^ replacements anySatisfy: [ :each | each isAutomatable ]
]

{ #category : #testing }
DepRecommendation >> hasNonAutomatableReplacements [
	^ replacements anySatisfy: [ :each | each isAutomatable not ]
]

{ #category : #comparing }
DepRecommendation >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ method hash bitXor: replacements hash
]

{ #category : #testing }
DepRecommendation >> isClassLoadedIntoTheImage: aClassName [
	"Answer true if a class with a given name can be found in the image"
	
	^ (Smalltalk classNamed: aClassName) isNotNil
]

{ #category : #testing }
DepRecommendation >> isMethodLoadedIntoTheImage: aMethod [
	"Answer true if the given method can be found in the image"
	
	| methodClass |
	
	methodClass := Smalltalk classNamed: aMethod className.
	methodClass ifNil: [ ^ false ].
	
	[ methodClass methodNamed: aMethod selector asSymbol ]
		on: KeyNotFound
		do: [ ^ false ].
		
	^ true
]

{ #category : #accessing }
DepRecommendation >> method [
	^ method
]

{ #category : #accessing }
DepRecommendation >> method: anObject [
	method := anObject
]

{ #category : #accessing }
DepRecommendation >> name [
	"Answer a string that will be displayed in the UI"
	^ method selector
]

{ #category : #'as yet unclassified' }
DepRecommendation >> nonAutomatableReplacements [
	^ replacements reject: [ :each | each isAutomatable ]
]

{ #category : #'as yet unclassified' }
DepRecommendation >> raiseCanNotBeAppliedException [
	self subclassResponsibility
]

{ #category : #accessing }
DepRecommendation >> replacements [
	^ replacements
]
