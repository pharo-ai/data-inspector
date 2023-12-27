"
Class for handling the sort window.
It provides a user friendly way to sort DataFrames.
The sort window has three different fields:
- **Column Name** : A drop down list from which users can select the column name by which the DataFrame should be sorted.
- **Sort Type** : A drop down list having three options 'ascending', 'descending' and 'other', the user can define the way the DataFrame should be sorted by choosing one of these options.
- **Sorting Block** : This field is disabled if the user chooses 'ascending' or 'descending'. The user can write a custom sorting block in this field after selecting the 'other' option from the 'Sort Type' drop down list. 

**Chain sorting** is also possible using this window, simply click the 'Add' button and choose the next column name by which the DataFrame should be sorted if some of the values of the previous selected column are same.

Click on the **sort** button to sort the DataFrame based on the preferences selected or choose the **cancel** button to discard these preferences.
"
Class {
	#name : 'AISpSortTablePresenter',
	#superclass : 'AISpDataFramePresenter',
	#instVars : [
		'sortType',
		'columnName',
		'block',
		'addButton',
		'tablePresenter',
		'applyButton',
		'cancelButton',
		'dataRows',
		'newRow'
	],
	#category : 'AI-DataFrameInspector-sub presenters',
	#package : 'AI-DataFrameInspector',
	#tag : 'sub presenters'
}

{ #category : 'instance creation' }
AISpSortTablePresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : 'adding' }
AISpSortTablePresenter >> addButtonAction [

	newRow := Dictionary new.
	newRow at: 'columnName' put: columnName selectedItem.
	newRow at: 'sortType' put: sortType selectedItem.
	newRow at: 'sortBlock' put: block text.
	dataRows add: newRow.
	tablePresenter items: dataRows
]

{ #category : 'action' }
AISpSortTablePresenter >> applyButtonAction [

	| currentRow |
	currentRow := Dictionary new.
	(1 to: dataRows size) reverseDo: [ :rowNumber |
		currentRow := dataRows at: rowNumber.
		dataFrame
			sortBy: (currentRow at: 'columnName')
			using: (BlockClosure readFromString: (currentRow at: 'sortBlock')) ]
]

{ #category : 'action' }
AISpSortTablePresenter >> changeSortType [

	sortType whenSelectionChangedDo: [ :newSortType |
		newSortType selectedIndex = 1 ifTrue: [
			block text: '[ :a :b | a <= b ]'.
			block beNotEditable ].
		newSortType selectedIndex = 2 ifTrue: [
			block text: '[ :a :b | a >= b ]'.
			block beNotEditable ].
		newSortType selectedIndex = 3 ifTrue: [
			block text: ''.
			block beEditable ] ]
]

{ #category : 'initialization' }
AISpSortTablePresenter >> connectPresenters [

	addButton action: [ self addButtonAction ].
	applyButton action: [
		self applyButtonAction.
		self window close ].
	cancelButton action: [ self window close ].
	self changeSortType
]

{ #category : 'layout' }
AISpSortTablePresenter >> defaultLayout [

	| topLayout bottomLayout |
	topLayout := SpBoxLayout newLeftToRight
		             spacing: 5;
		             add: columnName width: 150;
		             add: sortType width: 100;
		             add: block width: 200;
		             yourself.

	bottomLayout := SpBoxLayout newLeftToRight
		                spacing: 5;
		                add: applyButton width: 65;
		                add: cancelButton width: 65;
		                yourself.

	^ SpBoxLayout newTopToBottom
		  spacing: 5;
		  add: topLayout height: 20;
		  add: tablePresenter;
		  add: bottomLayout height: 30;
		  yourself
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializeAddButton [

	addButton := self newToolbarButton
		             label: 'Add';
		             icon: (self iconNamed: #smallAdd);
		             yourself
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializeApplyCancelButtons [

	applyButton := self newButton
		               label: 'sort';
		               icon: (self iconNamed: #smallOk).
	cancelButton := self newButton
		                label: 'cancel';
		                icon: (self iconNamed: #smallCancel)
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializePresenters [

	dataRows := OrderedCollection new.
	self initializeTablePresenter.
	self initializeAddButton.
	self initializeSelectionFields.
	self initializeApplyCancelButtons
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializeSelectionFields [

	columnName := self newDropList items: dataFrame columnNames.
	block := self newTextInput
		         text: '[ :a :b | a <= b ]';
		         placeholder: '[ :a :b | a <= b ]';
		         beNotEditable.
	sortType := self newDropList items: #( ascending descending
	               other )
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializeTablePresenter [

	tablePresenter := self newTable
		                  addColumn: (SpStringTableColumn
				                   title: 'Column Name'
				                   evaluated: [ :row | row at: 'columnName' ]);
		                  addColumn: (SpStringTableColumn
				                   title: 'Sort Type'
				                   evaluated: [ :row | row at: 'sortType' ]);
		                  addColumn: (SpStringTableColumn
				                   title: 'Sort Block'
				                   evaluated: [ :row | row at: 'sortBlock' ]);
		                  yourself
]

{ #category : 'initialization' }
AISpSortTablePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: 500 @ 300;
		title: 'Sort Window';
		whenClosedDo: [
			dataRows := OrderedCollection new.
			tablePresenter items: dataRows ];
		toolbar: (self newToolbar
				 add: addButton;
				 yourself)
]
