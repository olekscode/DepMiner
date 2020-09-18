Class {
	#name : #MRExportToExcelCommand,
	#superclass : #MRCommand,
	#category : #'MigrationRulesMiner-Spec-Command'
}

{ #category : #accessing }
MRExportToExcelCommand class >> defaultDescription [
	^ 'Export rules to an Excel file'
]

{ #category : #accessing }
MRExportToExcelCommand class >> defaultIconName [ 
	^ #glamorousSave
]

{ #category : #accessing }
MRExportToExcelCommand class >> defaultName [ 
	^ 'Export'
]

{ #category : #executing }
MRExportToExcelCommand >> execute [
	Transcript open
]
