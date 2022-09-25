Extension { #name : #DataSeries }

{ #category : #'*AI-DataFrameInspector' }
DataSeries >> copyRowValuesToClipboard [

	Clipboard
		clipboardText: (String streamContents: [ :s | s << self values asString ])
]

{ #category : #'*AI-DataFrameInspector' }
DataSeries >> copyRowValuesWithLabelsToClipboard [

	Clipboard clipboardText: (String streamContents: [ :s | s << self associations asString ])
]

{ #category : #'*AI-DataFrameInspector' }
DataSeries >> dsElementAt: anInteger [ 
	"Support for DataFrame sorting when column name is clicked"

	^ self atIndex: anInteger
]
