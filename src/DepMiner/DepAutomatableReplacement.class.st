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

{ #category : #testing }
DepAutomatableReplacement >> isAutomatable [
	^ true
]
