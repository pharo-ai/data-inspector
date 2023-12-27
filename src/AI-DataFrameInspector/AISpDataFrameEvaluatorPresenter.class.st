"
Implements a presenter with Pharo source code evaluation capabilities. The receiver in this evaluator represents the data frame currently displayed. It includes a toolbar, implemented in `AISpDataFrameEvaluatorToolbar`
 
Internal Representation and Key Implementation Points.

    Instance Variables
	activationBlock:		<Object>
	evalPresenter:		<Object>
	toolbar:		<AISpDataFrameEvaluatorToolbar>


    Implementation Points
"
Class {
	#name : 'AISpDataFrameEvaluatorPresenter',
	#superclass : 'AISpDataFrameAbstractPresenter',
	#instVars : [
		'toolbar',
		'evaluatorPresenter'
	],
	#category : 'AI-DataFrameInspector-Sub presenters',
	#package : 'AI-DataFrameInspector',
	#tag : 'Sub presenters'
}

{ #category : 'layout' }
AISpDataFrameEvaluatorPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: toolbar expand: false;
		add: evaluatorPresenter;
		yourself
]

{ #category : 'accessing' }
AISpDataFrameEvaluatorPresenter >> evaluatorPresenter [

	^ evaluatorPresenter
]

{ #category : 'initialization' }
AISpDataFrameEvaluatorPresenter >> evaluatorPresenterText [

	^ evaluatorPresenter text
]

{ #category : 'initialization' }
AISpDataFrameEvaluatorPresenter >> initializeEvaluator [

	evaluatorPresenter := self instantiate: SpCodePresenter.
	evaluatorPresenter
		withSyntaxHighlight;
		withLineNumbers;
		beForObject: self dataFrame;
		text: 'self'
]

{ #category : 'initialization' }
AISpDataFrameEvaluatorPresenter >> initializePresenters [

	self initializeToolbar.
	self initializeEvaluator
]

{ #category : 'initialization' }
AISpDataFrameEvaluatorPresenter >> initializeToolbar [

	toolbar := self instantiate: AISpDataFrameEvaluatorToolbarPresenter on: self dataFrame
]
