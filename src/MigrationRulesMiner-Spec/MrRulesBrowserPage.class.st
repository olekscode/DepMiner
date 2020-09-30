Class {
	#name : #MrRulesBrowserPage,
	#superclass : #SpPresenter,
	#instVars : [
		'rules',
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

{ #category : #initialization }
MrRulesBrowserPage >> initializePresenters [ 
	super initializePresenters.
	
	rulesTable := self newTable.
	rulePresenter := MrRulePresenter new.
	
	rules ifNotNil: [ self showRules ].
]

{ #category : #accessing }
MrRulesBrowserPage >> rulePresenter [
	^ rulePresenter
]

{ #category : #accessing }
MrRulesBrowserPage >> rules: aCollectionOfRules [
	rules := aCollectionOfRules.
	self showRules.
]

{ #category : #accessing }
MrRulesBrowserPage >> rulesTable [
	^ rulesTable
]

{ #category : #'accessing model' }
MrRulesBrowserPage >> setModelBeforeInitialization: aCollectionOfRules [
	rules := aCollectionOfRules
]

{ #category : #'as yet unclassified' }
MrRulesBrowserPage >> showRule: aRule [
	rulePresenter rule: aRule
]

{ #category : #'as yet unclassified' }
MrRulesBrowserPage >> showRules [
	| sortedRules |
	"Sort first by lift then by confidence then by count"
	sortedRules := rules sorted: [ :a :b |
		a lift > b lift or: [ 
			a lift = b lift and: [ a confidence > b confidence or: [ 
				a confidence = b confidence and: [ a count > b count ] ] ] ] ].

	rulesTable
		columns: { };
		items: sortedRules;
		addColumn: (SpStringTableColumn
			title: 'Deleted calls'
			evaluated: [ :each | ', ' join: each deletedMethodCalls]);
		addColumn: (SpStringTableColumn
			title: 'Added calls'
			evaluated: [ :each | ', ' join: each addedMethodCalls ]).
			
		rules ifNotEmpty: [ 
			rulesTable selectIndex: 1.
			self showRule: rulesTable selectedItem ].
]