Class {
	#name : #AISpDataFrameEvaluator,
	#superclass : #StPresenter,
	#instVars : [
		'toolbar',
		'dataFrame',
		'evalPresenter'
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

{ #category : #accessing }
AISpDataFrameEvaluator >> evalPresenter [

	^ evalPresenter
]

{ #category : #accessing }
AISpDataFrameEvaluator >> evalPresenter: anObject [

	evalPresenter := anObject
]

{ #category : #initialization }
AISpDataFrameEvaluator >> initializePresenters [

	application := StPharoApplication new.
	
	toolbar := self instantiate: AISpDataFrameEvaluatorToolbar.

	evalPresenter := self instantiate: SpCodePresenter.
	evalPresenter 
		withSyntaxHighlight;
		withLineNumbers;
		beForObject: self owner dataFrame.

]

{ #category : #accessing }
AISpDataFrameEvaluator >> toolbar [

	^ toolbar
]

{ #category : #accessing }
AISpDataFrameEvaluator >> toolbar: anObject [

	toolbar := anObject
]
