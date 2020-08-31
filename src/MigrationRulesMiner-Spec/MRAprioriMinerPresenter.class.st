Class {
	#name : #MRAprioriMinerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'minCountSelect',
		'mineRulesButton',
		'changeHistory',
		'rules'
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
	minCountSelect := self newNumberInput.
	
	mineRulesButton := self newButton
		label: 'Mine rules';
		yourself.

	self enabled: false.
]

{ #category : #accessing }
MRAprioriMinerPresenter >> minCountSelect [
	^ minCountSelect
]

{ #category : #accessing }
MRAprioriMinerPresenter >> minCountSelect: anObject [
	minCountSelect := anObject
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
MRAprioriMinerPresenter >> rules [
	^ rules
]
