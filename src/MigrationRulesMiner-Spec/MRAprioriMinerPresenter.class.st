Class {
	#name : #MRAprioriMinerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'minCountSelect',
		'mineRulesButton',
		'changeHistory',
		'aprioriMiner',
		'parent'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRAprioriMinerPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: 'Min count' width: self labelWidth;
			add: #minCountSelect;
			yourself);
		add: #mineRulesButton height: self buttonHeight;
		yourself.
]

{ #category : #accessing }
MRAprioriMinerPresenter >> changeHistory: anObject [
	changeHistory := anObject
]

{ #category : #initialization }
MRAprioriMinerPresenter >> connectPresenters [
	mineRulesButton action: [ self mineRules ]
]

{ #category : #initialization }
MRAprioriMinerPresenter >> initializePresenters [ 
	minCountSelect := self newNumberInput
		minimum: 1;
		yourself.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.
]

{ #category : #accessing }
MRAprioriMinerPresenter >> minCountSelect [
	^ minCountSelect
]

{ #category : #accessing }
MRAprioriMinerPresenter >> minCountSelect: anObject [
	minCountSelect := anObject
]

{ #category : #'as yet unclassified' }
MRAprioriMinerPresenter >> mineRules [
	aprioriMiner := MRAprioriMiner new
		changeHistory: changeHistory;
		yourself.
		
	aprioriMiner collectTransactions.
	aprioriMiner mineRulesWithMinCount: minCountSelect number.
	parent rules: aprioriMiner rules.
]

{ #category : #accessing }
MRAprioriMinerPresenter >> mineRulesButton [
	^ mineRulesButton
]

{ #category : #accessing }
MRAprioriMinerPresenter >> mineRulesButton: anObject [
	mineRulesButton := anObject
]

{ #category : #accessing }
MRAprioriMinerPresenter >> parent: anObject [
	parent := anObject
]
