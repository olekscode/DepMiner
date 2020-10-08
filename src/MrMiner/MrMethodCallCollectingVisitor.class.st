Class {
	#name : #MrMethodCallCollectingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'methodCalls'
	],
	#category : #'MrMiner-Visitors'
}

{ #category : #initialization }
MrMethodCallCollectingVisitor >> initialize [ 
	super initialize.
	methodCalls := OrderedCollection new.
]

{ #category : #accessing }
MrMethodCallCollectingVisitor >> methodCalls [
	^ methodCalls
]

{ #category : #visiting }
MrMethodCallCollectingVisitor >> visitMessageNode: aNode [
	| methodCall |
	
	methodCall := MrMethodCall new
		selector: aNode selector;
		yourself.
		
	methodCalls add: methodCall.
	super visitMessageNode: aNode.
]
