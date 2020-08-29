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
	^ SpGridLayout new
		add: 'Min count' at: 1@1;
		add: #minCountSelect at: 2@1;
		add: (SpBoxLayout newHorizontal
			addLast: #mineRulesButton;
			yourself)
		at: 1@2 span: 2@1;
		yourself.
]

{ #category : #accessing }
MRAprioriMinerPresenter >> changeHistory: anObject [
	changeHistory := anObject
]

{ #category : #initialization }
MRAprioriMinerPresenter >> initializePresenters [ 
	minCountSelect := self newNumberInput.
	
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
