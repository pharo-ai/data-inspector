"
This Roassal >=3 presenter provides histogram for all numeric columns in the displayed data frame.

# Implementation Points

- Initialization happens in setModelBeforeInitialization:
- They key method for rendering is `AISpDataFrameBasicViz>>plotAllHistograms`

Internal Representation and Key Implementation Points.

    Instance Variables
	chart:		<RSChart>
	dataFrame:		<Object>
	group:		<Object>
	numberOfBins:		<Object>
	plot:		<Object>


    Implementation Points
"
Class {
	#name : #AISpDataFrameVisualizerPresenter,
	#superclass : #SpRoassalPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'numberOfBins'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #'instance creation' }
AISpDataFrameVisualizerPresenter class >> onsss: aDataFrame [

"	^ self basicNew
		dataFrame: aDataFrame;
		initialize;
		yourself."
]

{ #category : #'instance creation' }
AISpDataFrameVisualizerPresenter class >> openOn: aDataFrame [

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
AISpDataFrameVisualizerPresenter >> allColumnValues [
	" Private - Answer a <Collection> of numeric column values in the receiver's data frame "

	^ self numericColumnNames collect: [ : colName |
		(model column: colName) asArray collect: #value ]
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> allColumnValuesWithColumnName [

	" Private - Answer a <Collection> of <Association> with numeric column values in the receiver's data frame "

	^ self numericColumnNames collect: [ :colName | 
		  colName -> ((self model column: colName) asArray collect: #value) ]
]

{ #category : #accessing }
AISpDataFrameVisualizerPresenter >> columnNames [ 

	^ self dataFrame columnNames
]

{ #category : #'to review' }
AISpDataFrameVisualizerPresenter >> createCanvas [
	| canvas |
	canvas := RSCanvas new.
	canvas inspectorContext: RSEmptyContextInteraction new..
	self plotAllHistograms: canvas.
	^ canvas
]

{ #category : #accessing }
AISpDataFrameVisualizerPresenter >> dataFrame [

	^ model
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> defaultNumberOfBins [

	^ 6
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> initializePresenters [

	self plotAllHistograms: self canvas.
	self refresh
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> numberOfBins [

	^ numberOfBins
		ifNil: [ numberOfBins := self defaultNumberOfBins. ]
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> numericColumnNames [

	^ self columnNames select: [ : colName | (self model column: colName) isNumerical ]
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> plotAllHistograms: aCanvas [
	| shapes |
	shapes := self allColumnValuesWithColumnName collect: [ : columnAssoc | 
		self plotHistogram: columnAssoc ].
	aCanvas 
		addAll: shapes;
		addInteraction: RSCanvasController new.
	
	aCanvas when: RSExtentChangedEvent do: [ 
		RSFlowLayout new
			gapSize: 10;
			maxWidth: aCanvas extent x;
			on: shapes.
		aCanvas camera zoomToFit: aCanvas extent * 0.98.
		
		aCanvas signalUpdate ].

]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> plotHistogram: columnAssoc [
	" Answer a <RSComposite> "

	| container c columnValues plot vertical horizontal |

	columnValues := columnAssoc value.
	c := RSChart new.
	container := RSGroup new.
	c container: container.
	plot := [ RSHistogramPlot new x: columnValues; bins: self numberOfBins ]
	on: DomainError
	do: [ : ex | RSLinePlot new y: columnValues  ].
	
	c addPlot: plot.
	c addDecoration: (vertical := RSVerticalTick new).
	c addDecoration: (horizontal := RSHorizontalTick new).
	vertical fontSize: 11.
	horizontal fontSize: 11.
	c title: columnAssoc key. 
	c build.
	plot createdShapes @ (RSPopup new
		model: #yourself;
		yourself).
	^ container asShape.
]

{ #category : #'to review' }
AISpDataFrameVisualizerPresenter >> selectedColumnValues [

	self flag: #review.
	^ (self model column: 'sepal length (cm)') asArray collect: #value
]

{ #category : #'to review' }
AISpDataFrameVisualizerPresenter >> visualizeHistogram: aView [
	" Private - For single selection, do not delete yet "
	| chart plot |
	self flag: #review.
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
