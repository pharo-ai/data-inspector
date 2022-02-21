Class {
	#name : #AISpDataFrameInspectCommand,
	#superclass : #AISpDataFrameCommand,
	#category : #'AI-DataFrameInspector'
}

{ #category : #converting }
AISpDataFrameInspectCommand >> asSpecCommand [ 
	
	^ super asSpecCommand 
		iconProvider: self application;
		iconName: #smallInspectIt;
		shortcutKey: $i control unix | $i control win | $i command mac;
		yourself
]

{ #category : #executing }
AISpDataFrameInspectCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self selectedItem inspect
]

{ #category : #initialization }
AISpDataFrameInspectCommand >> initialize [
	super initialize.
	self
		name: 'Inspect';
		description: 'Inspect selection'
]
