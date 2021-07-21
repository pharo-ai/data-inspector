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

{ #category : #specs }
AISpDataFrameEvaluator class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		add: #toolbar
			expand: false
			fill: true
			padding: 2;
		add: #evalPresenter
			expand: true
			fill: true
			padding: 2;				
		yourself
]

{ #category : #accessing }
AISpDataFrameEvaluator >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
AISpDataFrameEvaluator >> dataFrame: anObject [

	dataFrame := anObject
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

	^ evalPresenter
]

{ #category : #accessing }
AISpDataFrameEvaluator >> evalPresenter: anObject [

	evalPresenter := anObject
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
