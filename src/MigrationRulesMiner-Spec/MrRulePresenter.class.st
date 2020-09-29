Class {
	#name : #MrRulePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'ruleLabel',
		'commitPresenter',
		'methodChangesTable',
		'oldSourceCode',
		'newSourceCode',
		'ruleFeedbackPresenter'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulePresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 5;
		add: #ruleLabel height: self labelHeight;
		add: #methodChangesTable height: 200;
		add: #commitPresenter height: 3 * self labelHeight;
		add: (SpBoxLayout newHorizontal
			spacing: 4;
			add: #oldSourceCode;
			add: #newSourceCode;
			yourself);
		add: #ruleFeedbackPresenter height: 200;
		yourself.
]

{ #category : #accessing }
MrRulePresenter class >> defaultTitle [
	^ 'Rule Browser'
]

{ #category : #accessing }
MrRulePresenter class >> preferredExtent [
	^ 1200@1000
]

{ #category : #accessing }
MrRulePresenter >> commitPresenter [
	^ commitPresenter
]

{ #category : #initialization }
MrRulePresenter >> connectPresenters [
	super connectPresenters.
	
	methodChangesTable whenSelectionChangedDo: [
		methodChangesTable selectedItem ifNotNil: [
			self showMethodChange: methodChangesTable selectedItem ] ].
]

{ #category : #initialization }
MrRulePresenter >> initializePresenters [
	super initializePresenters.
	
	ruleLabel := self newLabel.
	commitPresenter := MrCommitPresenter new.
	methodChangesTable := self newTable.
	oldSourceCode := self newCode.
	newSourceCode := self newCode.
	
	oldSourceCode withoutLineNumbers.
	newSourceCode withoutLineNumbers.
	
	ruleFeedbackPresenter := MrRuleFeedbackPresenter new.
	
	rule ifNotNil: [ self showRule ].
]

{ #category : #initialization }
MrRulePresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #accessing }
MrRulePresenter >> methodChangesTable [
	^ methodChangesTable
]

{ #category : #accessing }
MrRulePresenter >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
MrRulePresenter >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
MrRulePresenter >> rule: aRule [
	rule := aRule.
	self showRule.
]

{ #category : #accessing }
MrRulePresenter >> ruleFeedbackPresenter [
	^ ruleFeedbackPresenter
]

{ #category : #accessing }
MrRulePresenter >> ruleLabel [
	^ ruleLabel
]

{ #category : #'accessing model' }
MrRulePresenter >> setModelBeforeInitialization: aRule [
	rule := aRule
]

{ #category : #'as yet unclassified' }
MrRulePresenter >> showMethodChange: aMethodChange [
	commitPresenter commit: aMethodChange commit.
	
	oldSourceCode text: aMethodChange oldSourceCode.
	newSourceCode text: aMethodChange newSourceCode.
]

{ #category : #initialization }
MrRulePresenter >> showMethodChanges [
	| items |
	items := rule methodChanges
		ifNil: [ #() ]
		ifNotNil: [ rule methodChanges ].
	
	methodChangesTable
		columns: { };
		items: items;
		addColumn: (SpStringTableColumn
			title: 'Class'
			evaluated: [ :each | each method className ]);
		addColumn: (SpStringTableColumn
			title: 'Method'
			evaluated: [ :each | each method selector ]);
		addColumn: (SpStringTableColumn
			title: 'Commit'
			evaluated: [ :each | each commit shortSha ]).
			
		items ifNotEmpty: [ 
			methodChangesTable selectIndex: 1.
			self showMethodChange: methodChangesTable selectedItem ].
]

{ #category : #initialization }
MrRulePresenter >> showRule [
	ruleLabel label: rule asString.
	self showMethodChanges.
]
