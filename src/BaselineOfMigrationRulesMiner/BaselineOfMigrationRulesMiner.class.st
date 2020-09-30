Class {
	#name : #BaselineOfMigrationRulesMiner,
	#superclass : #BaselineOf,
	#category : #BaselineOfMigrationRulesMiner
}

{ #category : #baselines }
BaselineOfMigrationRulesMiner >> baseline: spec [
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
			package: 'MigrationRulesMiner' with: [ spec requires: #('APriori' 'PharoDeprecationsCollector') ];
			package: 'MigrationRulesMiner-Tests' with: [ spec requires: #('MigrationRulesMiner') ];
			package: 'MigrationRulesMiner-Spec' with: [ spec requires: #('MigrationRulesMiner' 'FileDialog') ] ]
]
