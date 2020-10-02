Class {
	#name : #MrFeedbackHelpPresenter,
	#superclass : #MrHelpPresenter,
	#category : #'MigrationRulesMiner-Spec-Views'
}

{ #category : #accessing }
MrFeedbackHelpPresenter class >> text [
	^ 'A rule is reasonable if it defines a replacement that makes sense in a given context. For example, { isEmpty . not } -> { isNotEmpty }. One example of a non-reasonable rule would be { initialize } -> { assert:equals: }. This rule is a clear false positive.'
]
