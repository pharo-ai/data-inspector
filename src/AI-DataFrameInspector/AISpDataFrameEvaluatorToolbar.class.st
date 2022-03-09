"
Provides actions applied to the inspected data frame. Actions currently implemented are mostly derived from the NewTools playground toolbar.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	toolbar:		<SpToolbarPresenter>


    Implementation Points
"
Class {
	#name : #AISpDataFrameEvaluatorToolbar,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'toolbar'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #layout }
AISpDataFrameEvaluatorToolbar >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: toolbar;
		yourself
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> initializePresenters [ 

	self initializeToolbar.
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> initializeToolbar [

	toolbar := self newToolbar
		displayMode: StPharoSettings toolbarDisplayMode;
		addStyle: 'stToolbar';
		fillWith: self toolbarActions;
		yourself
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> loadPage: aFileReference [

	self owner evalPresenterText: (StPlaygroundPage fromReference: aFileReference) contents.
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> toolbarActions [

	^ CmCommandGroup forSpec
		register: (StPlaygroundDoItCommand forSpecContext: self);
		register: (StPlaygroundPublishCommand forSpecContext: self);
		register: (StPlaygroundBindingsCommand forSpecContext: self owner);
		register: (StPlaygroundPagesCommand forSpecContext: self);
		yourself
]
