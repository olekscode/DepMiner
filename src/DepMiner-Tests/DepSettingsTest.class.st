Class {
	#name : #DepSettingsTest,
	#superclass : #TestCase,
	#instVars : [
		'settings'
	],
	#category : #'DepMiner-Tests-Models'
}

{ #category : #running }
DepSettingsTest >> setUp [
	super setUp.
	
	settings := DepSettings new
		ownerName: 'pillar-markup';
		projectName: 'pillar';
		oldCommitSha: '1d9e9ee13468a3c0566f495c81dcda5d6d209b7c';
		newCommitSha: 'dba93a555f70b341365aa6a4cfb100039f76fb65';
		minCount: 3;
		minConfidence: 0.1;
		yourself.
]

{ #category : #tests }
DepSettingsTest >> testSton [
	| originalObject stonString recoveredObject |
	
	originalObject := settings.
	
	stonString := STON toString: originalObject.
	recoveredObject := STON fromString: stonString.
	
	self assert: recoveredObject equals: originalObject.
]
