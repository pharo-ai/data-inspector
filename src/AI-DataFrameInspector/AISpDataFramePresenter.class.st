Class {
	#name : #AISpDataFramePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'dataFrame',
		'dataFramePresenter',
		'dataFrameColumnsEditable',
		'editButton',
		'searchBar',
		'sortButton',
		'newdataFramePresenter',
		'sortPresenter'
	],
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpDataFramePresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : #initialization }
AISpDataFramePresenter >> connectPresenters [

	editButton action: [
		dataFrameColumnsEditable := dataFrameColumnsEditable not.
		dataFrameColumnsEditable
			ifTrue: [ editButton label: 'read-only' ]
			ifFalse: [ editButton label: 'edit' ].
		self updateDataFramePresenter.
		self layout replace: dataFramePresenter with: newdataFramePresenter.
		dataFramePresenter := newdataFramePresenter ].
	searchBar whenTextChangedDo: [
		searchBar text ifEmpty: [
			self initialize.
			self layout replace: dataFramePresenter with: dataFramePresenter ].
		searchBar text ifNotEmpty: [
			newdataFramePresenter := dataFramePresenter.
			self filterTableWithSearchQuery: searchBar text.
			self layout replace: dataFramePresenter with: newdataFramePresenter ] ].

	sortButton action: [
		sortPresenter open.
		 ].
]

{ #category : #layout }
AISpDataFramePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 5;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 5;
				   add: editButton width: 60;
				   add: sortButton width: 50;
				   add: searchBar width: 100;
				   yourself)
		  height: 20;
		  yourself;
		  add: dataFramePresenter;
		  yourself
]

{ #category : #'as yet unclassified' }
AISpDataFramePresenter >> filterTableWithSearchQuery: newValue [

	| filteredRows |
	"Filter the original DataFrame based on the search query (newValue)"
	filteredRows := dataFrame select: [ :row |
		                row anySatisfy: [ :value |
			                value asString
				                includesSubstring: newValue asString
				                caseSensitive: false ] ].

	"Update the table to display only the filtered rows"
	newdataFramePresenter items: filteredRows asArrayOfRowsWithName
]

{ #category : #initialization }
AISpDataFramePresenter >> initialize [

	dataFrameColumnsEditable ifNil: [ dataFrameColumnsEditable := false ].
	super initialize
]

{ #category : #initialization }
AISpDataFramePresenter >> initializeDataFramePresenter [

	dataFramePresenter := self newTable.

	dataFramePresenter addColumn: (SpIndexTableColumn new
			 title: '#';
			 sortFunction: #yourself ascending;
			 beNotExpandable;
			 yourself).
	dataFrame rowNames
	= (1 to: dataFrame numberOfRows) asOrderedCollection ifFalse: [
		dataFramePresenter addColumn: (SpStringTableColumn
				 title: ''
				 evaluated: [ :rowWithName | rowWithName at: 1 ]) ].

	dataFrame columnNames doWithIndex: [ :headerName :columnIndex |
		dataFramePresenter addColumn: (SpStringTableColumn
				 title: headerName
				 evaluated: [ :rowWithName | rowWithName at: columnIndex + 1 ]) ].
	dataFramePresenter beResizable.

	dataFramePresenter items: dataFrame asArrayOfRowsWithName
]

{ #category : #initialization }
AISpDataFramePresenter >> initializePresenters [

	self initializeDataFramePresenter.
	self initializeToolbarPresenter.
	self initializeSortPresenter
]

{ #category : #initialization }
AISpDataFramePresenter >> initializeSortPresenter [

	sortPresenter := self instantiate: AISpSortTablePresenter on: dataFrame
]

{ #category : #initialization }
AISpDataFramePresenter >> initializeToolbarPresenter [

	editButton := SpButtonPresenter new
		              label: 'Edit';
		              yourself.
	searchBar := SpTextInputFieldPresenter new placeholder:
		             '          search'.
	sortButton := SpButtonPresenter new
		              label: 'sort';
		              yourself
]

{ #category : #'as yet unclassified' }
AISpDataFramePresenter >> parentRefresh [
	self initializeDataFramePresenter.

	Transcript endEntry show: (dataFrame columnAt: 1).
	self layout refresh.
	"dataFramePresenter refresh"
]

{ #category : #'accessing - model' }
AISpDataFramePresenter >> setModelBeforeInitialization: aModel [

	dataFrame := aModel
]

{ #category : #'as yet unclassified' }
AISpDataFramePresenter >> updateDataFramePresenter [

	newdataFramePresenter := self newTable.

	newdataFramePresenter addColumn: (SpIndexTableColumn new
			 title: '#';
			 sortFunction: #yourself ascending;
			 beNotExpandable;
			 yourself).
	dataFrame rowNames
	= (1 to: dataFrame numberOfRows) asOrderedCollection ifFalse: [
		newdataFramePresenter addColumn: (SpStringTableColumn
				 title: ''
				 evaluated: [ :rowWithName | rowWithName at: 1 ]) ].
	dataFrameColumnsEditable
		ifFalse: [
			dataFrame columnNames doWithIndex: [ :columnName :idx |
				newdataFramePresenter addColumn: (SpStringTableColumn new
						 title: columnName;
						 beSortable;
						 evaluated: [ :selection |
							 selection dataSeriesElementAt: idx + 1 ]) ] ]
		ifTrue: [
			dataFrame columnNames doWithIndex: [ :columnName :idx |
				| column |
				column := SpStringTableColumn
					          title: columnName
					          evaluated: [ :rowWithName |
						          | originalValue |
						          originalValue := rowWithName at: idx + 1.
						          originalValue asString ].
				column beEditable.
				column onAcceptEdition: [ :row :newValue |
					| originalRowName rowInd putVal |
					putVal := newValue.
					originalRowName := row at: 1.
					rowInd := dataFrame indexOfRowNamed: originalRowName.
					(dataFrame at: rowInd at: idx) isNumber ifTrue: [
						putVal := newValue asNumber ].
					dataFrame at: rowInd at: idx put: putVal ].
				newdataFramePresenter addColumn: column ] ].
	newdataFramePresenter beResizable.

	newdataFramePresenter items: dataFrame asArrayOfRowsWithName
]
