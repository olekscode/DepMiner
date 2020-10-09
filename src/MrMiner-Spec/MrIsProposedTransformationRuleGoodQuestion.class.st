Class {
	#name : #MrIsProposedTransformationRuleGoodQuestion,
	#superclass : #MrRadioButtonQuestion,
	#category : #'MrMiner-Spec-Views'
}

{ #category : #accessing }
MrIsProposedTransformationRuleGoodQuestion >> helpText [
	^ 'On top of the feedback form and just below the list of added and deleted method calls, you can see the proposed transformation rule. Is it good or can you propose a better one?'
]

{ #category : #accessing }
MrIsProposedTransformationRuleGoodQuestion >> text [ 
	^ 'Is proposed transformation rule good?'
]
