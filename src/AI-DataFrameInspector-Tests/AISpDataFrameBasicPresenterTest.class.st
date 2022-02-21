"
An AISpDataFrameBasicPresenterTest is a test class for testing the behavior of AISpDataFrameBasicPresenter
"
Class {
	#name : #AISpDataFrameBasicPresenterTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfPresenter'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameBasicPresenterTest >> dfPresenter [

	^ dfPresenter
]

{ #category : #test }
AISpDataFrameBasicPresenterTest >> setUp [

	dfPresenter := AISpDataFrameBasicPresenter on: self sampleDataFrame.
]

{ #category : #test }
AISpDataFrameBasicPresenterTest >> testBasicInfoPresenter [

	self assert: (self dfPresenter basicInfoPresenter isKindOf: AISpDataFrameBasicInfo).
]
