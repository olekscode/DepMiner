Class {
	#name : #MrCanBeDeprecationQuestion,
	#superclass : #MrRadioButtonQuestion,
	#category : #'MrMiner-Spec-Views'
}

{ #category : #accessing }
MrCanBeDeprecationQuestion >> helpText [
	^ 'Some transformation rules are valid but can not be added to deprecated methods. This can happen either because we do not want to deprecate a given method or because the method does not come from the project which we analyse.
	
For example, consider that while analysing the rules that were generated for DataFrame, you have discovered the following three transformation rules:

`@rec unique -> `@rec uniqueValues
`@rec isEmpty not -> `@rec isNotEmpty
`@rec doWithIndex: `@arg -> `@rec withIndexDo: `@arg

The first rule can be added to the deprecations message of DataSeries>>unique which is part of the DataFrame project.

The second rule can not be added to a deprecation message because neither isEmpty: nor not are being deprecated.

The third rule can not be added to a deprecation message because Collection>>doWithIndex: is not part of the DataFrame project (even though this rule could be added to the deprecation in Pharo project).'
]

{ #category : #accessing }
MrCanBeDeprecationQuestion >> text [ 
	^ 'Can this transformation rule be added to a method deprecation of a project in question?'
]
