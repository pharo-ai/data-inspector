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
	#name : #AISpDataFrameEvaluator,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'toolbar',
		'evalPresenter',
		'activationBlock'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #accessing }
AISpDataFrameEvaluator >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
AISpDataFrameEvaluator >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #layout }
AISpDataFrameEvaluator >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: toolbar
			expand: false
			fill: true
			padding: 2;
		add: evalPresenter
			expand: true
			fill: true
			padding: 2;				
		yourself
]

{ #category : #commands }
AISpDataFrameEvaluator >> doEvaluateAndGo [
	| value |
	
	activationBlock ifNil: [ ^ self ].

	value := self evalPresenter 
		evaluate: self evalPresenter selectedTextOrLine
		onCompileError: [ ^ self ]
		onError: [ :e | e pass ].
	
	activationBlock value: (StEvaluatedSelectionModel newValue: value)
]

{ #category : #accessing }
AISpDataFrameEvaluator >> evalPresenter [
	" Answer the receiver's <SpCodePresenter> "

	^ evalPresenter
]

{ #category : #accessing }
AISpDataFrameEvaluator >> evalPresenter: anObject [

	evalPresenter := anObject
]

{ #category : #initialization }
AISpDataFrameEvaluator >> evalPresenterText [

	^ self evalPresenter text
]

{ #category : #initialization }
AISpDataFrameEvaluator >> evalPresenterText: aString [

	self evalPresenter text: aString.
]

{ #category : #evaluation }
AISpDataFrameEvaluator >> evaluatorActions [
	
	^ CmCommandGroup forSpec
		beDisplayedAsGroup;
		register: (StEvaluateCommand forSpecContext: self);
		yourself
]

{ #category : #initialization }
AISpDataFrameEvaluator >> initializePresenters [
	" Private - See superimplementor's comment "

	application := StPharoApplication new.

	toolbar := self instantiate: AISpDataFrameEvaluatorToolbar on: self dataFrame.

	evalPresenter := self instantiate: SpCodePresenter.
	evalPresenter 
		withSyntaxHighlight;
		withLineNumbers;
		beForObject: self dataFrame.

]

{ #category : #accessing }
AISpDataFrameEvaluator >> interactionModel [

	^ self evalPresenter interactionModel
]

{ #category : #initialization }
AISpDataFrameEvaluator >> selectedTextOrLine [
	" See comment in selectedTextOrLine "

	^ self evalPresenter selectedTextOrLine
]

{ #category : #accessing }
AISpDataFrameEvaluator >> toolbar [

	^ toolbar
]

{ #category : #accessing }
AISpDataFrameEvaluator >> toolbar: anObject [

	toolbar := anObject
]
