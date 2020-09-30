Class {
	#name : #MrRulePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'deletedCallsList',
		'addedCallsList',
		'notebook',
		'ruleSupportPresenter',
		'ruleFeedbackPresenter',
		'ruleSupportPage',
		'ruleFeedbackPage'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulePresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 4;
		add: (SpBoxLayout newHorizontal
			spacing: 4;
			add: (SpBoxLayout newVertical
				add: 'Deleted method calls' height: self labelHeight;
				add: #deletedCallsList;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'Added method calls' height: self labelHeight;
				add: #addedCallsList;
				yourself);
			yourself) height: 70;
		add: #notebook;
		yourself.
]

{ #category : #accessing }
MrRulePresenter >> addedCallsList [
	^ addedCallsList
]

{ #category : #accessing }
MrRulePresenter >> deletedCallsList [
	^ deletedCallsList
]

{ #category : #initialization }
MrRulePresenter >> initializePresenters [
	super initializePresenters.
	
	deletedCallsList := self newList.
	addedCallsList := self newList.
	
	deletedCallsList items: #().
	addedCallsList items: #().
	
	ruleSupportPresenter := MrRuleSupportPresenter new.
	ruleFeedbackPresenter := MrRuleFeedbackPresenter new.
	
	notebook := self newNotebook.
	
	ruleSupportPage := self newNotebookPage
		title: 'Support';
		presenterProvider: [ ruleSupportPresenter ];
		yourself.
		
	ruleFeedbackPage := self newNotebookPage
		title: 'Feedback';
		presenterProvider: [ ruleFeedbackPresenter ];
		yourself.
		
	notebook pages: { ruleSupportPage . ruleFeedbackPage }.
	
	rule ifNotNil: [ self showRule ].
]

{ #category : #accessing }
MrRulePresenter >> notebook [
	^ notebook
]

{ #category : #accessing }
MrRulePresenter >> rule: aRule [
	rule := aRule.
	ruleSupportPresenter rule: aRule.
	self showRule.
]

{ #category : #accessing }
MrRulePresenter >> ruleFeedbackPage [
	^ ruleFeedbackPage
]

{ #category : #accessing }
MrRulePresenter >> ruleFeedbackPresenter [
	^ ruleFeedbackPresenter
]

{ #category : #accessing }
MrRulePresenter >> ruleSupportPage [
	^ ruleSupportPage
]

{ #category : #'accessing model' }
MrRulePresenter >> setModelBeforeInitialization: aRule [
	rule := aRule
]

{ #category : #initialization }
MrRulePresenter >> showRule [
	deletedCallsList items: rule deletedMethodCalls asArray.
	addedCallsList items: rule addedMethodCalls asArray.
]
