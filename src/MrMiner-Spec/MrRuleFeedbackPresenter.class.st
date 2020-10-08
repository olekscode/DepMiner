Class {
	#name : #MrRuleFeedbackPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ruleFeedback',
		'isRuleAutomatable',
		'isGoodRadio',
		'canBeExpressedWithTransformationRuleRadio',
		'isProposedTransformationRuleGoodRadio',
		'manualTransformationRuleLabel',
		'manualTransformationRuleAntecedentText',
		'manualTransformationRuleConsequentText',
		'transformationRuleArrow',
		'validationImage',
		'validateTransformationRuleButton',
		'helpTransformationRuleButton',
		'canBeDeprecationRadio',
		'isInterestingCaseCheckbox',
		'commentText',
		'feedbackChangedCallback',
		'saveButton'
	],
	#category : #'MrMiner-Spec-Views'
}

{ #category : #specs }
MrRuleFeedbackPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 10;
		add: #isGoodRadio;
		add: (SpBoxLayout newHorizontal
			add: #canBeExpressedWithTransformationRuleRadio;
			add: #isProposedTransformationRuleGoodRadio;
			yourself);
		add: (SpBoxLayout newVertical
			spacing: 5; 
			add: #manualTransformationRuleLabel height: self labelHeight;
			add: (SpBoxLayout newHorizontal 
				add: #manualTransformationRuleAntecedentText;
				add: #transformationRuleArrow width: 20;
				add: #manualTransformationRuleConsequentText;
				yourself) height: 50;
			add: (SpBoxLayout newHorizontal 
				spacing: 2;
				add: '';
				add: #validationImage width: self buttonHeight;
				add: #validateTransformationRuleButton width: self buttonWidth;
				add: #helpTransformationRuleButton width: self buttonWidth;
				yourself) height: self buttonHeight;
			yourself);
		add: #canBeDeprecationRadio;
		add: 'Comment:' height: self labelHeight;
		add: #commentText height: 50;
		add: (SpBoxLayout newHorizontal
			add: #isInterestingCaseCheckbox;
			add: #saveButton width: self buttonWidth;
			yourself) height: self buttonHeight;
		yourself.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> beForAutomatableRule [
	isRuleAutomatable := true.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> beForNonAutomatableRule [
	isRuleAutomatable := false.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> connectPresenters [
	super connectPresenters.

	saveButton action: [ self saveFeedback ].
	
	validateTransformationRuleButton action: [
		self validateTransformationRule: self getManualTransformationRule ].
	
	isGoodRadio
		whenNoDo: [ self onBadRule ];
		whenYesOrNotSureDo: [ self onCouldBeGoodRule ].
		
	canBeExpressedWithTransformationRuleRadio
		whenNoDo: [ self onImpossibleToTransform ];
		whenYesOrNotSureDo: [ self onCouldBePossibleToTransform ].
		
	isProposedTransformationRuleGoodRadio
		whenYesDo: [ self onShouldNotWriteManualTransformationRule ];
		whenNoOrNotSureDo: [ self onCouldWriteManualTransformationRule ].
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> getManualTransformationRule [
	| antecedentString consequentString |
	
	antecedentString := manualTransformationRuleAntecedentText text asString trimBoth.
	consequentString := manualTransformationRuleConsequentText text asString trimBoth.
	
	(antecedentString isEmpty and: [ consequentString isEmpty ])
		ifTrue: [ ^ nil ].
		
	^ PDTransformationRule new
		antecedent: antecedentString;
		consequent: consequentString;
		yourself.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializeEmptyRuleFeedback [
	ruleFeedback := MrRuleFeedback new.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> initializePresenters [ 
	super initializePresenters.
	
	isRuleAutomatable := false.
	
	isGoodRadio := MrIsGoodQuestion new.
	canBeExpressedWithTransformationRuleRadio := MrCanBeExpressedWithTransformationRuleQuestion new.
	isProposedTransformationRuleGoodRadio := MrIsProposedTransformationRuleGoodQuestion new.
	canBeDeprecationRadio := MrCanBeDeprecationQuestion new.
	
	manualTransformationRuleLabel := self newLabel.
	manualTransformationRuleAntecedentText := self newText.
	manualTransformationRuleConsequentText := self newText.
	commentText := self newText.
	
	transformationRuleArrow := self newImage
		image: (self iconNamed: #smallForward);
		yourself.
	
	helpTransformationRuleButton := self newButton
		label: 'Help';
		icon: (self iconNamed: #help);
		yourself.
		
	validateTransformationRuleButton := self newButton
		label: 'Validate';
		yourself.
		
	validationImage := self newImage.
		
	isInterestingCaseCheckbox := self newCheckBox
		label: 'Mark this rule as an interesting case that could be discussed';
		yourself.
		
	saveButton := self newButton
		label: 'Save';
		yourself.
		
	self initializeEmptyRuleFeedback.
	self showRuleFeedback.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onBadRule [
	canBeExpressedWithTransformationRuleRadio disable.
	self onImpossibleToTransform.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onCouldBeGoodRule [
	canBeExpressedWithTransformationRuleRadio enable.
	
	(canBeExpressedWithTransformationRuleRadio selectedOption = 'No')
		ifFalse: [ self onCouldBePossibleToTransform ].
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onCouldBePossibleToTransform [
	isProposedTransformationRuleGoodRadio enable.
	canBeDeprecationRadio enable.
	
	(isProposedTransformationRuleGoodRadio selectedOption = 'Yes')
		ifFalse: [ self onCouldWriteManualTransformationRule ].
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onCouldWriteManualTransformationRule [
	manualTransformationRuleLabel enable.
	manualTransformationRuleAntecedentText enable.
	manualTransformationRuleConsequentText enable.
	validateTransformationRuleButton enable.
	helpTransformationRuleButton enable.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onImpossibleToTransform [
	isProposedTransformationRuleGoodRadio disable.
	canBeDeprecationRadio disable.
	self onShouldNotWriteManualTransformationRule.
]

{ #category : #initialization }
MrRuleFeedbackPresenter >> onShouldNotWriteManualTransformationRule [
	manualTransformationRuleAntecedentText clearContent.
	manualTransformationRuleConsequentText clearContent.

	manualTransformationRuleLabel disable.
	manualTransformationRuleAntecedentText disable.
	manualTransformationRuleConsequentText disable.
	validateTransformationRuleButton disable.
	helpTransformationRuleButton disable.
]

{ #category : #accessing }
MrRuleFeedbackPresenter >> ruleFeedback: anObject [
	anObject
		ifNotNil: [ ruleFeedback := anObject ]
		ifNil: [ self initializeEmptyRuleFeedback ].
		
	self showRuleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> saveFeedback [
	| transformationRule |
	transformationRule := self getManualTransformationRule.
	
	(transformationRule isNil or: [ self validateTransformationRule: transformationRule ])
		ifFalse: [ 
			self inform: 'Transformation rule is invalid. Please check the help.'.
			^ self ].

	ruleFeedback isGood: isGoodRadio selectedOption.
	ruleFeedback canBeExpressedWithTransformationRule: canBeExpressedWithTransformationRuleRadio selectedOption.
	ruleFeedback isProposedTransformationRuleGood: isProposedTransformationRuleGoodRadio selectedOption.
	ruleFeedback canBeDeprecation: canBeDeprecationRadio selectedOption.
	
	ruleFeedback manualTransformationRule: transformationRule.
	ruleFeedback comment: commentText text asString.
	
	ruleFeedback isInterestingCase: isInterestingCaseCheckbox state.
	
	feedbackChangedCallback value: ruleFeedback.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> showRuleFeedback [ 
	isGoodRadio selectOption: ruleFeedback isGood.
	canBeExpressedWithTransformationRuleRadio selectOption: ruleFeedback canBeExpressedWithTransformationRule.
	isProposedTransformationRuleGoodRadio selectOption: ruleFeedback isProposedTransformationRuleGood.
	canBeDeprecationRadio selectOption: ruleFeedback canBeDeprecation.
		
	ruleFeedback manualTransformationRule
		ifNil: [ 
			manualTransformationRuleAntecedentText text: ''.
			manualTransformationRuleConsequentText text: '' ]
		ifNotNil: [ :rule |
			manualTransformationRuleAntecedentText text: rule antecedent.
			manualTransformationRuleConsequentText text: rule consequent ].
		
	commentText text: (ruleFeedback comment
		ifNil: [ '' ]
		ifNotNil: [ :value | value ]).
		
	isInterestingCaseCheckbox state: (ruleFeedback isInterestingCase
		ifNil: [ false ]
		ifNotNil: [ :value | value ]).
		
	isRuleAutomatable
		ifTrue: [
			isProposedTransformationRuleGoodRadio show.
			manualTransformationRuleLabel label: 'Propose a different transformation rule' ]
		ifFalse: [
			isProposedTransformationRuleGoodRadio hide.
			manualTransformationRuleLabel label: 'Propose a transformation rule' ].
		
	validationImage image: nil.
]

{ #category : #'as yet unclassified' }
MrRuleFeedbackPresenter >> validateTransformationRule: aTransformationRule [
	| isValid |
	
	isValid := aTransformationRule
		ifNil: [ false ]
		ifNotNil: [ :rule | rule isValid ].
	
	validationImage image:
		(self iconNamed:
			(isValid ifTrue: [ #smallOk ] ifFalse: [ #smallCancel ])).
			
	^ isValid
]

{ #category : #'api - events' }
MrRuleFeedbackPresenter >> whenFeedbackChangedDo: aBlock [
	feedbackChangedCallback := aBlock
]
