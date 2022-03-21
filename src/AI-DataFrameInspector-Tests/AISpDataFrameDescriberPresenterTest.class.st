"
An AISpDataFrameBasicPresenterTest is a test class for testing the behavior of AISpDataFrameBasicPresenter
"
Class {
	#name : #AISpDataFrameDescriberPresenterTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfPresenter'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #running }
AISpDataFrameDescriberPresenterTest >> setUp [

	super setUp.
	dfPresenter := AISpDataFrameDescriberPresenter on: self sampleDataFrame
]
