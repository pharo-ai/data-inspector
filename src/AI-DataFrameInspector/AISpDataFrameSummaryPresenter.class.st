"
I am a presenter that shows the summary of the statistics of a given DataFrame.
"
Class {
	#name : #AISpDataFrameSummaryPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'dataFrameSummaryPresenter'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #layout }
AISpDataFrameSummaryPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: dataFrameSummaryPresenter;
		yourself
]

{ #category : #initialization }
AISpDataFrameSummaryPresenter >> initializePresenters [

	dataFrameSummaryPresenter := self newTable.
	dataFrameSummaryPresenter
		showColumnHeaders;
		beMultipleSelection;
		items: self summaryStatsLabels;
		addColumn: (SpStringTableColumn title: 'Statistic' evaluated: [ :each | each ]).

	self columnNames do: [ :columnName | 
		dataFrameSummaryPresenter addColumn: (SpStringTableColumn new
			title: columnName;
			evaluated: [ :aString | self summaryStatsValueFor: aString in: columnName ];
			beSortable) ]
]

{ #category : #defaults }
AISpDataFrameSummaryPresenter >> performCalculation: aString forDataSeries: colDataSeries [

	| calculation |
	calculation := colDataSeries perform: (self summaryStatsAt: aString).

	^ self roundResult: calculation
]

{ #category : #defaults }
AISpDataFrameSummaryPresenter >> roundResult: aNumber [

	"We choose to show only 3 decimal places according to the European Association of Science Editors guidelines include the useful rule of thumb: “numbers should be given in (sic) 2–3 effective digits”"

	^ aNumber printShowingDecimalPlaces: 2
]

{ #category : #calculating }
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

{ #category : #calculating }
AISpDataFrameSummaryPresenter >> summaryStatsAt: aString [

	^ self summaryStats at: aString
]

{ #category : #calculating }
AISpDataFrameSummaryPresenter >> summaryStatsLabels [

	^ self summaryStats keys
]

{ #category : #calculating }
AISpDataFrameSummaryPresenter >> summaryStatsValueFor: aString in: col [

	| colDataSeries |
	colDataSeries := self dataFrame column: col.
	
	^ colDataSeries isNumerical
		ifTrue: [ self performCalculation: aString forDataSeries: colDataSeries ]
		ifFalse: [ 'NaN' ]
]
