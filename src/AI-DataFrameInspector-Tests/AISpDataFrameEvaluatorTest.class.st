"
An AISpDataFrameEvaluatorTest is a test class for testing the behavior of AISpDataFrameEvaluator
"
Class {
	#name : #AISpDataFrameEvaluatorTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfEvaluator'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameEvaluatorTest >> dfEvaluator [

	^ dfEvaluator
]

{ #category : #running }
AISpDataFrameEvaluatorTest >> setUp [
	super setUp.
	
	dfEvaluator := AISpDataFrameEvaluator on: self sampleDataFrame
]

{ #category : #test }
AISpDataFrameEvaluatorTest >> testEvalPresenter [

	self assert: (self dfEvaluator evalPresenter isKindOf: SpCodePresenter)
]

{ #category : #test }
AISpDataFrameEvaluatorTest >> testEvalPresenterText [

	self assert: (self dfEvaluator evalPresenterText isKindOf: String).
	self assert: self dfEvaluator evalPresenterText equals: String empty.
]
