Class {
	#name : #DepMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'method'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #running }
DepMethodTest >> setUp [
	super setUp.
	
	method := DepMethod new
		packageName: 'Core';
		className: 'Collection';
		selector: 'withIndexDo:';
		sourceCode: 'withIndexDo: aBlock
			self
				deprecated: ''Use #doWithIndex: instead''
				transformWith: ''`@rec withIndexDo: `@arg'' -> ''`@rec doWithIndex: `@arg''.
			^ self doWithIndex: aBlock';
		extractDeprecationsFromAst;
		yourself.
]

{ #category : #tests }
DepMethodTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := method.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
]
