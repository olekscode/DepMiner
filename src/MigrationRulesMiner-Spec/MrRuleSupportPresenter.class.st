Class {
	#name : #MrRuleSupportPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'methodChangesTable',
		'oldSourceCode',
		'newSourceCode'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRuleSupportPresenter class >> defaultSpec [ 
	^ SpBoxLayout newVertical
		spacing: 10;
		add: (SpBoxLayout newVertical
		spacing: 2;
			add: 'Method changes from which this rule was extracted' height: self labelHeight;
			add: #methodChangesTable;
			yourself) height: 200;
		add: (SpBoxLayout newHorizontal
			spacing: 4;
			add: (SpBoxLayout newVertical
				spacing: 2;
				add: 'Old source code' height: self labelHeight;
				add: #oldSourceCode;
				yourself);
			add: (SpBoxLayout newVertical
				spacing: 2;
				add: 'New source code' height: self labelHeight;
				add: #newSourceCode;
				yourself);
			yourself);
		yourself.
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
	
	methodChangesTable := self newTable.
	oldSourceCode := self newCode.
	newSourceCode := self newCode.
	
	oldSourceCode withoutLineNumbers; withoutSyntaxHighlight; beNotEditable.
	newSourceCode withoutLineNumbers; withoutSyntaxHighlight; beNotEditable.
	
	rule ifNotNil: [ self showMethodChanges ].
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
			evaluated: [ :each | each commit shortSha ]);
		addColumn: (SpStringTableColumn
			title: 'Date'
			evaluated: [ :each | each commit datetime asDate ]);
		addColumn: (SpStringTableColumn
			title: 'Time'
			evaluated: [ :each | each commit datetime asTime ]).
			
		items ifNotEmpty: [ 
			methodChangesTable selectIndex: 1.
			self showMethodChange: methodChangesTable selectedItem ].
]
