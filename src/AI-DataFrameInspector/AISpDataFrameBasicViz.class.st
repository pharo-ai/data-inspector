Class {
	#name : #AISpDataFrameBasicViz,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'dataFrame',
		'chart',
		'plot',
		'group',
		'numberOfBins'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #'instance creation' }
AISpDataFrameBasicViz class >> on: aDataFrame [

	^ self basicNew
		dataFrame: aDataFrame;
		initialize;
		yourself.
]

{ #category : #'instance creation' }
AISpDataFrameBasicViz class >> openOn: aDataFrame [

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
AISpDataFrameBasicViz >> allColumnValues [
	" Private - Answer a <Collection> of numeric column values in the receiver's data frame "

	^ self numericColumnNames collect: [ : colName |
		(dataFrame column: colName) asArray collect: #value ]
]

{ #category : #accessing }
AISpDataFrameBasicViz >> chart [

	^ chart
]

{ #category : #accessing }
AISpDataFrameBasicViz >> chart: anObject [

	chart := anObject
]

{ #category : #accessing }
AISpDataFrameBasicViz >> columnNames [ 

	^ self dataFrame columnNames
]

{ #category : #accessing }
AISpDataFrameBasicViz >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
AISpDataFrameBasicViz >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #initialization }
AISpDataFrameBasicViz >> defaultNumberOfBins [

	^ 6
]

{ #category : #accessing }
AISpDataFrameBasicViz >> group [

	^ group
]

{ #category : #accessing }
AISpDataFrameBasicViz >> group: anObject [

	group := anObject
]

{ #category : #initialization }
AISpDataFrameBasicViz >> initializePresenters [ 

	self refresh.
]

{ #category : #initialization }
AISpDataFrameBasicViz >> numberOfBins [

	^ numberOfBins
		ifNil: [ numberOfBins := self defaultNumberOfBins. ]
]

{ #category : #initialization }
AISpDataFrameBasicViz >> numericColumnNames [

	^ self columnNames select: [ : colName | (dataFrame column: colName) isNumerical ]
]

{ #category : #accessing }
AISpDataFrameBasicViz >> plot [

	^ plot
]

{ #category : #accessing }
AISpDataFrameBasicViz >> plot: anObject [

	plot := anObject
]

{ #category : #initialization }
AISpDataFrameBasicViz >> selectedColumnValues [

	^ (dataFrame column: 'sepal length (cm)') asArray collect: #value
]

{ #category : #initialization }
AISpDataFrameBasicViz >> setModelBeforeInitialization: aDomainObject [

	dataFrame := aDomainObject.
	chart := RSChart new.
	group := RSGroup new.
]

{ #category : #initialization }
AISpDataFrameBasicViz >> visualizeAllHistograms: aCanvas [

	| shapes |

	chart container: aCanvas.
	shapes := self allColumnValues collect: [ : columnValues | | g c |
		g := RSGroup new.
		c := RSChart new.
		c container: g.
		plot := RSHistogramPlot new x: columnValues; bins: self numberOfBins.
		c addPlot: plot.
		c addDecoration: RSVerticalTick new.
		c addDecoration: RSHorizontalTick new.
		c title: self numberOfBins. 
		c build.
		g asShapeFor: self numberOfBins ].
	aCanvas addAll: shapes.
	RSHorizontalLineLayout new
		gapSize: 4;
		on: shapes.
	aCanvas when: RSExtentChangedEvent do: [ 
		aCanvas camera zoomToFit: aCanvas extent.
		aCanvas signalUpdate ].

]

{ #category : #initialization }
AISpDataFrameBasicViz >> visualizeHistogram: aView [
	" Private - For single selection, do not delete yet "

	chart container: aView.
	plot := RSHistogramPlot new.
	plot x: self selectedColumnValues.

	aView when: RSExtentChangedEvent do: [ 
		aView camera zoomToFit: aView extent.
		aView signalUpdate ].

	chart 
		addPlot: plot;
		addDecoration: RSVerticalTick new;
		addDecoration: RSHorizontalTick new;
		build.
]
