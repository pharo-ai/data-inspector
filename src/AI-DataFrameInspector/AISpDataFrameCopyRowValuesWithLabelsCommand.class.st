"
I am a command that copies the clicked row with the names of the label of the DataFrame.

I am converted to a spec context menu that appears when you right click in a DataFrame row.
"
Class {
	#name : #AISpDataFrameCopyRowValuesWithLabelsCommand,
	#superclass : #AISpDataFrameCommand,
	#category : #'AI-DataFrameInspector-Context menu commands'
}

{ #category : #converting }
AISpDataFrameCopyRowValuesWithLabelsCommand >> asSpecCommand [

	^ super asSpecCommand
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
