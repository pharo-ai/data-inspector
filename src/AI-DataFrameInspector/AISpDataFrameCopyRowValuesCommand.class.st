Class {
	#name : #AISpDataFrameCopyRowValuesCommand,
	#superclass : #AISpDataFrameCommand,
	#category : #'AI-DataFrameInspector'
}

{ #category : #converting }
AISpDataFrameCopyRowValuesCommand >> asSpecCommand [ 
	
	^ super asSpecCommand 
		iconProvider: self application;
		iconName: #smallCopy;
		shortcutKey: $v control unix | $v control win | $v command mac;
		yourself
]

{ #category : #executing }
AISpDataFrameCopyRowValuesCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self selectedItem copyRowValuesToClipboard
]

{ #category : #initialization }
AISpDataFrameCopyRowValuesCommand >> initialize [
	super initialize.
	self
		name: 'Copy row';
		description: 'Copy current row to clipboard.'
]
