Class {
	#name : #AISpSortTablePresenter,
	#superclass : #AISpDataFramePresenter,
	#instVars : [
		'sortType',
		'columnName',
		'block',
		'addButton',
		'testButton',
		'tablePresenter',
		'applyButton',
		'cancelButton',
		'dataRows',
		'newRow'
	],
	#category : #'AI-DataFrameInspector-sub presenters'
}

{ #category : #'instance creation' }
AISpSortTablePresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : #initialization }
AISpSortTablePresenter >> connectPresenters [

	addButton action: [
		newRow := Dictionary new.
		newRow at: 'columnName' put: columnName selectedItem.
		newRow at: 'sortType' put: sortType selectedItem.
		newRow at: 'sortBlock' put: block text.
		Transcript show: block text.

		"Add the new row to the dataRows collection"
		dataRows add: newRow.

		"Update the table"

		tablePresenter items: dataRows ].
	applyButton action: [
		self sortButtonAction.
		self window close ].
	cancelButton action: [ self window close ].
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

{ #category : #layout }
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
		                add: applyButton width: 50;
		                add: cancelButton width: 50;
		                yourself.

	^ SpBoxLayout newTopToBottom
		  spacing: 5;
		  add: topLayout height: 20;
		  "Make sure to set an appropriate height for block"add:
			  tablePresenter;
		  add: bottomLayout height: 30;
		  yourself
]

{ #category : #initialization }
AISpSortTablePresenter >> initializePresenters [

	dataRows := OrderedCollection new.
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
		                  yourself.
	addButton := self newToolbarButton
		             label: 'Add';
		             icon: (self iconNamed: #smallAdd);
		             yourself.
	columnName := SpDropListPresenter new items: dataFrame columnNames.
	block := SpTextInputFieldPresenter new
		         text: '[ :a :b | a <= b ]';
		         beNotEditable.
	sortType := SpDropListPresenter new items:
		            #( ascending descending other ).
	applyButton := SpButtonPresenter new label: 'sort'.
	cancelButton := SpButtonPresenter new label: 'cancel'
]

{ #category : #initialization }
AISpSortTablePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: 500 @ 300;
		toolbar: (self newToolbar
				 add: addButton;
				 yourself)
]

{ #category : #sorting }
AISpSortTablePresenter >> sortButtonAction [

	| currentRow |
	currentRow := Dictionary new.
	(1 to: dataRows size) reverseDo: [ :rowNumber |
		currentRow := dataRows at: rowNumber.
		dataFrame
			sortBy: (currentRow at: 'columnName')
			using: (BlockClosure readFromString: (currentRow at: 'sortBlock')) ]
]
