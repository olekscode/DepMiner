Class {
	#name : #DepInspectSelectedItemCommand,
	#superclass : #DepCommand,
	#category : #'DepMiner-Spec-Commands'
}

{ #category : #default }
DepInspectSelectedItemCommand class >> defaultDescription [
	^ 'Inspect the selected item'
]

{ #category : #accessing }
DepInspectSelectedItemCommand class >> defaultIconName [
	^ #glamorousInspect
]

{ #category : #default }
DepInspectSelectedItemCommand class >> defaultName [
	^ 'Inspect'
]

{ #category : #executing }
DepInspectSelectedItemCommand >> execute [
	context selectedItem inspect.
]
