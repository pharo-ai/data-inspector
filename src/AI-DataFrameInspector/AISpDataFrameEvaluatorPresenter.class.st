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
	#name : #AISpDataFrameEvaluatorPresenter,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'toolbar',
		'evalPresenter',
		'activationBlock'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #layout }
AISpDataFrameEvaluatorPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: toolbar expand: false;
		add: evalPresenter;
		yourself
]

{ #category : #commands }
AISpDataFrameEvaluatorPresenter >> doEvaluateAllAndGo [

	evalPresenter selectAll.
	self doEvaluateAndGo
]

{ #category : #commands }
AISpDataFrameEvaluatorPresenter >> doEvaluateAndGo [

	| evaluatingResult |
	
	"activationBlock ifNil: [ ^ self ]."

	evaluatingResult := evalPresenter 
		evaluate: evalPresenter selectedTextOrLine
		onCompileError: [ ^ self ]
		onError: [ :e | e pass ].
	
	evalPresenter insertPrintPopoverAfterCurrentSelection: evaluatingResult.
	
	"activationBlock value: (StEvaluatedSelectionModel newValue: value)"
]

{ #category : #initialization }
AISpDataFrameEvaluatorPresenter >> evalPresenterText [

	^ evalPresenter text
]

{ #category : #initialization }
AISpDataFrameEvaluatorPresenter >> evalPresenterText: aString [

	evalPresenter text: aString.
]

{ #category : #evaluation }
AISpDataFrameEvaluatorPresenter >> evaluatorActions [
	
	^ CmCommandGroup forSpec
		beDisplayedAsGroup;
		register: (StEvaluateCommand forSpecContext: self);
		yourself
]

{ #category : #initialization }
AISpDataFrameEvaluatorPresenter >> initializeEvaluator [

	evalPresenter := self instantiate: SpCodePresenter.
	evalPresenter
		withSyntaxHighlight;
		withLineNumbers;
		beForObject: self dataFrame
]

{ #category : #initialization }
AISpDataFrameEvaluatorPresenter >> initializePresenters [

	self initializeToolbar.
	self initializeEvaluator
]

{ #category : #initialization }
AISpDataFrameEvaluatorPresenter >> initializeToolbar [

	toolbar := self instantiate: AISpDataFrameEvaluatorToolbarPresenter on: self dataFrame
]
