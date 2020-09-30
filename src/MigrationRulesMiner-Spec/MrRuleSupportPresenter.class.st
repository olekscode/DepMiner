Class {
	#name : #MrRuleSupportPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'commitPresenter',
		'methodChangesTable',
		'oldSourceCode',
		'newSourceCode'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRuleSupportPresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 4;
		add: 'Method changes from which this rule was extracted' height: self labelHeight;
		add: #methodChangesTable height: 200;
		add: 'Commit' height: self labelHeight;
		add: #commitPresenter height: 5 * self labelHeight;
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
		yourself.
]

{ #category : #accessing }
MrRuleSupportPresenter >> commitPresenter [
	^ commitPresenter
]

{ #category : #initialization }
MrRuleSupportPresenter >> connectPresenters [
	super connectPresenters.
	
	methodChangesTable whenSelectionChangedDo: [
		methodChangesTable selectedItem ifNotNil: [
			self showMethodChange: methodChangesTable selectedItem ] ].
]

{ #category : #initialization }
MrRuleSupportPresenter >> initializePresenters [
	super initializePresenters.
	
	commitPresenter := MrCommitPresenter new.
	methodChangesTable := self newTable.
	oldSourceCode := self newCode.
	newSourceCode := self newCode.
	
	oldSourceCode withoutLineNumbers; withoutSyntaxHighlight; beNotEditable.
	newSourceCode withoutLineNumbers; withoutSyntaxHighlight; beNotEditable.
	
	rule ifNotNil: [ self showMethodChanges ].
]

{ #category : #accessing }
MrRuleSupportPresenter >> methodChangesTable [
	^ methodChangesTable
]

{ #category : #accessing }
MrRuleSupportPresenter >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
MrRuleSupportPresenter >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
MrRuleSupportPresenter >> rule: aRule [
	rule := aRule.
	self showMethodChanges.
]

{ #category : #'accessing model' }
MrRuleSupportPresenter >> setModelBeforeInitialization: aRule [
	rule := aRule
]

{ #category : #'as yet unclassified' }
MrRuleSupportPresenter >> showMethodChange: aMethodChange [
	commitPresenter commit: aMethodChange commit.
	
	oldSourceCode text: aMethodChange oldSourceCode.
	newSourceCode text: aMethodChange newSourceCode.
]

{ #category : #initialization }
MrRuleSupportPresenter >> showMethodChanges [
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
