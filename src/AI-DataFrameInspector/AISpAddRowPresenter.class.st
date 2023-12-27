"
Class for handling the window which allows users to add rows.
It provides a user friendly way to add rows to DataFrames.
This window has these fields:
- **Position** : The position at which the new row should be added.
- **Row Name** : The row name of the new row to be added.
- **New Row** : The user can type the new row by adding the necessary items under each column.
- **Add button** : Adds the row to the DataFrame. 
- **Reset button** : Clears the items entered under each column of the new row. 
After entering each item under the specific column, the 'enter' key must be hit.
"
Class {
	#name : 'AISpAddRowPresenter',
	#superclass : 'AISpDataFramePresenter',
	#instVars : [
		'sortType',
		'columnName',
		'emptyRow',
		'resetButton',
		'newRowName',
		'newRow',
		'oneRowPresenter',
		'block',
		'rowInputTable',
		'newRowInputTable',
		'positionInput',
		'addButton',
		'tablePresenter',
		'applyButton',
		'cancelButton',
		'dataRows'
	],
	#category : 'AI-DataFrameInspector-sub presenters',
	#package : 'AI-DataFrameInspector',
	#tag : 'sub presenters'
}

{ #category : 'instance creation' }
AISpAddRowPresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : 'adding' }
AISpAddRowPresenter >> addButtonAction [

	newRow name: newRowName text.
	dataFrame addRow: newRow atPosition: positionInput number.
	self window close
]

{ #category : 'initialization' }
AISpAddRowPresenter >> connectPresenters [

	addButton action: [ self addButtonAction ].
	resetButton action: [ self resetButtonAction ]
]

{ #category : 'layout' }
AISpAddRowPresenter >> defaultLayout [

	| topLayout bottomLayout |
	topLayout := SpBoxLayout newLeftToRight
		             spacing: 70;
		             add: (SpGridLayout new
				              add: 'Position' at: 1 @ 1;
				              add: positionInput at: 2 @ 1;
				              yourself);
		             add: (SpGridLayout new
				              add: 'Row Name' at: 1 @ 1;
				              add: newRowName at: 2 @ 1;
				              yourself);
		             yourself.

	bottomLayout := SpBoxLayout newLeftToRight
		                spacing: 5;
		                add: addButton width: 65;
		                add: resetButton width: 65;
		                yourself.

	^ SpBoxLayout newTopToBottom
		  spacing: 15;
		  add: topLayout height: 40;
		  add: rowInputTable height: 70;
		  add: bottomLayout height: 30;
		  yourself
]

{ #category : 'initialization' }
AISpAddRowPresenter >> initializeAddResetButtons [

	addButton := self newButton
		             label: 'Add';
		             icon: (self iconNamed: #smallAdd).
	resetButton := self newButton
		               label: 'Reset';
		               icon: (self iconNamed: #refreshIcon)
]

{ #category : 'initialization' }
AISpAddRowPresenter >> initializeNewRowInputTable [

	emptyRow := dataFrame rowsFrom: 1 to: 1.
	1 to: emptyRow numberOfColumns do: [ :columnIndex |
		1 to: emptyRow numberOfRows do: [ :rowIndex |
		emptyRow at: rowIndex at: columnIndex put: '' ] ].
	newRow := DataSeries
		          withKeys: dataFrame columnNames
		          values: (emptyRow at: 1) asArray.
	newRowInputTable := self newTable.
	dataFrame columnNames doWithIndex: [ :headerName :columnIndex |
		| column |
		column := SpStringTableColumn
			          title: headerName
			          evaluated: [ :rowWithName |
			          (rowWithName at: columnIndex + 1) asString ].
		column beEditable.
		column onAcceptEdition: [ :row :newValue |
			newRow at: headerName put: newValue ].
		newRowInputTable addColumn: column ].
	newRowInputTable beResizable.
	newRowInputTable items: emptyRow asArrayOfRowsWithName
]

{ #category : 'as yet unclassified' }
AISpAddRowPresenter >> initializeNewRowName [

	newRowName := self newTextInput
		              placeholder: 'row name';
		              text: '';
		              yourself
]

{ #category : 'initialization' }
AISpAddRowPresenter >> initializePositionInput [

	positionInput := self newNumberInput
		                 number: dataFrame numberOfRows + 1;
		                 beInteger;
		                 yourself
]

{ #category : 'initialization' }
AISpAddRowPresenter >> initializePresenters [

	self initializeNewRowName.
	self initializeRowInputTable.
	self initializePositionInput.
	self initializeAddResetButtons
]

{ #category : 'as yet unclassified' }
AISpAddRowPresenter >> initializeRowInputTable [

	emptyRow := dataFrame rowsFrom: 1 to: 1.
	1 to: emptyRow numberOfColumns do: [ :columnIndex |
		1 to: emptyRow numberOfRows do: [ :rowIndex |
		emptyRow at: rowIndex at: columnIndex put: '' ] ].
	newRow := DataSeries
		          withKeys: dataFrame columnNames
		          values: (emptyRow at: 1) asArray.
	rowInputTable := self newTable.
	dataFrame columnNames doWithIndex: [ :headerName :columnIndex |
		| column |
		column := SpStringTableColumn
			          title: headerName
			          evaluated: [ :rowWithName |
			          (rowWithName at: columnIndex + 1) asString ].
		column beEditable.
		column onAcceptEdition: [ :row :newValue |
			newRow at: headerName put: newValue ].
		rowInputTable addColumn: column ].
	rowInputTable beResizable.
	rowInputTable items: emptyRow asArrayOfRowsWithName
]

{ #category : 'initialization' }
AISpAddRowPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: 500 @ 250;
		title: 'Add Row';
		whenClosedDo: [
			newRowName text: ''.
			positionInput number: dataFrame numberOfRows + 1 ]
]

{ #category : 'initialization' }
AISpAddRowPresenter >> resetButtonAction [

	self initializeNewRowInputTable.
	self layout replace: rowInputTable with: newRowInputTable.
	rowInputTable := newRowInputTable
]
