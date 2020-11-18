Class {
	#name : #DepAssociationRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #running }
DepAssociationRuleTest >> setUp [
	| transformationRule methodChanges |
	super setUp.
	
	transformationRule := TransformationRule
		antecedent: '`@rec isEmpty not'
		consequent: '`@rec isNotEmpty'.
		
	methodChanges := { 
		RefrainMethodChange new
			commitSha: '84ed7471d4a6c0f5c070a6bfe8ab3371f0188035';
			method: (RefrainMethod new
				className: #APriori;
				selector: #calculateItemsetMetrics:;
				yourself);
			yourself .
			
		RefrainMethodChange new
			commitSha: '57acf893b567393fec7967f0c32306fccda9321d';
			method: (RefrainMethod new
				className: #APriori;
				selector: #calculateAssociationRuleMetrics:;
				yourself);
			yourself
	}.
	
	rule := DepAssociationRule new
		deletedMethodCalls: #(isEmpty not);
		addedMethodCalls: #(isNotEmpty);
		count: 2;
		confidence: 0.2;
		lift: 0.1;
		transformationRule: transformationRule;
		methodChanges: methodChanges;
		yourself.
]

{ #category : #tests }
DepAssociationRuleTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := rule.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
]
