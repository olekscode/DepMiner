Class {
	#name : #MrRulePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'deletedCallsList',
		'addedCallsList',
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
		add: 'Method changes from which this rule was extracted' height: self labelHeight;
		add: #methodChangesTable height: 200;
		add: 'Commit' height: self labelHeight;
		add: #commitPresenter height: 4.5 * self labelHeight;
		add: (SpBoxLayout newHorizontal
			spacing: 4;
			add: (SpBoxLayout newVertical
				add: 'Old source code' height: self labelHeight;
				add: #oldSourceCode;
				yourself);
			add: (SpBoxLayout newVertical
				add: 'New source code' height: self labelHeight;
				add: #newSourceCode;
				yourself);
			yourself);
		add: #ruleFeedbackPresenter height: 200;
		yourself.
]

{ #category : #accessing }
MrRulePresenter >> addedCallsList [
	^ addedCallsList
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
	
	commitPresenter := MrCommitPresenter new.
	methodChangesTable := self newTable.
	oldSourceCode := self newCode.
	newSourceCode := self newCode.
	
	oldSourceCode withoutLineNumbers.
	newSourceCode withoutLineNumbers.
	
	ruleFeedbackPresenter := MrRuleFeedbackPresenter new.
	
	rule ifNotNil: [ self showRule ].
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
	deletedCallsList items: rule deletedMethodCalls asArray.
	addedCallsList items: rule addedMethodCalls asArray.
	self showMethodChanges.
]
