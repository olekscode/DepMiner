Extension { #name : #ClioMethod }

{ #category : #'*MrMiner' }
ClioMethod >> asDepMethod [
	^ DepMethod new
		packageName: packageName;
		className: className;
		selector: selector;
		sourceCode: sourceCode;
		ast: ast;
		deprecation: deprecation;
		yourself.
]
