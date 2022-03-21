"
AISpDataFrameInspector openOn: AIDatasets loadIris.
AISpDataFrameInspector openOn: AIDatasets loadWine.
"
Class {
	#name : #AISpDataFrameDescriberPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'dataFrame',
		'evaluatorPane',
		'selectedItems',
		'additionalInfoPane',
		'dataFramePresenter',
		'summaryPresenter'
	],
	#classVars : [
		'MaxRows'
	],
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #accessing }
AISpDataFrameDescriberPresenter class >> maxRows [
	" Answer the <Number> of rows to visualize in the receiver "
	
	^ MaxRows
		ifNil: [ MaxRows := 1000 ]
]

{ #category : #accessing }
AISpDataFrameDescriberPresenter class >> maxRows: anInteger [
	" Set the maximum <Number> of rows to visualize in the receiver "
	
	MaxRows := anInteger
]

{ #category : #'instance creation' }
AISpDataFrameDescriberPresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> columnNames [ 

	^ dataFrame columnNames
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> contextMenu [

	^ self contextMenuActions asMenuPresenter
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> contextMenuActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (AISpDataFrameCopyRowValuesCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowValuesWithLabelsCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowSelectionsCommand forSpecContext: self);
		register: (AISpDataFrameInspectCommand forSpecContext: self);		
		yourself
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> contextMenuKeyBindings [

	^ self contextMenuActions asKMCategory
]

{ #category : #accessing }
AISpDataFrameDescriberPresenter >> dataFramePresenter [

	^ dataFramePresenter
]

{ #category : #layout }
AISpDataFrameDescriberPresenter >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		add: dataFramePresenter;
		add: (SpPanedLayout newLeftToRight
				positionOfSlider: 60 percent;
				add: summaryPresenter;
				add: (SpPanedLayout newTopToBottom
					positionOfSlider: 35 percent;
					add: additionalInfoPane;			
					add: evaluatorPane;
					yourself);
				yourself);
		yourself.

]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initialize [

	selectedItems := Set new.
	super initialize
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializeAdditionalInfoPresenter [

	additionalInfoPane := self instantiate: AISpDataFrameBasicInfoPresenter on: dataFrame.
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializeDataFramePresenter [

	dataFramePresenter := self newTable.
	dataFramePresenter
		enableSearch;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings.
	
	dataFramePresenter addColumn: self newCheckBoxColumn.
	
	self columnNames doWithIndex: [ : columnName : idx |
		dataFramePresenter addColumn: (
			SpStringTableColumn new
				title: columnName; 
				beSortable;
				evaluated: [ :each | each atIndex: idx ])].
	
	dataFramePresenter items: dataFrame.

]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializeEvaluatorPresenter [

	evaluatorPane := self instantiate: AISpDataFrameEvaluatorPresenter on: dataFrame.
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializePresenters [

	self initializeDataFramePresenter.
	self initializeEvaluatorPresenter.
	self initializeAdditionalInfoPresenter.
	self initializeSummaryPresenter.
	
	self focusOrder add: evaluatorPane

]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializeSummaryPresenter [

	summaryPresenter := self instantiate: AISpDataFrameSummaryPresenter on: dataFrame
]

{ #category : #initialization }
AISpDataFrameDescriberPresenter >> initializeWindow: aWindow [

	aWindow
		extent: 1200 @ 700;
		centered;
		title: 'DataFrame Inspector' translated;
		aboutText: 'About DataFrame'
]

{ #category : #'private building' }
AISpDataFrameDescriberPresenter >> newCheckBoxColumn [
	" Private - Answer a check box column to select specific rows in the receiver "

	^ (SpCheckBoxTableColumn
			evaluated: [ :branch | self selectedItems includes: branch ])
			onActivation: [ :branch | self selectedItems add: branch ];
			onDeactivation: [ :branch | self selectedItems remove: branch ];
			width: 20 * self currentWorld displayScaleFactor;
			yourself
]

{ #category : #accessing }
AISpDataFrameDescriberPresenter >> selectedItems [

	^ selectedItems
]

{ #category : #'accessing - model' }
AISpDataFrameDescriberPresenter >> setModelBeforeInitialization: aModel [

	dataFrame := aModel
]
