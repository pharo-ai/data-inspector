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

{ #category : #tests }
AISpDataFrameBasicPresenterTest >> testInitializePresenters [

	self assert:
		(self dfPresenter basicInfoPresenter isKindOf:
			 AISpDataFrameBasicInfo).
	self assert:
		(self dfPresenter basicVizPresenter isKindOf: AISpDataFrameBasicViz)
]
