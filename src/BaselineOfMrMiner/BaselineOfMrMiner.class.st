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
			baseline: 'Refrain'
			with: [ spec repository: 'github://olekscode/Refrain/src' ].
			
		spec
			baseline: 'TransformationRule'
			with: [ spec repository: 'github://olekscode/TransformationRule/src' ].
			
		spec
			baseline: 'FileDialog'
			with: [ spec repository: 'github://Ducasse/file-dialog/repository' ].
				
		"Packages"
		spec 
			package: 'MrMiner' with: [ spec requires: #('Refrain' 'TransformationRule') ];
			package: 'MrMiner-Tests' with: [ spec requires: #('MrMiner') ];
			package: 'MrMiner-Spec' with: [ spec requires: #('MrMiner' 'FileDialog') ] ]
]
