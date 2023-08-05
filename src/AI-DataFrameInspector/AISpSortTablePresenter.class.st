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

{ #category : #adding }
AISpSortTablePresenter >> addButtonAction [

	newRow := Dictionary new.
	newRow at: 'columnName' put: columnName selectedItem.
	newRow at: 'sortType' put: sortType selectedItem.
	newRow at: 'sortBlock' put: block text.
	dataRows add: newRow.
	tablePresenter items: dataRows
]

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
AISpSortTablePresenter >> connectPresenters [

	addButton action: [ self addButtonAction ].
	applyButton action: [
		self sortButtonAction.
		self window close ].
	cancelButton action: [ self window close ].
	self changeSortType
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

{ #category : #initialization }
AISpSortTablePresenter >> initializeAddButton [

	addButton := self newToolbarButton
		             label: 'Add';
		             icon: (self iconNamed: #smallAdd);
		             yourself
]

{ #category : #initialization }
AISpSortTablePresenter >> initializeApplyCancelButtons [

	applyButton := self newButton
		               label: 'sort';
		               icon: (self iconNamed: #smallOk).
	cancelButton := self newButton
		                label: 'cancel';
		                icon: (self iconNamed: #smallCancel)
]

{ #category : #initialization }
AISpSortTablePresenter >> initializePresenters [

	dataRows := OrderedCollection new.
	self initializeTablePresenter.
	self initializeAddButton.
	self initializeSelectionFields.
	self initializeApplyCancelButtons
]

{ #category : #initialization }
AISpSortTablePresenter >> initializeSelectionFields [

	columnName := self newDropList items: dataFrame columnNames.
	block := self newTextInput
		         text: '[ :a :b | a <= b ]';
		         beNotEditable.
	sortType := self newDropList items: #( ascending descending
	               other )
]

{ #category : #initialization }
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
