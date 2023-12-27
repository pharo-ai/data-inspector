Extension { #name : 'SequenceableCollection' }

{ #category : '*AI-DataFrameInspector' }
SequenceableCollection >> dataSeriesElementAt: anInteger [
	"Support for DataFrame sorting when column name is clicked"

	^ self at: anInteger
]
