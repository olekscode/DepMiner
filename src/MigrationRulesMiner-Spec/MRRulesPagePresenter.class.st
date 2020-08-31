Class {
	#name : #MRRulesPagePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rulesTable',
		'sortingTable',
		'addSortingButton',
		'filteringTable',
		'addFilteringButton'
	],
	#category : #'MigrationRulesMiner-Spec'
}

{ #category : #specs }
MRRulesPagePresenter class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		add: #rulesTable;
		add: (SpBoxLayout newVertical
			add: 'Sort by' height: self labelHeight;
			add: #sortingTable;
			add: #addSortingButton height: self buttonHeight;
			add: 'Filtering criteria' height: self labelHeight;
			add: #filteringTable;
			add: #addFilteringButton height: self buttonHeight;
			yourself) width: 150;
		yourself.
]

{ #category : #accessing }
MRRulesPagePresenter >> addFilteringButton [
	^ addFilteringButton
]

{ #category : #accessing }
MRRulesPagePresenter >> addFilteringButton: anObject [
	addFilteringButton := anObject
]

{ #category : #accessing }
MRRulesPagePresenter >> addSortingButton [
	^ addSortingButton
]

{ #category : #accessing }
MRRulesPagePresenter >> addSortingButton: anObject [
	addSortingButton := anObject
]

{ #category : #accessing }
MRRulesPagePresenter >> filteringTable [
	^ filteringTable
]

{ #category : #accessing }
MRRulesPagePresenter >> filteringTable: anObject [
	filteringTable := anObject
]

{ #category : #initialization }
MRRulesPagePresenter >> initializeWidgets [
	rulesTable := self newTable.
	sortingTable := self newTable.
	filteringTable := self newTable.
	
	addSortingButton := self newButton
		label: 'Add Sorting Criterium';
		yourself.
		
	addFilteringButton := self newButton 
		label: 'Add Filtering Criterium';
		yourself.
]

{ #category : #accessing }
MRRulesPagePresenter >> rulesTable [
	^ rulesTable
]

{ #category : #accessing }
MRRulesPagePresenter >> rulesTable: anObject [
	rulesTable := anObject
]

{ #category : #accessing }
MRRulesPagePresenter >> sortingTable [
	^ sortingTable
]

{ #category : #accessing }
MRRulesPagePresenter >> sortingTable: anObject [
	sortingTable := anObject
]
