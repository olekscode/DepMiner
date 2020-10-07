Class {
	#name : #MrRulesTable,
	#superclass : #SpTablePresenter,
	#instVars : [
		'rules'
	],
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #'as yet unclassified' }
MrRulesTable >> feedbackIconForRule: aRule [
	aRule isGood ifTrue: [ ^ self iconNamed: #thumbsUp ].
	aRule isBad ifTrue: [ ^ self iconNamed: #thumbsDown ].
	aRule isUncertain ifTrue: [ ^ self iconNamed: #help ].
	
	"No feedback - no icon"
	^ nil
]

{ #category : #initialization }
MrRulesTable >> initialize [
	super initialize.
	self beResizable.
]

{ #category : #accessing }
MrRulesTable >> rules: aCollectionOfRules [
	rules := aCollectionOfRules.
	self showRules.
]

{ #category : #'as yet unclassified' }
MrRulesTable >> showRules [
	self
		columns: { };
		items: rules;
		addColumn: (SpImageTableColumn
			title: 'Feedback'
			evaluated: [ :each | self feedbackIconForRule: each ]);
		addColumn: (SpStringTableColumn
			title: 'Deleted calls'
			evaluated: [ :each | ', ' join: each deletedMethodCalls]);
		addColumn: (SpStringTableColumn
			title: 'Added calls'
			evaluated: [ :each | ', ' join: each addedMethodCalls ]).
			
		rules ifNotEmpty: [ 
			self selectItem: rules first ].
]

{ #category : #enumerating }
MrRulesTable >> whenSelectedRuleChangedDo: aBlock [
	self whenSelectionChangedDo: [ :selection |
		aBlock value: self selectedItem. ]
]
