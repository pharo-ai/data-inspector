"
This Roassal >=3 presenter provides histogram for all numeric columns in the displayed data frame.

# Implementation Points

- Initialization happens in setModelBeforeInitialization:
- They key method for rendering is `AISpDataFrameBasicViz>>plotAllHistograms`

"
Class {
	#name : #AISpDataFrameVisualizerPresenter,
	#superclass : #AISpAbstractVisualizerPresenter,
	#classTraits : 'SpTModel classTrait',
	#category : #'AI-DataFrameInspector-Main presenters'
}

{ #category : #'instance creation' }
AISpDataFrameVisualizerPresenter class >> openOn: aDataFrame [

	^ (self on: aDataFrame)
		  open;
		  withWindowDo: [ :w |
			  w
				  extent: 1200 @ 700;
				  centered;
				  title: 'DataFrame Inspector' translated;
				  aboutText: 'About DataFrame' ]
]

{ #category : #initialization }
AISpDataFrameVisualizerPresenter >> allColumnValuesWithColumnName [
	" Private - Answer a <Collection> of <Association> with numeric column values in the receiver's data frame "

	| columns |
	columns := self model columns.

	^ self numericColumnNames collect: [ :colName | colName -> ((columns at: (self model columnNames indexOf: colName)) reject: #isNil) ]
]

{ #category : #'to review' }
AISpDataFrameVisualizerPresenter >> createCanvas [

	| canvas |
	canvas := RSCanvas new.
	canvas inspectorContext: RSEmptyContextInteraction new.
	self plotAllHistograms: canvas.
	^ canvas
]

{ #category : #accessing }
AISpDataFrameVisualizerPresenter >> dataFrame [

	^ model
]
