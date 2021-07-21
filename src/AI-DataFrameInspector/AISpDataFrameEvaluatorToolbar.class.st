Class {
	#name : #AISpDataFrameEvaluatorToolbar,
	#superclass : #AISpDataFrameAbstractPresenter,
	#instVars : [
		'toolbar'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameEvaluatorToolbar class >> defaultSpec [

	^ SpBoxLayout newLeftToRight
		add: #toolbar;
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
AISpDataFrameEvaluatorToolbar >> toolbarActions [

	^ CmCommandGroup forSpec
		register: (StPlaygroundDoItCommand forSpecContext: self);
		register: (StPlaygroundPublishCommand forSpecContext: self);
		register: (StPlaygroundBindingsCommand forSpecContext: self);
		register: (StPlaygroundVersionsCommand forSpecContext: self);
		register: (StPlaygroundPagesCommand forSpecContext: self);
		yourself
]
