Class {
	#name : #BaselineOfDepMiner,
	#superclass : #BaselineOf,
	#category : #BaselineOfDepMiner
}

{ #category : #baselines }
BaselineOfDepMiner >> baseline: spec [
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
			package: 'DepMiner' with: [ spec requires: #('Refrain' 'TransformationRule') ];
			package: 'DepMiner-Tests' with: [ spec requires: #('DepMiner') ];
			package: 'DepMiner-Spec' with: [ spec requires: #('DepMiner' 'FileDialog') ] ]
]
