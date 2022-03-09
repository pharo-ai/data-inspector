Class {
	#name : #AISpDataFrameEvaluatorPharo9,
	#superclass : #AISpDataFrameEvaluator,
	#category : #'AI-DataFrameInspectorPharo9'
}

{ #category : #initialization }
AISpDataFrameEvaluatorPharo9 >> initializePresenters [

	super initializePresenters.

	self layout: self defaultLayout
]

{ #category : #initialization }
AISpDataFrameEvaluatorPharo9 >> initializeToolbar [

	toolbar := self instantiate: AISpDataFrameEvaluatorToolbarPharo9 on: self dataFrame
]
