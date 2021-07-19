Class {
	#name : #AISpDataFrameBasicPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'basicInfoPresenter',
		'basicVizPresenter'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameBasicPresenter class >> defaultSpec [

	^ SpPanedLayout newLeftToRight
		add: #basicVizPresenter;
		add: #basicInfoPresenter;
		yourself.

]

{ #category : #accessing }
AISpDataFrameBasicPresenter >> basicInfoPresenter [

	^ basicInfoPresenter
]

{ #category : #accessing }
AISpDataFrameBasicPresenter >> basicInfoPresenter: anObject [

	basicInfoPresenter := anObject
]

{ #category : #accessing }
AISpDataFrameBasicPresenter >> basicVizPresenter [

	^ basicVizPresenter
]

{ #category : #accessing }
AISpDataFrameBasicPresenter >> basicVizPresenter: anObject [

	basicVizPresenter := anObject
]

{ #category : #initialization }
AISpDataFrameBasicPresenter >> initializePresenters [

	basicInfoPresenter := self instantiate: AISpDataFrameBasicInfo on: self dataFrame.
	basicVizPresenter := self instantiate: AISpDataFrameBasicViz on: self dataFrame.
	basicVizPresenter script: [ :view | self basicVizPresenter visualizeAllHistograms: view ].

]
