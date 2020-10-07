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
MrRulesNotebook >> addBadRulesPage [
	self
		addPageWithRules: (rules select: [ :each | each isBad ])
		title: 'Bad'. 
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> addGoodRulesPage [
	self
		addPageWithRules: (rules select: [ :each | each isGood ])
		title: 'Good'. 
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
				whenSelectedRuleChangedDo: [ :rule | ruleSelectionCallback value: rule ];
				rules: aCollectionOfRules;
				yourself ];
		yourself.
	
	self addPage: page.
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> addUncertainRulesPage [
	self
		addPageWithRules: (rules select: [ :each | each isUncertain ])
		title: 'Uncertain'. 
]

{ #category : #accessing }
MrRulesNotebook >> rules: aCollectionOfRules [
	rules := aCollectionOfRules.
	rules ifNotNil: [ self showRules ].
]

{ #category : #'as yet unclassified' }
MrRulesNotebook >> showRules [
	| currentlySelectedPageIndex currentlySelectedRule |
	
	self selectedPage ifNotNil: [
		currentlySelectedPageIndex := self selectedPageIndex.
		currentlySelectedRule := self selectedPage activePresenter selectedItem ].
	
	self removeAll.
	self addAllRulesPage.
	self addAutomatableRulesPage.
	self addNonAutomatableRulesPage.
	self addGoodRulesPage.
	self addBadRulesPage.
	self addUncertainRulesPage.
	
	currentlySelectedPageIndex ifNotNil: [ 
		self selectPageIndex: currentlySelectedPageIndex.
		self selectedPage activePresenter selectItem: currentlySelectedRule ].
]

{ #category : #enumerating }
MrRulesNotebook >> whenSelectedRuleChangedDo: aBlock [
	ruleSelectionCallback := aBlock
]
