Class {
	#name : #DepReplacementTest,
	#superclass : #TestCase,
	#instVars : [
		'mockMethod',
		'mockMethodWithOneArgument',
		'mockMethodWithTwoArguments',
		'mockDeprecatedMethod',
		'mockDeprecatedMethodWithOneArgument',
		'mockDeprecatedMethodWithTwoArguments'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #'as yet unclassified' }
DepReplacementTest >> depMethodFrom: aCompiledMethod [
	^ DepMethod new
		className: aCompiledMethod methodClass name;
		selector: aCompiledMethod selector;
		sourceCode: aCompiledMethod sourceCode;
		yourself
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockDeprecatedMethod [
	"I am a method comment"
	| a b |
	
	self deprecated: 'Do not use this method!'.
	
	a := 1.
	
	"Another comment"
	b := (1 to: 10) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockDeprecatedMethodWithArgument: anArgument [
	"I am a method comment"
	| a b |
	
	self deprecated: 'Do not use this method!'.
	
	a := anArgument.
	
	"Another comment"
	b := (1 to: 10) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockDeprecatedMethodWithArgument: anArgument and: anotherArgument [
	"I am a method comment"
	| a b |
	
	self deprecated: 'Do not use this method!'.
	
	a := anArgument.
	
	"Another comment"
	b := (1 to: anotherArgument) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockMethod [
	"I am a method comment"
	| a b |
	a := 1.
	
	"Another comment"
	b := (1 to: 10) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockMethodWithArgument: anArgument [
	"I am a method comment"
	| a b |
	a := anArgument.
	
	"Another comment"
	b := (1 to: 10) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #'as yet unclassified' }
DepReplacementTest >> mockMethodWithArgument: anArgument and: anotherArgument [
	"I am a method comment"
	| a b |
	a := anArgument.
	
	"Another comment"
	b := (1 to: anotherArgument) collect: [ :each |
		each factorial ].
	
	^ self
]

{ #category : #running }
DepReplacementTest >> setUp [
	super setUp.
	
	mockMethod := self depMethodFrom: (self class >> #mockMethod).
	mockMethodWithOneArgument := self depMethodFrom: (self class >> #mockMethodWithArgument:).
	mockMethodWithTwoArguments := self depMethodFrom: (self class >> #mockMethodWithArgument:and:).
	
	mockDeprecatedMethod := self depMethodFrom: (self class >> #mockDeprecatedMethod).
	mockDeprecatedMethodWithOneArgument := self depMethodFrom: (self class >> #mockDeprecatedMethodWithArgument:).
	mockDeprecatedMethodWithTwoArguments := self depMethodFrom: (self class >> #mockDeprecatedMethodWithArgument:and:).
		
]

{ #category : #tests }
DepReplacementTest >> testGenerateSourceCodeAfterDeprecationAutomatableNoArguments [
	| rule replacement generatedCode expectedCode |
	
	rule := DepAssociationRule
		withDeletedSelectors: #(mockMethod)
		addedSelectors: #(replacement).
		
	replacement := DepReplacement for: mockMethod definedBy: rule.
	
	generatedCode := replacement generateSourceCodeAfterDeprecation.
	expectedCode := '^ self replacement'.
	
	self assert: generatedCode equals: expectedCode

	
	
]

{ #category : #tests }
DepReplacementTest >> testGenerateSourceCodeAfterDeprecationAutomatableOneArgument [
	| rule replacement generatedCode expectedCode |
	
	rule := DepAssociationRule
		withDeletedSelectors: #(mockMethodWithArgument:)
		addedSelectors: #(replacementWithArgument:).
	
	replacement := DepReplacement for: mockMethodWithOneArgument definedBy: rule.
	
	generatedCode := replacement generateSourceCodeAfterDeprecation.
	expectedCode := '^ self replacementWithArgument: anArgument'.
	
	self assert: generatedCode equals: expectedCode

	
	
]

{ #category : #tests }
DepReplacementTest >> testGenerateSourceCodeAfterDeprecationAutomatableTwoArguments [
	| rule replacement generatedCode expectedCode |
	
	rule := DepAssociationRule
		withDeletedSelectors: #(mockMethodWithArgument:and:)
		addedSelectors: #(replacementWithArgument:and:).
		
	replacement := DepReplacement for: mockMethodWithTwoArguments definedBy: rule.
	
	generatedCode := replacement generateSourceCodeAfterDeprecation.
	expectedCode := '^ self replacementWithArgument: anArgument and: anotherArgument'.
	
	self assert: generatedCode equals: expectedCode

	
	
]

{ #category : #tests }
DepReplacementTest >> testGenerateSourceCodeAfterDeprecationNonAutomatable [
	| rule replacement generatedCode expectedCode |
	
	rule := DepAssociationRule
		withDeletedSelectors: #(mockMethod)
		addedSelectors: #(replacementWithArgument:).
	
	replacement := DepReplacement for: mockMethod definedBy: rule.
	
	generatedCode := replacement generateSourceCodeAfterDeprecation.
	expectedCode := 'a := 1.
	
	"Another comment"
	b := (1 to: 10) collect: [ :each |
		each factorial ].
	
	^ self'.
	
	"Replace all whitespaces with a single space"
	generatedCode := ' ' join: generatedCode substrings.
	expectedCode := ' ' join: expectedCode substrings.
	
	self assert: generatedCode equals: expectedCode

	
	
]
