Class {
	#name : #AISpDataFrameBasicInfo,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'dataFramePresenter'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameBasicInfo class >> defaultSpec [

	^ SpPanedLayout newTopToBottom
		add: #dataFramePresenter;
		yourself.

]

{ #category : #initialization }
AISpDataFrameBasicInfo >> dataFramePresenter [

	^ dataFramePresenter
]

{ #category : #accessing }
AISpDataFrameBasicInfo >> dataFramePresenter: anObject [

	dataFramePresenter := anObject
]

{ #category : #initialization }
AISpDataFrameBasicInfo >> initializePresenters [
	" Private - The summary pane is a table to display receiver summary statistics "

	dataFramePresenter := self newTable
		showColumnHeaders;
"		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;"
		items: self summaryDescriptionsLabels;
		addColumn:  (SpStringTableColumn 
			title: 'Type' 
			evaluated: [ :each | each ]);
		addColumn: (
			SpStringTableColumn new
				title: 'Value';
				evaluated: [ : aString | self summaryValueFor: aString ];
				beSortable).

]

{ #category : #'private building' }
AISpDataFrameBasicInfo >> summaryDescriptions [

	^ Dictionary new
		at: 'Dimensions' 		put: #dimensions;
		at: 'Has nil'			put: #hasNil;
		at: 'Has categorical'	put: #hasCategorical;
		yourself
]

{ #category : #'private building' }
AISpDataFrameBasicInfo >> summaryDescriptionsLabels [

	^ self summaryDescriptions keys asSortedCollection 
]

{ #category : #'private building' }
AISpDataFrameBasicInfo >> summaryDescriptorsAt: aString [

	^ self summaryDescriptions at: aString
]

{ #category : #'private building' }
AISpDataFrameBasicInfo >> summaryValueFor: aString [

	^ StObjectPrinter asNonTruncatedTextFrom: 
		(self dataFrame perform: (self summaryDescriptorsAt: aString))
]
