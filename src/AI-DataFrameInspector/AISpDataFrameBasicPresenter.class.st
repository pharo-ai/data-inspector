"
This presenter includes two panes :

- One including basic information about the data frame, implemented in `AISpDataFrameBasicInfo`
- Another one with a histogram for the data frame numerical columns, implemented in `AISpDataFrameBasicViz`


Internal Representation and Key Implementation Points.

    Instance Variables
	basicInfoPresenter:		<AISpDataFrameBasicInfo>
	basicVizPresenter:		<AISpDataFrameBasicViz>


    Implementation Points
"
Class {
	#name : #AISpDataFrameBasicPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'basicInfoPresenter',
		'basicVizPresenter'
	],
	#category : #'AI-DataFrameInspector'
}

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

{ #category : #layout }
AISpDataFrameBasicPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: basicVizPresenter
		  expand: true
		  fill: true
		  padding: 0;
		add: basicInfoPresenter
		  expand: true
		  fill: true
		  padding: 0;
		yourself.

]

{ #category : #initialization }
AISpDataFrameBasicPresenter >> initializeBasicInfo [

	basicInfoPresenter := self instantiate: AISpDataFrameBasicInfo on: self dataFrame
]

{ #category : #initialization }
AISpDataFrameBasicPresenter >> initializePresenters [

	self initializeBasicInfo.
	self initializeViz

]

{ #category : #initialization }
AISpDataFrameBasicPresenter >> initializeViz [

	basicVizPresenter := self instantiate: AISpDataFrameBasicViz on: self dataFrame.
	basicVizPresenter script: [ :view | self basicVizPresenter plotAllHistograms: view ]
]
