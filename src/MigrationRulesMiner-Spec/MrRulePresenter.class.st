Class {
	#name : #MrRulePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'ruleLabel',
		'commitPresenter',
		'methodChangesTable',
		'oldSourceCode',
		'newSourceCode'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulePresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical 
		add: #ruleLabel height: self labelHeight;
		add: #methodChangesTable;
		add: #commitPresenter;
		add: (SpBoxLayout newHorizontal
			add: #oldSourceCode;
			add: #newSourceCode;
			yourself);
		yourself.
]

{ #category : #accessing }
MrRulePresenter >> commitPresenter [
	^ commitPresenter
]

{ #category : #initialization }
MrRulePresenter >> connectPresenters [
	super connectPresenters.
	
	methodChangesTable whenSelectionChangedDo: [
		self showMethodChange: methodChangesTable selectedItem ].
]

{ #category : #initialization }
MrRulePresenter >> initializePresenters [
	super initializePresenters.
	
	ruleLabel := self newLabel.
	commitPresenter := MrCommitPresenter new.
	methodChangesTable := self newTable.
	oldSourceCode := self newText.
	newSourceCode := self newText.
	
	self showRule.
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
			title: 'Selector'
			evaluated: [ :each | each method selector ]);
		addColumn: (SpStringTableColumn
			title: 'Commit'
			evaluated: [ :each | each commit sha ]).
]

{ #category : #initialization }
MrRulePresenter >> showRule [
	ruleLabel label: rule asString.
	self showMethodChanges.
]
