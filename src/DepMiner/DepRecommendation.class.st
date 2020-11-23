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
DepRecommendation >> automatableReplacements [
	^ replacements select: [ :each | each isAutomatable ]
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

{ #category : #accessing }
DepRecommendation >> replacements [
	^ replacements
]
