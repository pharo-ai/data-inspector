"
Class for handling the Dataframe in **interactive** mode.
These are some of the key features of the interactive mode:
- **Edit** : DataFrames can be edited and the changes will be saved to the original DataFrame.
- **Search** : Only those rows of the DataFrame will be visible which have the element in the search bar.
- **Sort** : A sorting window opens where the users can select from drop-down lists the column by which they want the DataFrame to be sorted and the sorting block they would like to use.
- Column widths can be **resized** by dragging the column borders.
"
Class {
	#name : #AISpDataFramePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'dataFrame',
		'dataFramePresenter',
		'dataFrameColumnsEditable',
		'setRowNames',
		'editButton',
		'searchBar',
		'sortButton',
		'newdataFramePresenter',
		'sortPresenter',
		'windowPresenter'
	],
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpDataFramePresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : #initialization }
AISpDataFramePresenter >> connectPresenters [

	editButton action: [ self editButtonAction ].
	searchBar whenTextChangedDo: [ self searchBarAction ].
	sortButton action: [ self sortButtonAction ]
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

{ #category : #editing }
AISpDataFramePresenter >> editButtonAction [

	dataFrameColumnsEditable := dataFrameColumnsEditable not.
	dataFrameColumnsEditable
		ifTrue: [
			editButton
				label: 'read';
				icon: (self iconNamed: #book) ]
		ifFalse: [
			editButton
				label: 'edit';
				icon: (self iconNamed: #editIcon) ].
	self editDataFrame.
	self layout replace: dataFramePresenter with: newdataFramePresenter.
	dataFramePresenter := newdataFramePresenter
]

{ #category : #editing }
AISpDataFramePresenter >> editDataFrame [

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
					((dataFrame at: rowInd at: idx) isKindOf: Boolean) ifTrue: [
						newValue = 'true' ifTrue: [ putVal := true ].
						newValue = 'false' ifTrue: [ putVal := false ] ].

					dataFrame at: rowInd at: idx put: putVal ].
				newdataFramePresenter addColumn: column ] ].
	newdataFramePresenter beResizable.

	newdataFramePresenter items: dataFrame asArrayOfRowsWithName
]

{ #category : #searching }
AISpDataFramePresenter >> filterTableWithSearchQuery: newValue [

	| filteredRows |
	filteredRows := dataFrame select: [ :row |
		                row anySatisfy: [ :value |
			                value asString
				                includesSubstring: newValue asString
				                at: 1 ] ].
		
	newdataFramePresenter items: filteredRows asArrayOfRowsWithName
]

{ #category : #initialization }
AISpDataFramePresenter >> initialize [

	dataFrameColumnsEditable ifNil: [ dataFrameColumnsEditable := false ].
	setRowNames ifNil: [ setRowNames := false ].
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
		setRowNames := true.
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
AISpDataFramePresenter >> initializeNewDataFramePresenter [

	newdataFramePresenter := self newTable.

	newdataFramePresenter addColumn: (SpIndexTableColumn new
			 title: '#';
			 sortFunction: #yourself ascending;
			 beNotExpandable;
			 yourself).
	setRowNames ifTrue: [
		newdataFramePresenter addColumn: (SpStringTableColumn
				 title: ''
				 evaluated: [ :rowWithName | rowWithName at: 1 ]) ].

	dataFrame columnNames doWithIndex: [ :headerName :columnIndex |
		newdataFramePresenter addColumn: (SpStringTableColumn
				 title: headerName
				 evaluated: [ :rowWithName | rowWithName at: columnIndex + 1 ]) ].
	newdataFramePresenter beResizable.

	newdataFramePresenter items: dataFrame asArrayOfRowsWithName
]

{ #category : #initialization }
AISpDataFramePresenter >> initializePresenters [

	self initializeDataFramePresenter.
	self initializeToolbarPresenter.
	self initializeSortPresenter
]

{ #category : #initialization }
AISpDataFramePresenter >> initializeSortPresenter [

	windowPresenter := SpWindowPresenter new.
	sortPresenter := self
		                 instantiate: AISpSortTablePresenter
		                 on: dataFrame
]

{ #category : #initialization }
AISpDataFramePresenter >> initializeToolbarPresenter [

	editButton := self newButton
		              label: 'Edit';
		              icon: (self iconNamed: #editIcon);
		              yourself.
	searchBar := self newTextInput placeholder: '          search'.
	sortButton := self newButton
		              label: 'sort';
		              icon: (self iconNamed: #smallOpen);
		              yourself
]

{ #category : #searching }
AISpDataFramePresenter >> searchBarAction [

	searchBar text
		ifEmpty: [
			self initializeDataFramePresenter.
			self layout replace: newdataFramePresenter with: dataFramePresenter ]
		ifNotEmpty: [ :text |
			newdataFramePresenter := dataFramePresenter.
			self filterTableWithSearchQuery: text.
			self layout replace: dataFramePresenter with: newdataFramePresenter ]
]

{ #category : #'accessing - model' }
AISpDataFramePresenter >> setModelBeforeInitialization: aModel [

	dataFrame := aModel
]

{ #category : #sorting }
AISpDataFramePresenter >> sortButtonAction [

	windowPresenter := sortPresenter open.
	windowPresenter whenClosedDo: [
		self initializeNewDataFramePresenter.
		self layout replace: dataFramePresenter with: newdataFramePresenter.
		dataFramePresenter := newdataFramePresenter ]
]
