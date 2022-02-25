"
AISpDataFrameInspector openOn: AIDatasets loadIris.
AISpDataFrameInspector openOn: AIDatasets loadWine.
"
Class {
	#name : #AISpDataFrameInspector,
	#superclass : #StInspection,
	#instVars : [
		'dataFrame',
		'evaluatorPane',
		'inspectorPane',
		'selectedItems',
		'additionalInfoPane',
		'dataFramePresenter',
		'summaryPresenter'
	],
	#classVars : [
		'MaxRows'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #layout }
AISpDataFrameInspector class >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		add: #dataFramePresenter;
		add: (SpPanedLayout newLeftToRight
				add: #evaluatorPane;
				add: (SpPanedLayout newTopToBottom
					add: #summaryPresenter;
					add: #additionalInfoPane;				
					yourself);
				yourself);
		yourself.

]

{ #category : #examples }
AISpDataFrameInspector class >> example01 [
	<example>
	
	self openOn: AIDatasets loadIris.
]

{ #category : #examples }
AISpDataFrameInspector class >> example02 [
	<example>
	
	self openOn: AIDatasets loadWine.
]

{ #category : #accessing }
AISpDataFrameInspector class >> maxRows [
	" Answer the <Number> of rows to visualize in the receiver "
	
	^ MaxRows
		ifNil: [ MaxRows := 100 ]
]

{ #category : #accessing }
AISpDataFrameInspector class >> maxRows: anInteger [
	" Set the maximum <Number> of rows to visualize in the receiver "
	
	MaxRows := anInteger
]

{ #category : #'instance creation' }
AISpDataFrameInspector class >> on: aDataFrame [

	^ self basicNew
		dataFrame: aDataFrame;
		initialize;
		yourself.
]

{ #category : #'instance creation' }
AISpDataFrameInspector class >> openOn: aDataFrame [

	^ (self on: aDataFrame) 
		openWithSpec;
		withWindowDo: [ :w | 
          w
				extent: 1200 @ 700;
				centered;
            title: 'DataFrame Inspector' translated;
            aboutText: 'About DataFrame' ]
]

{ #category : #initialization }
AISpDataFrameInspector >> columnNames [ 

	^ self dataFrame columnNames
]

{ #category : #initialization }
AISpDataFrameInspector >> contextMenu [

	^ self contextMenuActions asMenuPresenter
]

{ #category : #initialization }
AISpDataFrameInspector >> contextMenuActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (AISpDataFrameCopyRowValuesCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowValuesWithLabelsCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowSelectionsCommand forSpecContext: self);
		register: (AISpDataFrameInspectCommand forSpecContext: self);		
		yourself
]

{ #category : #initialization }
AISpDataFrameInspector >> contextMenuKeyBindings [

	^ self contextMenuActions asKMCategory
]

{ #category : #'private building' }
AISpDataFrameInspector >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
AISpDataFrameInspector >> dataFrame: anObject [

	dataFrame := anObject.
]

{ #category : #accessing }
AISpDataFrameInspector >> dataFramePresenter [

	^ dataFramePresenter
]

{ #category : #accessing }
AISpDataFrameInspector >> dataFramePresenter: anObject [

	dataFramePresenter := anObject
]

{ #category : #accessing }
AISpDataFrameInspector >> evaluatorPane [

	^ evaluatorPane
]

{ #category : #accessing }
AISpDataFrameInspector >> evaluatorPane: anObject [

	evaluatorPane := anObject
]

{ #category : #initialization }
AISpDataFrameInspector >> initialize [

	selectedItems := Set new.
	super initialize
]

{ #category : #initialization }
AISpDataFrameInspector >> initializeAdditionalInfoPresenter [

	additionalInfoPane := self instantiate: AISpDataFrameBasicPresenter on: self dataFrame.
]

{ #category : #initialization }
AISpDataFrameInspector >> initializeDataFramePresenter [

	dataFramePresenter := self newTable
		enableSearch;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		addColumn: self newCheckBoxColumn.
	self columnNames doWithIndex: [ : columnName : idx |
		dataFramePresenter addColumn: (
			SpStringTableColumn new
				title: columnName; 
				beSortable;
				evaluated: [ :each | each atIndex: idx ])].
	dataFramePresenter items: self dataFrame.

]

{ #category : #initialization }
AISpDataFrameInspector >> initializeEvaluatorPresenter [

	evaluatorPane := self instantiate: AISpDataFrameEvaluator on: self dataFrame.
]

{ #category : #initialization }
AISpDataFrameInspector >> initializePresenters [

	self initializeDataFramePresenter.
	self initializeEvaluatorPresenter.
	self initializeAdditionalInfoPresenter.
	self initializeSummaryPresenter.

]

{ #category : #initialization }
AISpDataFrameInspector >> initializeSummaryPresenter [

	summaryPresenter := self instantiate: AISpDataFrameSummaryPresenter on: self dataFrame
]

{ #category : #accessing }
AISpDataFrameInspector >> inspectorPane [

	^ inspectorPane
]

{ #category : #accessing }
AISpDataFrameInspector >> inspectorPane: anObject [

	inspectorPane := anObject
]

{ #category : #'private building' }
AISpDataFrameInspector >> newCheckBoxColumn [
	" Private - Answer a check box column to select specific rows in the receiver "

	^ (SpCheckBoxTableColumn
			evaluated: [ :branch | self selectedItems includes: branch ])
			onActivation: [ :branch | self selectedItems add: branch ];
			onDeactivation: [ :branch | self selectedItems remove: branch ];
			width: 20 * self currentWorld displayScaleFactor;
			yourself
]

{ #category : #accessing }
AISpDataFrameInspector >> selectedItems [

	^ selectedItems
]

{ #category : #accessing }
AISpDataFrameInspector >> selectedItems: anObject [

	selectedItems := anObject
]

{ #category : #accessing }
AISpDataFrameInspector >> summaryPresenter [

	^ summaryPresenter
]

{ #category : #accessing }
AISpDataFrameInspector >> summaryPresenter: anObject [

	summaryPresenter := anObject
]
