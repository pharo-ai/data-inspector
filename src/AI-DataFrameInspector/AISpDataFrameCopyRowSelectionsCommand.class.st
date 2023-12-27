"
I am a command that copies the selected rows of the DataFrame.

I am converted to a spec context menu that appears when you right click in a DataFrame row.
"
Class {
	#name : 'AISpDataFrameCopyRowSelectionsCommand',
	#superclass : 'AISpDataFrameCommand',
	#category : 'AI-DataFrameInspector-Context menu commands',
	#package : 'AI-DataFrameInspector',
	#tag : 'Context menu commands'
}

{ #category : 'converting' }
AISpDataFrameCopyRowSelectionsCommand >> asSpecCommand [

	^ super asSpecCommand
		iconName: #smallCopy;
		shortcutKey: $s control unix | $s control win | $s command mac;
		yourself
]

{ #category : 'executing' }
AISpDataFrameCopyRowSelectionsCommand >> execute [

	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	Clipboard clipboardText: self selectedItems storeString
]

{ #category : 'initialization' }
AISpDataFrameCopyRowSelectionsCommand >> initialize [

	super initialize.
	self
		name: 'Copy selected rows';
		description: 'Copy selected rows to clipboard.'
]
