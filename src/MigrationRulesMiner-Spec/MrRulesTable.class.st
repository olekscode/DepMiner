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
	^ aRule feedback
		ifNil: [ nil ]
		ifNotNil: [
			aRule feedback isReasonable
				ifNil: [ nil ]
				ifNotNil: [ self feedbackIconMapping at: aRule feedback isReasonable ] ]
]

{ #category : #'as yet unclassified' }
MrRulesTable >> feedbackIconMapping [
	^ { 
		'Yes' -> (self iconNamed: #thumbsUp) .
		'No' -> (self iconNamed: #thumbsDown) .
		'Not sure' -> (self iconNamed: #help)
	} asDictionary.
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
