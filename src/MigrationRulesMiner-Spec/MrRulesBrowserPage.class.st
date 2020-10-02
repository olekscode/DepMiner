Class {
	#name : #MrRulesBrowserPage,
	#superclass : #SpPresenter,
	#instVars : [
		'experiment',
		'rulesTable',
		'rulePresenter'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowserPage class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 15;
		add: #rulesTable width: 500;
		add: #rulePresenter;
		yourself.
]

{ #category : #initialization }
MrRulesBrowserPage >> connectPresenters [
	super connectPresenters.
	
	rulesTable whenSelectionChangedDo: [
		rulesTable selectedItem ifNotNil: [ 
			self showRule: rulesTable selectedItem ] ]
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
	
	rulesTable := self newTable.
	rulePresenter := MrRulePresenter new.
	
	experiment ifNotNil: [ self showRules ].
]

{ #category : #accessing }
MrRulesBrowserPage >> rulePresenter [
	^ rulePresenter
]

{ #category : #accessing }
MrRulesBrowserPage >> rulesTable [
	^ rulesTable
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
	| sortedRules feedbackIconMapping |
	"Sort first by lift then by confidence then by count"
	sortedRules := experiment rules sorted: [ :a :b |
		a lift > b lift or: [ 
			a lift = b lift and: [ a confidence > b confidence or: [ 
				a confidence = b confidence and: [ a count > b count ] ] ] ] ].

	feedbackIconMapping := { 
		'Yes' -> (self iconNamed: #thumbsUp) .
		'No' -> (self iconNamed: #thumbsDown) .
		'Not sure' -> (self iconNamed: #help)
	} asDictionary.

	rulesTable
		beResizable;
		columns: { };
		items: sortedRules;
		addColumn: (SpImageTableColumn
			title: 'Feedback'
			evaluated: [ :each | each feedback
				ifNil: [ nil ]
				ifNotNil: [ 
					each feedback isReasonable
						ifNil: [ nil ]
						ifNotNil: [ feedbackIconMapping at: each feedback isReasonable ] ] ]);
		addColumn: (SpStringTableColumn
			title: 'Deleted calls'
			evaluated: [ :each | ', ' join: each deletedMethodCalls]);
		addColumn: (SpStringTableColumn
			title: 'Added calls'
			evaluated: [ :each | ', ' join: each addedMethodCalls ]).
			
		experiment rules ifNotEmpty: [ 
			rulesTable selectIndex: 1.
			self showRule: rulesTable selectedItem ].
]

{ #category : #enumerating }
MrRulesBrowserPage >> whenFeedbackChangedDo: aBlock [
	rulePresenter whenFeedbackChangedDo: aBlock.
]
