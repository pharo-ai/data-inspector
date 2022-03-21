"
An AISpDataFrameEvaluatorTest is a test class for testing the behavior of AISpDataFrameEvaluator
"
Class {
	#name : #AISpDataFrameEvaluatorPresenterTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfEvaluator'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #running }
AISpDataFrameEvaluatorPresenterTest >> setUp [
	super setUp.
	
	dfEvaluator := AISpDataFrameEvaluatorPresenter on: self sampleDataFrame
]

{ #category : #tests }
AISpDataFrameEvaluatorPresenterTest >> testEvaluatorPresenterText [

	self assert: dfEvaluator evaluatorPresenterText equals: 'self'
]
