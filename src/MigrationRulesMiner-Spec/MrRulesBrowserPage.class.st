Class {
	#name : #MrRulesBrowserPage,
	#superclass : #SpPresenter,
	#instVars : [
		'experiment',
		'rulePresenter',
		'rulesNotebook'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowserPage class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 15;
		add: #rulesNotebook width: 500;
		add: #rulePresenter;
		yourself.
]

{ #category : #initialization }
MrRulesBrowserPage >> connectPresenters [
	super connectPresenters.
	
	rulesNotebook whenSelectedRuleChangedDo: [ :rule |
		rule ifNotNil: [ self showRule: rule ] ].
]

{ #category : #accessing }
MrRulesBrowserPage >> experiment [ 
	^ experiment
]

{ #category : #accessing }
MrRulesBrowserPage >> experiment: anExperiment [
	experiment := anExperiment.
	self showRules.
]

{ #category : #initialization }
MrRulesBrowserPage >> initializePresenters [ 
	super initializePresenters.
	
	rulesNotebook := MrRulesNotebook new.
	rulePresenter := MrRulePresenter new.
	
	experiment ifNotNil: [ self showRules ].
]

{ #category : #'accessing model' }
MrRulesBrowserPage >> setModelBeforeInitialization: anExperiment [
	experiment := anExperiment.
]

{ #category : #'as yet unclassified' }
MrRulesBrowserPage >> showRule: aRule [
	rulePresenter rule: aRule
]

{ #category : #'as yet unclassified' }
MrRulesBrowserPage >> showRules [
	rulesNotebook rules: experiment rules.
]

{ #category : #enumerating }
MrRulesBrowserPage >> whenFeedbackChangedDo: aBlock [
	rulePresenter whenFeedbackChangedDo: [
		self showRules.
		aBlock value ].
]
