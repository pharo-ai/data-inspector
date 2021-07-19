Class {
	#name : #AISpDataFrameBasicViz,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'dataFrame'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #initialization }
AISpDataFrameBasicViz >> initializeOn: aDataFrame [

	self canvas zoomToFit.
]
