Class {
	#name : #MrMinerSelectorCollector,
	#superclass : #RefrainSelectorCollector,
	#instVars : [
		'oldSelectors',
		'newSelectors'
	],
	#category : #'MrMiner-Controllers'
}

{ #category : #'as yet unclassified' }
MrMinerSelectorCollector >> collectEntitiesFromNewCode: aSourceCode [
	| methodCalls |
	methodCalls := super collectEntitiesFromNewCode: aSourceCode.
	methodCalls := methodCalls select: [ :methodCall | newSelectors includes: methodCall selector ].
	^ methodCalls
]

{ #category : #'as yet unclassified' }
MrMinerSelectorCollector >> collectEntitiesFromOldCode: aSourceCode [
	| methodCalls |
	methodCalls := super collectEntitiesFromOldCode: aSourceCode.
	methodCalls := methodCalls select: [ :methodCall | oldSelectors includes: methodCall selector ].
	^ methodCalls
]

{ #category : #accessing }
MrMinerSelectorCollector >> newSelectors: aCollectionOfSymbols [
	newSelectors := aCollectionOfSymbols
]

{ #category : #accessing }
MrMinerSelectorCollector >> oldSelectors: aCollectionOfSymbols [
	oldSelectors := aCollectionOfSymbols
]
