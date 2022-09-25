Extension { #name : #SequenceableCollection }

{ #category : #'*AI-DataFrameInspector' }
SequenceableCollection >> dsElementAt: anInteger [ 
	"Support for DataFrame sorting when column name is clicked"

	^ self at: anInteger.
]
