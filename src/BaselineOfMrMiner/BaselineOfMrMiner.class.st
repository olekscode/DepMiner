Class {
	#name : #BaselineOfMrMiner,
	#superclass : #BaselineOf,
	#category : #BaselineOfMrMiner
}

{ #category : #baselines }
BaselineOfMrMiner >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'APriori'
			with: [ spec repository: 'github://pharo-ai/APriori/src' ].
			
		spec
			baseline: 'PharoDeprecationsCollector'
			with: [ spec repository: 'github://olekscode/PharoDeprecationsCollector/src' ].
			
		spec
			baseline: 'FileDialog'
			with: [ spec repository: 'github://Ducasse/file-dialog/repository' ].
				
		"Packages"
		spec 
			package: 'MrMiner' with: [ spec requires: #('APriori' 'PharoDeprecationsCollector') ];
			package: 'MrMiner-Tests' with: [ spec requires: #('MrMiner') ];
			package: 'MrMiner-Spec' with: [ spec requires: #('MrMiner' 'FileDialog') ] ]
]
