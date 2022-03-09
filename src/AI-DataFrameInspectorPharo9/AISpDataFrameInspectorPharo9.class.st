Class {
	#name : #AISpDataFrameInspectorPharo9,
	#superclass : #AISpDataFrameInspector,
	#category : #'AI-DataFrameInspectorPharo9'
}

{ #category : #initialization }
AISpDataFrameInspectorPharo9 >> initializeAdditionalInfoPresenter [

	additionalInfoPane := self instantiate: AISpDataFrameBasicPresenterPharo9 on: self dataFrame
]

{ #category : #initialization }
AISpDataFrameInspectorPharo9 >> initializeEvaluatorPresenter [

	evaluatorPane := self instantiate: AISpDataFrameEvaluatorPharo9 on: self dataFrame
]

{ #category : #initialization }
AISpDataFrameInspectorPharo9 >> initializePresenters [

	super initializePresenters.

	self layout: self defaultLayout
]

{ #category : #initialization }
AISpDataFrameInspectorPharo9 >> initializeSummaryPresenter [

	summaryPresenter := self instantiate: AISpDataFrameSummaryPresenterPharo9 on: self dataFrame
]
