Class {
	#name : #MrRuleFeedback,
	#superclass : #Object,
	#instVars : [
		'isGood',
		'canBeIntegrated',
		'canBeExpressedWithTransformationRule',
		'isProposedTransformationRuleGood',
		'manualTransformationRule',
		'isInterestingCase',
		'comment'
	],
	#category : #'MigrationRulesMiner-Models'
}

{ #category : #accessing }
MrRuleFeedback >> canBeExpressedWithTransformationRule [
	^ canBeExpressedWithTransformationRule
]

{ #category : #accessing }
MrRuleFeedback >> canBeExpressedWithTransformationRule: anObject [
	canBeExpressedWithTransformationRule := anObject
]

{ #category : #accessing }
MrRuleFeedback >> canBeIntegrated [
	^ canBeIntegrated
]

{ #category : #accessing }
MrRuleFeedback >> canBeIntegrated: anObject [
	canBeIntegrated := anObject
]

{ #category : #accessing }
MrRuleFeedback >> comment [
	^ comment
]

{ #category : #accessing }
MrRuleFeedback >> comment: anObject [
	comment := anObject
]

{ #category : #accessing }
MrRuleFeedback >> isGood [
	^ isGood
]

{ #category : #accessing }
MrRuleFeedback >> isGood: anObject [
	isGood := anObject
]

{ #category : #accessing }
MrRuleFeedback >> isInterestingCase [
	^ isInterestingCase
]

{ #category : #accessing }
MrRuleFeedback >> isInterestingCase: anObject [
	isInterestingCase := anObject
]

{ #category : #accessing }
MrRuleFeedback >> isProposedTransformationRuleGood [
	^ isProposedTransformationRuleGood
]

{ #category : #accessing }
MrRuleFeedback >> isProposedTransformationRuleGood: anObject [
	isProposedTransformationRuleGood := anObject
]

{ #category : #accessing }
MrRuleFeedback >> manualTransformationRule [
	^ manualTransformationRule
]

{ #category : #accessing }
MrRuleFeedback >> manualTransformationRule: anObject [
	manualTransformationRule := anObject
]
