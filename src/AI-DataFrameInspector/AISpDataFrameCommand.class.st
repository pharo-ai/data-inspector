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

	^ self context dataFramePresenter selectedItem
]

{ #category : #accessing }
AISpDataFrameCommand >> selectedItems [
	" Answer a <Collection> with the checked items in the receiver's presenter context "

	^ self context selectedItems
]
