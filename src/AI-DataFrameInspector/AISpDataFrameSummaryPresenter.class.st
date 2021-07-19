Class {
	#name : #AISpDataFrameSummaryPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'dataFramePresenter'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameSummaryPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		add: #dataFramePresenter;
		yourself.

]

{ #category : #accessing }
AISpDataFrameSummaryPresenter >> dataFramePresenter [

	^ dataFramePresenter
]

{ #category : #accessing }
AISpDataFrameSummaryPresenter >> dataFramePresenter: anObject [

	dataFramePresenter := anObject
]

{ #category : #initialization }
AISpDataFrameSummaryPresenter >> initializePresenter [ 
	" Private - The summary pane is a table to display receiver summary statistics "

	dataFramePresenter := self newTable
		showColumnHeaders;
"		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;"
		items: self summaryStatsLabels;
		addColumn:  (SpStringTableColumn 
			title: 'Statistic' 
			evaluated: [ :each | each ]);
		yourself.
	self columnNames do: [ : columnName |
		dataFramePresenter addColumn: (
			SpStringTableColumn new
				title: columnName;
				evaluated: [ : aString | self summaryStatsValueFor: aString in: columnName ];
				beSortable) ].

]

{ #category : #'private building' }
AISpDataFrameSummaryPresenter >> summaryStats [

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
AISpDataFrameSummaryPresenter >> summaryStatsAt: aString [

	^ self summaryStats at: aString
]

{ #category : #'private building' }
AISpDataFrameSummaryPresenter >> summaryStatsLabels [

	^ self summaryStats keys "asSortedCollection" 
]

{ #category : #'private building' }
AISpDataFrameSummaryPresenter >> summaryStatsValueFor: aString in: col [

	| colDataSeries |
	
	colDataSeries := self dataFrame column: col.
	^ colDataSeries isNumerical
		ifTrue: [ colDataSeries perform: (self summaryStatsAt: aString) ]
		ifFalse: [ 0  ]
]
