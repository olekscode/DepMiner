Extension { #name : #ClioMethod }

{ #category : #'*DepMiner' }
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
