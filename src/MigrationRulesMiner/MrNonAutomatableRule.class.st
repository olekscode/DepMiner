Class {
	#name : #MrNonAutomatableRule,
	#superclass : #MrRule,
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #testing }
MrNonAutomatableRule >> isAutomatable [
	^ false
]
