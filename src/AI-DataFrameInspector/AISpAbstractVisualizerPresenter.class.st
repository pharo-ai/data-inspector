Class {
	#name : #AISpAbstractVisualizerPresenter,
	#superclass : #SpRoassalPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'numberOfBins'
	],
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpAbstractVisualizerPresenter class >> openOn: aModel [

	^ (self on: aModel) open
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> allColumnValuesWithColumnName [
	" Private - Answer a <Collection> of <Association> with numeric column values in the receiver's data frame "

	^ self subclassResponsibility
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> defaultNumberOfBins [

	^ 50
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> initializePresenters [

	self canvas: RSCanvas new.
	self plotAllHistograms: self canvas.
	self refresh
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> numberOfBins [

	^ numberOfBins ifNil: [ numberOfBins := self defaultNumberOfBins ]
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> numberOfBins: aNumber [

	numberOfBins := aNumber.
	self initializePresenters
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> numericColumnNames [

	^ self model numericColumnNames
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> plotAllHistograms: aCanvas [

	| shapes |
	shapes := self allColumnValuesWithColumnName collect: [ :columnAssoc | 
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

		aCanvas signalUpdate ]
]

{ #category : #initialization }
AISpAbstractVisualizerPresenter >> plotHistogram: columnAssoc [

	| container c columnValues plot vertical horizontal |
	columnValues := columnAssoc value.
	c := RSChart new.
	container := RSGroup new.

	plot := [
	        RSHistogramPlot new
		        x: columnValues;
		        numberOfBins: self numberOfBins ]
		        on: DomainError
		        do: [ :ex | RSLinePlot new y: columnValues ].

	vertical := RSVerticalTick new.
	vertical fontSize: 11.
	horizontal := RSHorizontalTick new.
	horizontal
		fontSize: 11;
		useDiagonalLabel.

	c container: container.
	c addPlot: plot.
	c addDecoration: vertical.
	c addDecoration: horizontal.
	c title: columnAssoc key.
	c build.

	plot createdShapes @ (RSPopup new
		 model: #yourself;
		 yourself).

	^ container asShape
]
