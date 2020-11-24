Class {
	#name : #DepRecommendationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'recommendation',
		'replacementImplementations',
		'replacementsList',
		'generatedCode',
		'saveButton'
	],
	#category : #'DepMiner-Spec-Views'
}

{ #category : #specs }
DepRecommendationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 3;
		add: (SpBoxLayout newHorizontal
			spacing: 5;
			add: (SpBoxLayout newVertical
				add: 'Replacements' height: self labelHeight;
				add: #replacementsList;
				yourself) width: 200;
			add: (SpBoxLayout newVertical
				add: 'Generated code' height: self labelHeight;
				add: #generatedCode;
				yourself);
			yourself);
		add: (SpBoxLayout newHorizontal
			add: '';
			add: #saveButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #initialization }
DepRecommendationPresenter >> connectPresenters [
	super connectPresenters.
	
	replacementsList whenSelectionChangedDo: [ :selectionMode |
		self onReplacementSelectionChanged ].
	
	saveButton action: [ self onSaveClicked ].
]

{ #category : #initialization }
DepRecommendationPresenter >> initializePresenters [
	super initializePresenters.
	
	replacementsList := self newList.
		
	replacementsList display: [ :replacement |
		', ' join: (replacement rule addedMethodCalls collect: [ :call | call selector ]) ].
	
	replacementsList contextMenu: [
		SpMenuPresenter new 
			addGroup: [ :group | group 
				addItem: [ :item | item
					name: 'Inspect';
					action: [ replacementsList selectedItem inspect ] ];
				addItem: [ :item | item
					name: 'Explain why';
					action: [
						(DepMethodChangeBrowser on: replacementsList selectedItem rule)
							openWithSpec ] ] ] ].
	
	generatedCode := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		yourself.
	
	saveButton  := self newButton
		label: 'Save';
		yourself.
		
	self showReplacements.
	self onReplacementSelectionChanged.
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> onReplacementSelectionChanged [
	| replacement |
	replacement := replacementsList selectedItem.
	
	replacement ifNotNil: [
		self showCodeGeneratedBy: replacement ].
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> onSaveClicked [
	replacementsList selectedItem
		ifNil: [ self inform: 'Please select a replacement from the list' ]
		ifNotNil: [ :replacement |
			[ recommendation applyWith: replacement ]
				on: DepRecommendationCanNotBeAppliedError
				do: [ :err | self inform: err messageText ] ].
]

{ #category : #accessing }
DepRecommendationPresenter >> recommendation [
	^ recommendation
]

{ #category : #accessing }
DepRecommendationPresenter >> replacements [
	self subclassResponsibility
]

{ #category : #'accessing model' }
DepRecommendationPresenter >> setModelBeforeInitialization: aRecommendation [
	recommendation := aRecommendation
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> showCodeGeneratedBy: aReplacement [
	generatedCode text: (recommendation generateSourceCodeUsing: aReplacement)
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> showReplacements [
	replacementsList items: self replacements.
	replacementsList selectIndex: 1.
]
