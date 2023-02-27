"
I am a presenter to visualize a data series in the form of a historigram.

TO use me, just send #historigram to a DataSeries.
"
Class {
	#name : #AISpDataSeriesVisualizerPresenter,
	#superclass : #AISpAbstractVisualizerPresenter,
	#classTraits : 'SpTModel classTrait',
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpDataSeriesVisualizerPresenter class >> openOn: aDataSeries [

	^ (self on: aDataSeries)
		  open;
		  withWindowDo: [ :w |
			  w
				  extent: 1200 @ 700;
				  centered;
				  title: 'DataSeries Inspector' translated;
				  aboutText: 'About DataSeries' ]
]

{ #category : #initialization }
AISpDataSeriesVisualizerPresenter >> allColumnValuesWithColumnName [
	" Private - Answer a <Collection> of <Association> with numeric column values in the receiver's data frame "

	self model isNumerical ifFalse: [ self error: 'Can only plot numerical columns.' ].

	^ { (self model name -> (self model reject: #isNil)) }
]
