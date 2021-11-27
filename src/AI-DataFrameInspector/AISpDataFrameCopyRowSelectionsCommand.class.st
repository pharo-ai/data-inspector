Class {
	#name : #AISpDataFrameCopyRowSelectionsCommand,
	#superclass : #AISpDataFrameCommand,
	#category : #'AI-DataFrameInspector'
}

{ #category : #converting }
AISpDataFrameCopyRowSelectionsCommand >> asSpecCommand [ 
	
	^ super asSpecCommand 
		iconProvider: self application;
		iconName: #smallCopy;
		shortcutKey: $s control unix | $s control win | $s command mac;
		yourself
]

{ #category : #executing }
AISpDataFrameCopyRowSelectionsCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	Clipboard clipboardText: self selectedItems storeString
]

{ #category : #initialization }
AISpDataFrameCopyRowSelectionsCommand >> initialize [
	super initialize.
	self
		name: 'Copy selected rows';
		description: 'Copy selected rows to clipboard.'
]
