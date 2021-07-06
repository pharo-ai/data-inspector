Class {
	#name : #AISpDataFrameInspector,
	#superclass : #StInspection,
	#instVars : [
		'dataFrame',
		'evaluatorPane',
		'inspectorPane',
		'dfPane',
		'summaryPane',
		'selectedItems',
		'basicInfoPane'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameInspector class >> defaultSpec [
	^ SpBoxLayout newTopToBottom
		add: #dfPane
			expand: true
			fill: true
			padding: 2;
		add:
			(SpBoxLayout newLeftToRight
				add: #evaluatorPane;
				add: #basicInfoPane withConstraints: [ :constraints | 
						constraints width: self buttonWidth * 2; padding: 2 ];
				add: #summaryPane;
				yourself)
			expand: true
			fill: true
			padding: 2;				
		yourself
]

{ #category : #'instance creation' }
AISpDataFrameInspector class >> on: aDataFrame [

	^ self basicNew
		dataFrame: aDataFrame;
		initialize;
		yourself.
]

{ #category : #accessing }
AISpDataFrameInspector >> basicInfoPane [

	^ basicInfoPane
]

{ #category : #accessing }
AISpDataFrameInspector >> basicInfoPane: anObject [

	basicInfoPane := anObject
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
AISpDataFrameInspector >> dfPane [

	^ dfPane
]

{ #category : #accessing }
AISpDataFrameInspector >> dfPane: anObject [

	dfPane := anObject
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
AISpDataFrameInspector >> initializeDataFramePane [

	dfPane := self newTable
		enableSearch;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		addColumn:
			((SpCheckBoxTableColumn
				evaluated: [ :branch | self selectedItems includes: branch ])
				onActivation: [ :branch | self selectedItems add: branch ];
				onDeactivation: [ :branch | self selectedItems remove: branch ];
				width: 20 * self currentWorld displayScaleFactor;
				yourself).
	self columnNames doWithIndex: [ : columnName : idx |
		dfPane addColumn: (
			SpStringTableColumn new
				title: columnName; 
				beSortable;
				evaluated: [ :each | each atIndex: idx ])].
	dfPane items: self dataFrame.

]

{ #category : #initialization }
AISpDataFrameInspector >> initializeEvaluatorPane [

	application := StPharoApplication new.
	evaluatorPane := self instantiate: SpCodePresenter.
	evaluatorPane 
		withSyntaxHighlight;
		withLineNumbers;
		beForObject: self dataFrame.
]

{ #category : #initialization }
AISpDataFrameInspector >> initializePresenters [

	self initializeDataFramePane.
	self initializeEvaluatorPane.
	self initializeSummaryBasicPane.
	self initializeSummaryPane.

]

{ #category : #initialization }
AISpDataFrameInspector >> initializeSummaryBasicPane [
	" Private - The summary pane is a table to display receiver summary statistics "

	basicInfoPane := self newTable
		showColumnHeaders;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		items: self summaryDescriptionsLabels;
		addColumn:  (SpStringTableColumn 
			title: 'Type' 
			evaluated: [ :each | each ]);
		addColumn: (
			SpStringTableColumn new
				title: 'Value';
				evaluated: [ : aString | self summaryValueFor: aString ];
				beSortable).

]

{ #category : #initialization }
AISpDataFrameInspector >> initializeSummaryPane [
	" Private - The summary pane is a table to display receiver summary statistics "

	summaryPane := self newTable
		showColumnHeaders;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		items: self summaryStatsLabels;
		addColumn:  (SpStringTableColumn 
			title: 'Statistic' 
			evaluated: [ :each | each ]);
		yourself.
	self columnNames do: [ : columnName |
		summaryPane addColumn: (
			SpStringTableColumn new
				title: columnName;
				evaluated: [ : aString | self summaryStatsValueFor: aString in: columnName ];
				beSortable) ].

]

{ #category : #accessing }
AISpDataFrameInspector >> inspectorPane [

	^ inspectorPane
]

{ #category : #accessing }
AISpDataFrameInspector >> inspectorPane: anObject [

	inspectorPane := anObject
]

{ #category : #accessing }
AISpDataFrameInspector >> selectedItems [

	^ selectedItems
]

{ #category : #accessing }
AISpDataFrameInspector >> selectedItems: anObject [

	selectedItems := anObject
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryDescriptions [

	^ Dictionary new
		at: 'Dimensions' 		put: #dimensions;
		at: 'Has nil'			put: #hasNil;
		at: 'Has categorical'	put: #hasCategorical;
		yourself
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryDescriptionsLabels [

	^ self summaryDescriptions keys asSortedCollection 
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryDescriptorsAt: aString [

	^ self summaryDescriptions at: aString
]

{ #category : #accessing }
AISpDataFrameInspector >> summaryPane [

	^ summaryPane
]

{ #category : #accessing }
AISpDataFrameInspector >> summaryPane: anObject [

	summaryPane := anObject
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryStats [

	^ Dictionary new
		at: 'Average' 				put: #average;
		at: 'Mode' 					put: #mode;
		at: 'Median'					put: #median;
		at: 'Variance'				put: #variance;
		at: 'Standard deviation'	put: #stdev;
		at: 'Minimum'				put: #min;
		at: 'Maximum'				put: #max;
		at: '1st Quartile'			put: #firstQuartile;
		at: '3rd Quartile'			put: #thirdQuartile;
		yourself
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryStatsAt: aString [

	^ self summaryStats at: aString
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryStatsLabels [

	^ self summaryStats keys "asSortedCollection" 
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryStatsValueFor: aString in: col [

	| colDataSeries |
	
	colDataSeries := self dataFrame column: col.
	^ colDataSeries isNumerical
		ifTrue: [ colDataSeries perform: (self summaryStatsAt: aString) ]
		ifFalse: [ 0  ]
]

{ #category : #'private building' }
AISpDataFrameInspector >> summaryValueFor: aString [

	^ StObjectPrinter asNonTruncatedTextFrom: 
		(self dataFrame perform: (self summaryDescriptorsAt: aString))
]
