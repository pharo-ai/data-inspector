"
I am an abstract class for the toolbar buttons of the evaluator in the data frame inspector. If you want to add a new button to the toolbar, just create a subclass of me and add the behaviour.
"
Class {
	#name : #AISpAbstractToolbarCommand,
	#superclass : #CmCommand,
	#category : #'AI-DataFrameInspector-Toolbar evaluator commands'
}

{ #category : #initialization }
AISpAbstractToolbarCommand class >> defaultIconName [

	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractToolbarCommand class >> order [

	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractToolbarCommand class >> toolbarButtons [

	^ self allSubclasses sorted: #order ascending
]
