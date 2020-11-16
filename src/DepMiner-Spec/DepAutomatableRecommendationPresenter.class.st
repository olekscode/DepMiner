Class {
	#name : #DepAutomatableRecommendationPresenter,
	#superclass : #DepMinerMainAreaPagePresenter,
	#instVars : [
		'projectHistory',
		'method',
		'rules',
		'replacementsList',
		'generatedCode',
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
				yourself);
			yourself);
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #generateButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter class >> forProjectHistory: aProjectHistory method: aMethod applicableRules: aCollectionOfRules [
	^ self new
		initializeProjectHistory: aProjectHistory
		method: aMethod
		applicableRules: aCollectionOfRules;
		yourself.
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
					name: 'Browse implementations';
					action: [ (DepImplementationsBrowser on: (projectHistory sortedMethods
						select: [ :aMethod | aMethod isInNewVersion and: [
								aMethod selector = replacementsList selectedItem addedMethodCalls anyOne selector ] ])) openWithSpec ] ] ] ].
	
	generatedCode := self newCode
		withoutLineNumbers;
		beNotEditable;
		yourself.
	
	generateButton := self newButton
		label: 'Generate';
		yourself.
]

{ #category : #accessing }
DepAutomatableRecommendationPresenter >> initializeProjectHistory: aProjectHistory method: aMethod applicableRules: aCollectionOfRules [
	projectHistory := aProjectHistory.
	method := aMethod.
	rules := aCollectionOfRules.
	
	self showReplacements.
	self showGeneratedCode.
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showGeneratedCode [
	generatedCode text: method sourceCode
]

{ #category : #'as yet unclassified' }
DepAutomatableRecommendationPresenter >> showReplacements [
	replacementsList items: rules
]
