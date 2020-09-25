Extension { #name : #IceModification }

{ #category : #'*MigrationRulesMiner' }
IceModification >> asMethodChange [
	| method |
	method := MrMethod new 
		className: self definition className;
		selector: self definition name;
		yourself.
		
	^ MrMethodChange new
		method: method;
		oldSourceCode: self oldNode sourceCode;
		newSourceCode: self definition sourceCode;
		yourself.
]

{ #category : #'*MigrationRulesMiner' }
IceModification >> isMethodChange [
	(definition isMethodDefinition and: [ oldNode isMethodDefinition ])
		ifFalse: [ ^ false ].
		
	definition className = oldNode className 
		ifFalse: [ ^ false ].
		
	definition name = oldNode name
		ifFalse: [ ^ false ].
		
	^ true
]