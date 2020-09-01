Class {
	#name : #MRMigrationRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'commitLoader',
		'aprioriMiner',
		'firstTable',
		'secondTable',
		'allRulesPage',
		'automatableRulesPage',
		'changeHistory',
		'rules'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRMigrationRulesBrowser class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: (SpBoxLayout newVertical
			add: #commitLoader;
			add: #aprioriMiner height: 80;
			yourself) width: 300;
		add: #firstTable;
		add: #secondTable;
		yourself.
]

{ #category : #'world menu' }
MRMigrationRulesBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Migration Rules Miner')
		parent: #Tools;
		action: [ self open ];
		order: 40;
		help: 'A tool for mining migration rules from the commit history';
		icon: (self iconNamed: #diff).
	aBuilder withSeparatorAfter
]

{ #category : #'world menu' }
MRMigrationRulesBrowser class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #accessing }
MRMigrationRulesBrowser >> aprioriMiner [
	^ aprioriMiner
]

{ #category : #accessing }
MRMigrationRulesBrowser >> aprioriMiner: anObject [
	aprioriMiner := anObject
]

{ #category : #accessing }
MRMigrationRulesBrowser >> changeHistory: anObject [
	changeHistory := anObject.
	aprioriMiner changeHistory: anObject.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> commitLoader [
	^ commitLoader
]

{ #category : #accessing }
MRMigrationRulesBrowser >> commitLoader: anObject [
	commitLoader := anObject
]

{ #category : #accessing }
MRMigrationRulesBrowser >> firstTable [
	^ firstTable
]

{ #category : #accessing }
MRMigrationRulesBrowser >> firstTable: anObject [
	firstTable := anObject
]

{ #category : #TOREMOVE }
MRMigrationRulesBrowser >> initialExtent [
	^ 1300@600
]

{ #category : #initialization }
MRMigrationRulesBrowser >> initializeWidgets [
	commitLoader := MRCommitLoaderPresenter new
		parent: self;
		yourself.
		
	aprioriMiner := MRAprioriMinerPresenter new
		parent: self;
		yourself.
		
	firstTable := self newTable.
	secondTable := self newTable.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> rules: anObject [
	rules := anObject.
	self showRules.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> secondTable [
	^ secondTable
]

{ #category : #accessing }
MRMigrationRulesBrowser >> secondTable: anObject [
	secondTable := anObject
]

{ #category : #'as yet unclassified' }
MRMigrationRulesBrowser >> showRules [
	firstTable
		columns: { };
		items: rules;
		addColumn: (SpStringTableColumn
			title: 'Antecedent'
			evaluated: [ :each | ' ' join: each antecedent ]);
		addColumn: (SpStringTableColumn
			title: 'Consequent'
			evaluated: [ :each | ' ' join: each consequent ]);
		addColumn: (SpStringTableColumn
			title: 'Count'
			evaluated: [ :each | each count ]);
		addColumn: (SpStringTableColumn 
			title: 'Confidence'
			evaluated: [ :each | each confidence asFloat ]);
		addColumn: (SpStringTableColumn
			title: 'Lift'
			evaluated: [ :each | each lift asFloat ]).
]

{ #category : #TOREMOVE }
MRMigrationRulesBrowser >> title [ 
	^ 'Migration Rules Miner'
]
