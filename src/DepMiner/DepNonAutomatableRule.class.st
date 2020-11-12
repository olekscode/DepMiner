Class {
	#name : #DepNonAutomatableRule,
	#superclass : #DepAssociationRule,
	#category : #'DepMiner-Models'
}

{ #category : #testing }
DepNonAutomatableRule >> isAutomatable [
	^ false
]
