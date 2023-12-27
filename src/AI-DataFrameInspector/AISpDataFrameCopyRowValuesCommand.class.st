"
I am a command that copies the clicked row of the DataFrame.

I am converted to a spec context menu that appears when you right click in a DataFrame row.
"
Class {
	#name : 'AISpDataFrameCopyRowValuesCommand',
	#superclass : 'AISpDataFrameCommand',
	#category : 'AI-DataFrameInspector-Context menu commands',
	#package : 'AI-DataFrameInspector',
	#tag : 'Context menu commands'
}

{ #category : 'converting' }
AISpDataFrameCopyRowValuesCommand >> asSpecCommand [

	^ super asSpecCommand
		iconName: #smallCopy;
		shortcutKey: $v control unix | $v control win | $v command mac;
		yourself
]

{ #category : 'executing' }
AISpDataFrameCopyRowValuesCommand >> execute [

	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self selectedItem copyRowValuesToClipboard
]

{ #category : 'initialization' }
AISpDataFrameCopyRowValuesCommand >> initialize [

	super initialize.
	self
		name: 'Copy row';
		description: 'Copy current row to clipboard.'
]
