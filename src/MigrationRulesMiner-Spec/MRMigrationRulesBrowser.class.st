Class {
	#name : #MRMigrationRulesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'commitLoader',
		'aprioriMiner',
		'rulesNotebook',
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
		add: #rulesNotebook;
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
	
	allRulesPage := self newNotebookPage
		title: 'All rules';
		presenterProvider: [ MRRulesPagePresenter new ]
		yourself.
		
	automatableRulesPage := self newNotebookPage
		title: 'Automatable rules';
		yourself.
	
	rulesNotebook := self newNotebook
		addPage: allRulesPage;
		addPage: automatableRulesPage;
		yourself.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> rules: anObject [
	rules := anObject.
	allRulesPage retrievePresenter showRules: anObject.
]

{ #category : #accessing }
MRMigrationRulesBrowser >> rulesNotebook [
	^ rulesNotebook
]

{ #category : #accessing }
MRMigrationRulesBrowser >> rulesNotebook: anObject [
	rulesNotebook := anObject
]

{ #category : #TOREMOVE }
MRMigrationRulesBrowser >> title [ 
	^ 'Migration Rules Miner'
]
