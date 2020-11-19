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
		yourself.
]

{ #category : #tests }
DepMethodTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := method.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
	
	"We need to check ASTs separately because they are ignored by equality operator"
	self assert: recoveredObject ast equals: originalObject ast.
	self assert: recoveredObject oldAst equals: originalObject oldAst.
]
