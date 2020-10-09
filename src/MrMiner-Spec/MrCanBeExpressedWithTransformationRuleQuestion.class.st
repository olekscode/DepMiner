Class {
	#name : #MrCanBeExpressedWithTransformationRuleQuestion,
	#superclass : #MrRadioButtonQuestion,
	#category : #'MrMiner-Spec-Views'
}

{ #category : #accessing }
MrCanBeExpressedWithTransformationRuleQuestion >> helpText [
	^ 'Transformation rules (a.k.a. Rewriter rules) are associations in the form antecedent -> consequent that can match the piece of source code defined by the expression in antecedent and replace it with another source code defined by consequent.
	
Example of a migration rule that can be represented with a transformation rule:
deleted-call(isEmpty), deleted-call(not), added-call(isNotEmpty)
Transformation rule: `@rec isEmpty not -> `@rec isNotEmpty

Example of a migration rule that can not be represented with a transformation rule:
deleted-call(writeToFile:), added-call(writeToFile:using:)
Transformation rule can not be proposed because the argument of using: is unknown.

Another example:
deleted-call(new), deleted-call(keys:), deleted-call(values:), added-call(withKeys:values:)
Transformation rule can not be proposed because the deleted method calls could appear in different locations in the source code. So they can not be matched with antecedent.'
]

{ #category : #accessing }
MrCanBeExpressedWithTransformationRuleQuestion >> text [
	^ 'Can it be expressed with a transformation rule?'
]
