Class {
	#name : #AISpDataFrameCopyRowValuesWithLabelsCommand,
	#superclass : #AISpDataFrameCommand,
	#category : #'AI-DataFrameInspector'
}

{ #category : #converting }
AISpDataFrameCopyRowValuesWithLabelsCommand >> asSpecCommand [ 
	
	^ super asSpecCommand 
		iconProvider: self application;
		iconName: #smallCopy;
		shortcutKey: $c control unix | $c control win | $c command mac;
		yourself
]

{ #category : #executing }
AISpDataFrameCopyRowValuesWithLabelsCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self selectedItem copyRowValuesWithLabelsToClipboard
]

{ #category : #initialization }
AISpDataFrameCopyRowValuesWithLabelsCommand >> initialize [
	super initialize.
	self
		name: 'Copy row with labels';
		description: 'Copy current row values with labels to clipboard.'
]
