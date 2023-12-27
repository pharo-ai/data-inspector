Extension { #name : 'DataSeries' }

{ #category : '*AI-DataFrameInspector' }
DataSeries >> copyRowValuesToClipboard [

	Clipboard
		clipboardText: (String streamContents: [ :s | s << self values asString ])
]

{ #category : '*AI-DataFrameInspector' }
DataSeries >> copyRowValuesWithLabelsToClipboard [

	Clipboard clipboardText: (String streamContents: [ :s | s << self associations asString ])
]

{ #category : '*AI-DataFrameInspector' }
DataSeries >> dataSeriesElementAt: anInteger [
	"Support for DataFrame sorting when column name is clicked"

	^ self atIndex: anInteger
]

{ #category : '*AI-DataFrameInspector' }
DataSeries >> histogram [

	^ AISpDataSeriesVisualizerPresenter openOn: self
]

{ #category : '*AI-DataFrameInspector' }
DataSeries >> histogramBins: aNumber [

	^ (AISpDataSeriesVisualizerPresenter on: self)
		  numberOfBins: aNumber;
		  open
]
