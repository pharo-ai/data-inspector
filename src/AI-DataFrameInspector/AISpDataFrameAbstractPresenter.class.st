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

	^ CmCommandGroup forSpec
		beRoot;
		register: (AISpDataFrameCopyRowValuesCommand forSpecContext: self);
		register: (AISpDataFrameCopyRowValuesWithLabelsCommand forSpecContext: self);
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
