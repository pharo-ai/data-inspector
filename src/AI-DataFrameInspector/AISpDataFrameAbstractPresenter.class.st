"
This is an abstract superclass with behavior to set the presenter's model data frame.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataFrame:		<DataFrame>


    Implementation Points
"
Class {
	#name : 'AISpDataFrameAbstractPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'dataFrame'
	],
	#category : 'AI-DataFrameInspector-Sub presenters',
	#package : 'AI-DataFrameInspector',
	#tag : 'Sub presenters'
}

{ #category : 'accessing' }
AISpDataFrameAbstractPresenter >> dataFrame [

	^ dataFrame
]

{ #category : 'accessing' }
AISpDataFrameAbstractPresenter >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : 'accessing - model' }
AISpDataFrameAbstractPresenter >> setModelBeforeInitialization: aDomainObject [

	dataFrame := aDomainObject
]
