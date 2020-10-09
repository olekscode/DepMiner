Class {
	#name : #MrIsGoodQuestion,
	#superclass : #MrRadioButtonQuestion,
	#category : #'MrMiner-Spec-Views'
}

{ #category : #accessing }
MrIsGoodQuestion >> helpText [
	^ 'Migration rule is good if method call replacement which it defines makes sense and could be applied to source code.
	
Examples of good migration ruled:

deleted-call(isEmpty), deleted-call(not), added-call(isNotEmpty)
deleted-call(doWithIndex:), added-call(withIndexDo:)
deleted-call(unique), added-call(uniqueValues)
deleted-call(new), deleted-call(keys:), deleted-call(values:), added-call(withKeys:values:)

Examples of bad migration rules:

deleted-call(size), added-call(new)
deleted-call(name:), added-call(name)
deleted-call(first), deleted-call(second), added-call(collect:)

Notice that some good migration rules can not be expressed with transformation rules or added to a deprecation message. This does not mean that they are bad. In this question, good rules are the method call replacements that make sense and bad rules are the ones that are clearly false positives.'
]

{ #category : #accessing }
MrIsGoodQuestion >> text [
	^ 'Is this a good rule?'
]
