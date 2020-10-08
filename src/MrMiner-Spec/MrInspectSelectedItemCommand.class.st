Class {
	#name : #MrInspectSelectedItemCommand,
	#superclass : #MrCommand,
	#category : #'MrMiner-Spec-Commands'
}

{ #category : #default }
MrInspectSelectedItemCommand class >> defaultDescription [
	^ 'Inspect the selected item'
]

{ #category : #accessing }
MrInspectSelectedItemCommand class >> defaultIconName [
	^ #inspect
]

{ #category : #default }
MrInspectSelectedItemCommand class >> defaultName [
	^ 'Inspect'
]

{ #category : #executing }
MrInspectSelectedItemCommand >> execute [
	context selectedItem inspect.
]
