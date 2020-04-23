Class {
	#name : #MRMessageSendCollectingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'messageSends'
	],
	#category : #MigrationRulesMiner
}

{ #category : #initialization }
MRMessageSendCollectingVisitor >> initialize [ 
	super initialize.
	messageSends := OrderedCollection new.
]

{ #category : #accessing }
MRMessageSendCollectingVisitor >> messageSends [
	^ messageSends
]

{ #category : #visiting }
MRMessageSendCollectingVisitor >> visitMessageNode: aNode [
	messageSends add: (
		MRMessageSend new
			astNode: aNode;
			yourself).
			
	super visitMessageNode: aNode.
]
