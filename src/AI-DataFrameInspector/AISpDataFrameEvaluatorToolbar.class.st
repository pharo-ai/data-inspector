Class {
	#name : #AISpDataFrameEvaluatorToolbar,
	#superclass : #StPresenter,
	#instVars : [
		'doItButton',
		'profileItButton',
		'stopItButton',
		'publishItButton',
		'browseItButton'
	],
	#category : #'AI-DataFrameInspector'
}

{ #category : #specs }
AISpDataFrameEvaluatorToolbar class >> defaultSpec [

	^ SpBoxLayout newLeftToRight
		add: #doItButton;
		add: #profileItButton;
		add: #stopItButton;
		add: #publishItButton;
		add: #browseItButton;
		yourself
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> browseItButton [

	^ browseItButton
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> browseItButton: anObject [

	browseItButton := anObject
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> dataFrame [ 

	^ self owner dataFrame
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> doItButton [

	^ doItButton
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> doItButton: anObject [

	doItButton := anObject
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> initializeButtons [ 

	doItButton := self newButton.

	doItButton 
		help: 'Run the entered code and inspect';
		label: 'Do it';
		icon: (self iconNamed: #smallDoIt);
		action: [ self dataFrame ].

	stopItButton := self newButton.
	stopItButton
		help: 'Stop the current analysis';
		label: 'Stop It';
		icon: (self iconNamed: #smallCancel).		

	profileItButton := self newButton.
	profileItButton 
		help: 'Profile the selected code';
		label: 'Profile It';
		icon: (self iconNamed: #smallProfile).
		
	publishItButton := self newButton.
	publishItButton 
		label: 'Publish It';
		icon: (self iconNamed: #smallProfile).
	
	browseItButton := self newButton.
	browseItButton
		label: 'Browse It';
		icon: (self iconNamed: #smallHierarchyBrowser);
		action: [ DataFrame browse ]
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> initializePresenters [ 

	self initializeButtons.
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> profileItButton [

	^ profileItButton
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> profileItButton: anObject [

	profileItButton := anObject
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> publishItButton [

	^ publishItButton
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> publishItButton: anObject [

	publishItButton := anObject
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> stopItButton [

	^ stopItButton
]

{ #category : #accessing }
AISpDataFrameEvaluatorToolbar >> stopItButton: anObject [

	stopItButton := anObject
]
