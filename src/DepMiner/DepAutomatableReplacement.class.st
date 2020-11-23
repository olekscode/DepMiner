Class {
	#name : #DepAutomatableReplacement,
	#superclass : #DepReplacement,
	#category : #'DepMiner-Models'
}

{ #category : #'as yet unclassified' }
DepAutomatableReplacement >> generateDeprecationWithMessage: aDeprecationMessage [
	^ String streamContents: [ :stream | 
		stream
			nextPutAll: 'self deprecated: ''';
			nextPutAll: aDeprecationMessage;
			nextPutAll: ''' transformWith: ''';
			nextPutAll: rule transformationRule antecedent;
			nextPutAll: ''' -> ''';
			nextPutAll: rule transformationRule consequent;
			nextPutAll: '''.' ]
]

{ #category : #'as yet unclassified' }
DepAutomatableReplacement >> generateSourceCodeAfterDeprecation [
	| newSelector arguments newSelectorWithArguments |
	newSelector := rule addedMethodCalls anyOne selector.
	
	arguments := method ast arguments collect: [ :each | each name ].
	
	newSelectorWithArguments := (newSelector anySatisfy: [ :char |
			char isAlphaNumeric or: [ char = $: ] ])
		ifTrue: [ "not an operator"
			(newSelector occurrencesOf: $:) = arguments size
				ifTrue: [
					arguments size = 0
						ifTrue: [ newSelector ]
						ifFalse: [
							' ' join: ((newSelector allButLast splitOn: ':')
								withIndexCollect: [ :each :index | each, ': ', (arguments at: index) ]) ] ]
				ifFalse: [ Error signal: 'Wrong number of arguments' ] ]
		ifFalse: [ "an operator"
			arguments size = 1
				ifTrue: [ newSelector, ' ', arguments first ]
				ifFalse: [ Error signal: 'Wrong number of arguments' ] ].
			
	^ '^ self ', newSelectorWithArguments
]

{ #category : #testing }
DepAutomatableReplacement >> isAutomatable [
	^ true
]
