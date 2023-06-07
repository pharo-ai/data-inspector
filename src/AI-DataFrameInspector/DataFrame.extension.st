Extension { #name : #DataFrame }

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> addScatterPlotShapeToChart: aRSChart [
	" Assume a receiver with two first columns as x and y coordinates. 
	Requires Roassal 3. Answer a Roassal scatter plot shape with points color configured to aColor "

	| scatterPlot x y |

	x := (self columnAt: 1) asOrderedCollection.
	y := (self columnAt: 2) asOrderedCollection.
	scatterPlot := RSScatterPlot new x: x y: y.
	aRSChart addPlot: scatterPlot.
	^ scatterPlot
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> at: anIndex ifAbsent: aBlock [

	^ self row: anIndex ifAbsent: aBlock
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> dataDescriber [
    <inspectorPresentationOrder: 2 title: 'Data Description'>

	^ AISpDataFrameDescriberPresenter on: (
		self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameDescriberPresenter maxRows ])
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> dataDescriberContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluatorRowsLimit [

	" Private - The maximum limit to consider a DataFrame is big enough for a visualization "

	^ 5000
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasCategorical [

	" Answer <true> if the receiver has at least one categorical (not numerical) value "

	^ self anySatisfy: [ :each | each isCategorical ]
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasNil [

	" Answer <true> if the receiver has at least one nil value "

	^ self anySatisfy: [ :each | each hasNil ]
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> histograms [
	^ AISpDataFrameVisualizerPresenter openOn: self
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> histogramsBins: aNumber [

	^ (AISpDataFrameVisualizerPresenter on: self)
		  numberOfBins: aNumber;
		  open
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> histogramsInspector [

	<inspectorPresentationOrder: 3 title: 'Histograms'>
	| roassalPresenter |

	roassalPresenter := AISpDataFrameVisualizerPresenter on:
		(self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameDescriberPresenter maxRows ]).

	^ SpRoassal3InspectorPresenter new
		canvas: roassalPresenter createCanvas;
		yourself
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> histogramsInspectorContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> numericColumnNames [

	| r |
	r := OrderedCollection new.
	self columnNames do: [ :column | ((self dataTypes at: column) includesBehavior: Number) ifTrue: [ r add: column ] ].
	^ r asArray
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> openScatterPlotWithTitle: aString forColumn: columnName [
	" Assume a receiver with two first columns as x and y coordinates. 
	Requires Roassal 3. Plot and open a new window"

	| roassalChart scatterPlotShapes uniqueColumns |
	roassalChart := RSChart new
		title: aString;
		addDecoration: (RSHorizontalTick new doNotUseNiceLabel asFloat: 3);
		addDecoration: RSVerticalTick new;
		yourself.
	uniqueColumns := (self column: columnName) asSet.
	scatterPlotShapes := uniqueColumns collect: [ : type | 
		(self select: [ : e | e values includes: type ]) 
			addScatterPlotShapeToChart: roassalChart ].

	scatterPlotShapes asOrderedCollection
		with: ((1 to: uniqueColumns size) collect: [ : c | Color random ])
		do: [ : scatterPlotShape  : scatterPlotDotColor |
			scatterPlotShape color: scatterPlotDotColor ].
	roassalChart padding: 10.

	roassalChart open.
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> scatterMatrix [

	^ AISpScatterMatrixPresenter openOn: self
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> scatterMatrixInspector [

	<inspectorPresentationOrder: 4 title: 'Scatter Matrix'>
	| roassalPresenter |

	roassalPresenter := AISpScatterMatrixPresenter on:
		(self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameDescriberPresenter maxRows ]).

	^ SpRoassal3InspectorPresenter new
		canvas: roassalPresenter createCanvas;
		yourself
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> scatterMatrixInspectorContext: aContext [

	aContext withoutEvaluator
]
