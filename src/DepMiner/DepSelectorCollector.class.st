Class {
	#name : #DepSelectorCollector,
	#superclass : #RefrainSelectorCollector,
	#instVars : [
		'oldSelectors',
		'newSelectors'
	],
	#category : #'DepMiner-Controllers'
}

{ #category : #'as yet unclassified' }
DepSelectorCollector >> collectEntitiesFromNewCode: aSourceCode [
	| methodCalls |
	methodCalls := super collectEntitiesFromNewCode: aSourceCode.
	methodCalls := methodCalls select: [ :methodCall | newSelectors includes: methodCall selector ].
	^ self rejectIrrelevantMethodCalls: methodCalls.
]

{ #category : #'as yet unclassified' }
DepSelectorCollector >> collectEntitiesFromOldCode: aSourceCode [
	| methodCalls |
	methodCalls := super collectEntitiesFromOldCode: aSourceCode.
	methodCalls := methodCalls select: [ :methodCall | oldSelectors includes: methodCall selector ].
	^ self rejectIrrelevantMethodCalls: methodCalls.
]

{ #category : #accessing }
DepSelectorCollector >> newSelectors: aCollectionOfSymbols [
	newSelectors := aCollectionOfSymbols
]

{ #category : #accessing }
DepSelectorCollector >> oldSelectors: aCollectionOfSymbols [
	oldSelectors := aCollectionOfSymbols
]

{ #category : #'as yet unclassified' }
DepSelectorCollector >> rejectIrrelevantMethodCalls: aCollectionOfMethodCalls [
	^ aCollectionOfMethodCalls reject: [ :methodCall | 
		  (methodCall selector beginsWith: 'test') or: [ 
			  methodCall selector beginsWith: 'example' ] ]
]
