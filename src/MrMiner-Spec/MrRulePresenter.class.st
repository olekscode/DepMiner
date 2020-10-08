Class {
	#name : #MrRulePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'deletedCallsList',
		'addedCallsList',
		'transformationRuleLabel',
		'notebook',
		'ruleSupportPresenter',
		'ruleFeedbackPresenter',
		'ruleSupportPage',
		'ruleFeedbackPage',
		'feedbackChangedCallback'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrRulePresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 5;
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
		add: #transformationRuleLabel height: self labelHeight;
		add: #notebook;
		yourself.
]

{ #category : #accessing }
MrRulePresenter >> addedCallsList [
	^ addedCallsList
]

{ #category : #initialization }
MrRulePresenter >> connectPresenters [ 
	super connectPresenters.
	
	ruleFeedbackPresenter whenFeedbackChangedDo: [ :ruleFeedback |
		rule feedback: ruleFeedback.
		feedbackChangedCallback value ].
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
	
	transformationRuleLabel := self newLabel.
	
	deletedCallsList items: #().
	addedCallsList items: #().
	
	ruleFeedbackPresenter := MrRuleFeedbackPresenter new.
	ruleSupportPresenter := MrRuleSupportPresenter new.
	
	notebook := self newNotebook.
	
	ruleFeedbackPage := self newNotebookPage
		title: 'Feedback';
		presenterProvider: [ ruleFeedbackPresenter ];
		yourself.
	
	ruleSupportPage := self newNotebookPage
		title: 'Method changes';
		presenterProvider: [ ruleSupportPresenter ];
		yourself.
		
	notebook pages: { ruleFeedbackPage . ruleSupportPage }.
	
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
	
	aRule isAutomatable
		ifTrue: [ ruleFeedbackPresenter beForAutomatableRule ]
		ifFalse: [ ruleFeedbackPresenter beForNonAutomatableRule ].
	
	ruleFeedbackPresenter ruleFeedback: aRule feedback.
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
	
	transformationRuleLabel label: ('Proposed transformation rule: ', 
		(rule isAutomatable
			ifTrue: [ rule transformationRule antecedent, ' -> ', rule transformationRule consequent ]
			ifFalse: [ '(None)' ])).
]

{ #category : #announcing }
MrRulePresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
