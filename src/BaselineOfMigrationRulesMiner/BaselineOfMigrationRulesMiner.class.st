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
				
		"Packages"
		spec 
			package: 'MigrationRulesMiner' with: [ spec requires: #('APriori') ];
			package: 'MigrationRulesMiner-Tests' with: [ spec requires: #('MigrationRulesMiner') ] ]
]
