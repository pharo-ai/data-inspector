"
Abstract class for context commands related with DataFrame inspector.
"
Class {
	#name : #AISpDataFrameCommand,
	#superclass : #CmCommand,
	#category : #'AI-DataFrameInspector'
}

{ #category : #converting }
AISpDataFrameCommand >> application [

	^ StPharoApplication current
]

{ #category : #accessing }
AISpDataFrameCommand >> dataFrame [

	^ self context dataFrame
]

{ #category : #accessing }
AISpDataFrameCommand >> selectedItem [

	^ self context dfPane selectedItem
]
