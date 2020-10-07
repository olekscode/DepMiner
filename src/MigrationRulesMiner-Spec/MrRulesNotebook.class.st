Class {
	#name : #MrRulesNotebook,
	#superclass : #SpNotebookPresenter,
	#instVars : [
		'rules',
		'ruleSelectionCallback'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
MrRulesNotebook >> addAllRulesPage [
	self
		addPageWithRules: rules
		title: 'All rules'. 
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> addAutomatableRulesPage [
	self
		addPageWithRules: (rules select: [ :each | each isAutomatable ])
		title: 'Automatable'. 
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> addNonAutomatableRulesPage [
	self
		addPageWithRules: (rules reject: [ :each | each isAutomatable ])
		title: 'Non-automatable'. 
]

{ #category : #adding }
MrRulesNotebook >> addPageWithRules: aCollectionOfRules title: aTitle [
	| page |
	
	page := self newNotebookPage
		title: aTitle;
		presenterProvider: [
			MrRulesTable new
				rules: aCollectionOfRules;
				whenSelectedRuleChangedDo: [ :rule | ruleSelectionCallback value: rule ];
				yourself ];
		yourself.
	
	self addPage: page.
]

{ #category : #accessing }
MrRulesNotebook >> rules: aCollectionOfRules [
	rules := aCollectionOfRules.
	rules ifNotNil: [ self showRules ].
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> showRules [
	self addAllRulesPage.
	self addAutomatableRulesPage.
	self addNonAutomatableRulesPage.
]

{ #category : #enumerating }
MrRulesNotebook >> whenSelectedRuleChangedDo: aBlock [
	ruleSelectionCallback := aBlock
]
