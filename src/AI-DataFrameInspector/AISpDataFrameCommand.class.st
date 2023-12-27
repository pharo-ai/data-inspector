"
Abstract class for context commands related with DataFrame inspector.
"
Class {
	#name : 'AISpDataFrameCommand',
	#superclass : 'CmCommand',
	#category : 'AI-DataFrameInspector-Context menu commands',
	#package : 'AI-DataFrameInspector',
	#tag : 'Context menu commands'
}

{ #category : 'accessing' }
AISpDataFrameCommand >> dataFrame [

	^ self context dataFrame
]

{ #category : 'accessing' }
AISpDataFrameCommand >> selectedItem [

	^ self context dataFramePresenter selectedItem
]

{ #category : 'accessing' }
AISpDataFrameCommand >> selectedItems [

	^ self context selectedItems
]
