Class {
	#name : #MrRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'rules',
		'rulesTable',
		'rulePresenter'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #specs }
MrRulesBrowser class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 15;
		add: #rulesTable width: 500;
		add: #rulePresenter;
		yourself.
]

{ #category : #accessing }
MrRulesBrowser class >> defaultTitle [
	^ 'Rule Browser'
]

{ #category : #accessing }
MrRulesBrowser class >> preferredExtent [
	^ 1700@1000
]

{ #category : #initialization }
MrRulesBrowser >> connectPresenters [
	super connectPresenters.
	
	rulesTable whenSelectionChangedDo: [
		rulesTable selectedItem ifNotNil: [ 
			self showRule: rulesTable selectedItem ] ]
]

{ #category : #initialization }
MrRulesBrowser >> initializePresenters [ 
	super initializePresenters.
	
	rulesTable := self newTable.
	rulePresenter := MrRulePresenter new.
	
	self showRules.
]

{ #category : #initialization }
MrRulesBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class preferredExtent.
]

{ #category : #accessing }
MrRulesBrowser >> rulePresenter [
	^ rulePresenter
]

{ #category : #accessing }
MrRulesBrowser >> rulesTable [
	^ rulesTable
]

{ #category : #'accessing model' }
MrRulesBrowser >> setModelBeforeInitialization: aCollectionOfRules [
	rules := aCollectionOfRules
]

{ #category : #'as yet unclassified' }
MrRulesBrowser >> showRule: aRule [
	rulePresenter rule: aRule
]

{ #category : #'as yet unclassified' }
MrRulesBrowser >> showRules [
	rulesTable
		columns: { };
		items: rules;
		addColumn: (SpStringTableColumn
			title: 'Deleted calls'
			evaluated: [ :each | ', ' join: each deletedMethodCalls]);
		addColumn: (SpStringTableColumn
			title: 'Added calls'
			evaluated: [ :each | ', ' join: each addedMethodCalls ]);
		addColumn: (SpStringTableColumn
			title: 'Count'
			evaluated: [ :each | each count ]);
		addColumn: (SpStringTableColumn
			title: 'Confidence'
			evaluated: [ :each | each confidence asFloat round: 3 ]);
		addColumn: (SpStringTableColumn
			title: 'Lift'
			evaluated: [ :each | each lift asFloat round: 3 ]).
			
		rules ifNotEmpty: [ 
			rulesTable selectIndex: 1.
			self showRule: rulesTable selectedItem ].
]
