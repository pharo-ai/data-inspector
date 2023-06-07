"
I am a presenter rendering a scatter matrix visualization.

The scatter matrix visualization is helpful to find correlations in a dataset. 
It will present a scatter plot of each numerical columns of a data frame against each others. 
This help to manually find some correlations since the human been is good at finding patterns.
"
Class {
	#name : #AISpScatterMatrixPresenter,
	#superclass : #SpRoassalPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpScatterMatrixPresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame) open
]

{ #category : #'to review' }
AISpScatterMatrixPresenter >> createCanvas [

	| canvas |
	canvas := RSCanvas new.
	canvas inspectorContext: RSEmptyContextInteraction new.
	self initializeScatterMatrix: canvas.
	^ canvas
]

{ #category : #initialization }
AISpScatterMatrixPresenter >> initializePresenters [

	self initializeScatterMatrix: self canvas.
	self refresh
]

{ #category : #initialization }
AISpScatterMatrixPresenter >> initializeScatterMatrix: aCanvas [

	| shapes namedColumns |
	shapes := OrderedCollection new.
	namedColumns := (model numericColumnNames collect: [ :e | e -> (model column: e) ]) asOrderedDictionary.
	namedColumns keys doWithIndex: [ :column1 :index1 |
		namedColumns keys doWithIndex: [ :column2 :index2 |
			| container c plot |
			c := RSChart new.
			container := RSGroup new.

			plot := column1 = column2
				        ifTrue: [
					        RSHistogramPlot new
						        x: (namedColumns at: column1);
						        numberOfBins: 50 ]
				        ifFalse: [ RSScatterPlot new x: (namedColumns at: column2) values y: (namedColumns at: column1) values ].


			c container: container.
			c addPlot: plot.

			index2 = 1 ifTrue: [
				c
					addDecoration: RSVerticalTick new;
					addDecoration: (RSYLabelDecoration new title: column1) ].
			index1 = namedColumns size ifTrue: [
				c
					addDecoration: (RSHorizontalTick new
							 useVerticalLabel;
							 yourself);
					addDecoration: (RSXLabelDecoration new title: column2) ].

			c build.

			plot createdShapes @ (RSPopup new
				 model: #yourself;
				 yourself).

			shapes add: container asShape ] ].


	aCanvas
		addAll: shapes;
		addInteraction: RSCanvasController new.

	aCanvas when: RSExtentChangedEvent do: [
		RSGridLayout on: shapes.
		aCanvas camera zoomToFit: aCanvas extent * 0.98.

		aCanvas signalUpdate ]
]

{ #category : #'instance creation' }
AISpScatterMatrixPresenter >> open [

	^ super
		  open;
		  withWindowDo: [ :w |
			  w
				  extent: 1200 @ 700;
				  centered;
				  title: 'DataFrame Scatter Matrix' translated;
				  aboutText: 'About DataFrame' ]
]
