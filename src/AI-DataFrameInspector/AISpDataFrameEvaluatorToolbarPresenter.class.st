"
Provides actions applied to the inspected data frame. Actions currently implemented are mostly derived from the NewTools playground toolbar.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	toolbar:		<SpToolbarPresenter>


    Implementation Points
"
Class {
	#name : #AISpDataFrameEvaluatorToolbarPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'toolbar'
	],
	#category : #'AI-DataFrameInspector-Sub presenters'
}

{ #category : #layout }
AISpDataFrameEvaluatorToolbarPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: toolbar;
		yourself
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbarPresenter >> evaluatorPresenter [

	^ self owner evaluatorPresenter
]

{ #category : #initialization }
AISpDataFrameEvaluatorToolbarPresenter >> initializePresenters [ 

	self initializeToolbar.
]

{ #category : #initialization }
AISpDataFrameEvaluatorToolbarPresenter >> initializeToolbar [

	"evaluateItButton := AISpEvaluateItCommand asSpecButtonForContext: self"

	| group |
	group := CmCommandGroup forSpec.
	AISpAbstractToolbarCommand toolbarButtons do: [ :aCommand | 
		group register: (aCommand forSpecContext: self) ].

	toolbar := group asToolbarPresenter
]
