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

{ #category : #accessing }
AISpDataFrameEvaluatorPresenterTest >> dfEvaluator [

	^ dfEvaluator
]

{ #category : #running }
AISpDataFrameEvaluatorPresenterTest >> setUp [
	super setUp.
	
	dfEvaluator := AISpDataFrameEvaluatorPresenter on: self sampleDataFrame
]

{ #category : #tests }
AISpDataFrameEvaluatorPresenterTest >> testEvalPresenterText [

	self assert: self dfEvaluator evalPresenterText equals: String empty
]
