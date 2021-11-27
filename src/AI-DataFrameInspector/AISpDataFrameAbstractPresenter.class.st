"
This is an abstract superclass with behavior to set the presenter's model data frame.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataFrame:		<DataFrame>


    Implementation Points
"
Class {
	#name : #AISpDataFrameAbstractPresenter,
	#superclass : #StPresenter,
	#instVars : [
		'dataFrame'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #initialization }
AISpDataFrameAbstractPresenter >> columnNames [ 

	^ self dataFrame columnNames
]

{ #category : #initialization }
AISpDataFrameAbstractPresenter >> contextMenu [

	^ self contextMenuActions asMenuPresenter
]

{ #category : #initialization }
AISpDataFrameAbstractPresenter >> contextMenuActions [

	self halt. "2"
	^ CmCommandGroup forSpec
		beRoot;
		register: (AISpDataFrameCopyRowValuesCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowValuesWithLabelsCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowSelectionsCommand forSpecContext: self);
		yourself
]

{ #category : #initialization }
AISpDataFrameAbstractPresenter >> contextMenuKeyBindings [

	^ self contextMenuActions asKMCategory
]

{ #category : #accessing }
AISpDataFrameAbstractPresenter >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
AISpDataFrameAbstractPresenter >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #'private building' }
AISpDataFrameAbstractPresenter >> setModelBeforeInitialization: aDomainObject [

	dataFrame := aDomainObject
]
