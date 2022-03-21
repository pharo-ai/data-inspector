"
Displays a table with basic information about the data frame such as :

- Dimensions
- Whether contains categorical columns
- Whether any column contains NA/NULL/nil values.

Internal Representation and Key Implementation Points.

    Instance Variables
	dataFramePresenter:		<SpTablePresenter>


    Implementation Points
"
Class {
	#name : #AISpDataFrameBasicInfoPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'dataFrameBasicInfoPresenter'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #accessing }
AISpDataFrameBasicInfoPresenter >> dataFrameBasicInfoPresenter [

	^ dataFrameBasicInfoPresenter
]

{ #category : #layout }
AISpDataFrameBasicInfoPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: dataFrameBasicInfoPresenter;
		yourself
]

{ #category : #initialization }
AISpDataFrameBasicInfoPresenter >> initializePresenters [

	dataFrameBasicInfoPresenter := self newTable.
	dataFrameBasicInfoPresenter
		showColumnHeaders;
		beMultipleSelection;
		items: self summaryDescriptionsLabels;
		addColumn:
			(SpStringTableColumn title: 'Type' evaluated: [ :each | each ]);
		addColumn: (SpStringTableColumn new
			title: 'Value';
			evaluated: [ :aString | self summaryValueFor: aString ];
			beSortable)
]

{ #category : #'private building' }
AISpDataFrameBasicInfoPresenter >> summaryDescriptions [

	^ Dictionary new
		at: 'Dimensions' 		put: #dimensions;
		at: 'Has nil'			put: #hasNil;
		at: 'Has categorical'	put: #hasCategorical;
		yourself
]

{ #category : #'private building' }
AISpDataFrameBasicInfoPresenter >> summaryDescriptionsLabels [

	^ self summaryDescriptions keys asSortedCollection 
]

{ #category : #'private building' }
AISpDataFrameBasicInfoPresenter >> summaryDescriptorsAt: aString [

	^ self summaryDescriptions at: aString
]

{ #category : #'private building' }
AISpDataFrameBasicInfoPresenter >> summaryValueFor: aString [

	^ StObjectPrinter asNonTruncatedTextFrom:
		  (self dataFrame perform: (self summaryDescriptorsAt: aString))
]
