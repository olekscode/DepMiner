Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepMinerMainAreaPagePresenter,
	#instVars : [
		'method',
		'rules',
		'projectHistory',
		'replacementImplementations',
		'replacementsList',
		'generatedCode',
		'replacementCode',
		'generateButton'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepAutomatableRecommendationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			spacing: 2;
			add: (SpBoxLayout newVertical
				add: 'Replacements' height: self labelHeight;
				add: #replacementsList;
				yourself) width: 250;
			add: (SpBoxLayout newVertical
				add: 'Generated code' height: self labelHeight;
				add: #generatedCode;
				add: 'Implementation of a proposed replacement' height: self labelHeight;
				add: #replacementCode;
				yourself);
			yourself);
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #generateButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter class >> forMethod: aMethod applicableRules: aCollectionOfRules projectHistory: aProjectHistory [
	^ self new
		initializeMethod: aMethod
		applicableRules: aCollectionOfRules
		projectHistory: aProjectHistory;
		yourself.
]

{ #category : #initialization }
DepAutomatableRecommendationPresenter >> connectPresenters [
	super connectPresenters.
	
	replacementsList whenSelectionChangedDo: [ :selectionMode |
		self onReplacementSelectionChanged ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> findReplacementProposedBy: aRule [
	^ projectHistory sortedMethods detect: [ :aMethod |
		"aMethod className = method className and: [ "
			aMethod selector = aRule addedMethodCalls anyOne selector "]" ] ifNone: [ nil ].
]

{ #category : #accessing }
DepAutomatableRecommendationPresenter >> initializeMethod: aMethod applicableRules: aCollectionOfRules projectHistory: aProjectHistory [
	method := aMethod.
	rules := aCollectionOfRules.
	projectHistory := aProjectHistory.
	
	self showReplacements.
]

{ #category : #initialization }
DepAutomatableRecommendationPresenter >> initializePresenters [
	super initializePresenters.
	
	replacementsList := self newList
		display: [ :rule | rule addedMethodCalls anyOne selector ];
		yourself.
	
	replacementsList contextMenu: [
		SpMenuPresenter new 
			addGroup: [ :group | group 
				addItem: [ :item | item
					name: 'Inspect';
					action: [ replacementsList selectedItem inspect ] ];
				addItem: [ :item | item
					name: 'Explain why';
					action: [
						(DepMethodChangeBrowser on: replacementsList selectedItem)
							openWithSpec ] ] ] ].
	
	generatedCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
		
	replacementCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
	
	generateButton := self newButton
		label: 'Generate';
		yourself.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> onReplacementSelectionChanged [
	| rule |
	rule := replacementsList selectedItem.
	
	rule ifNotNil: [
		self showCodeGeneratedBy: rule.
		self showImplementationOfReplacementProposedBy: rule ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showCodeGeneratedBy: aRule [
	generatedCode text: (aRule snapshotOfSourceCodeWithGeneratedDeprecationFor: method)
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showImplementationOfReplacementProposedBy: aRule [
	| replacementMethod |
	replacementMethod := self findReplacementProposedBy: aRule.
	
	replacementMethod ifNotNil: [ replacementCode text: replacementMethod sourceCode ].
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: rules.
	replacementsList selectIndex: 1.
]
