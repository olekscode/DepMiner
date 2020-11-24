Class {
	#name : #DepRecommendationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'recommendation',
		'generatedCode',
		'replacementsList',
		'generatedCodePresenter',
		'saveButton',
		'acceptedChanges',
		'numberOfAcceptedChangesLabel',
		'inspectAcceptedChangesLink'
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
				add: #generatedCodePresenter;
				yourself);
			yourself);
		add: (SpBoxLayout newHorizontal
			add: '';
			add: (SpBoxLayout newVertical
				add: #numberOfAcceptedChangesLabel;
				add: #inspectAcceptedChangesLink;
				yourself) width: 180;
			add: #saveButton width: self buttonWidth;
			yourself) height: 1.3 * self buttonHeight;
		yourself.
]

{ #category : #accessing }
DepRecommendationPresenter >> acceptedChanges: aCollectionOfSavedChanges [
	acceptedChanges := aCollectionOfSavedChanges.
	self showNumberOfAcceptedChanges.
]

{ #category : #initialization }
DepRecommendationPresenter >> connectPresenters [
	super connectPresenters.
	
	replacementsList whenSelectionChangedDo: [ :selectionMode |
		self onReplacementSelectionChanged ].
	
	inspectAcceptedChangesLink action: [ acceptedChanges inspect ].
	
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
	
	generatedCodePresenter := self newCode
		withoutLineNumbers;
		beForBehavior: Object;
		yourself.
		
	numberOfAcceptedChangesLabel := self newLabel.
	
	inspectAcceptedChangesLink := self newLink
		label: '(inspect)';
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
			[ recommendation applyWith: replacement. self updateAcceptedChangesLog ]
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
	generatedCode := recommendation generateSourceCodeUsing: aReplacement.
	generatedCodePresenter text: generatedCode 
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> showNumberOfAcceptedChanges [
	| numberOfAcceptedChanges |
	numberOfAcceptedChanges := acceptedChanges
		ifNil: [ 0 ]
		ifNotNil: [ acceptedChanges size ].
		
	numberOfAcceptedChangesLabel label: (numberOfAcceptedChanges asString, ' changes were accepted').
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> showReplacements [
	replacementsList items: self replacements.
	replacementsList selectIndex: 1.
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> updateAcceptedChangesLog [
	acceptedChanges add: (DepAcceptedChangeLog new
		datetime: DateAndTime now;
		recommendation: recommendation;
		replacement: replacementsList selectedItem;
		proposedCode: generatedCode;
		savedCode: generatedCodePresenter text asString;
		yourself).
		
	self showNumberOfAcceptedChanges.
	self writeAcceptedChangesLogToSton.
]

{ #category : #'as yet unclassified' }
DepRecommendationPresenter >> writeAcceptedChangesLogToSton [
	| file |
	file := 'acceptedChangesLog.ston' asFileReference.
	
	file writeStreamDo: [ :writeStream |
		STON put: acceptedChanges onStream: writeStream  ]
]
