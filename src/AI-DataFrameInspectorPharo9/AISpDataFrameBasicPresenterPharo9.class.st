Class {
	#name : #AISpDataFrameBasicPresenterPharo9,
	#superclass : #AISpDataFrameBasicPresenter,
	#category : #'AI-DataFrameInspectorPharo9'
}

{ #category : #initialization }
AISpDataFrameBasicPresenterPharo9 >> initializeBasicInfo [

	basicInfoPresenter := self instantiate: AISpDataFrameBasicInfoPharo9 on: self dataFrame
]

{ #category : #initialization }
AISpDataFrameBasicPresenterPharo9 >> initializePresenters [

	super initializePresenters.

	self layout: self defaultLayout
]
