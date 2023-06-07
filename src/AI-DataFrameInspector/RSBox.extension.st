Extension { #name : #RSBox }

{ #category : #'*AI-DataFrameInspector' }
RSBox >> asString [

	^ String streamContents: [ :stream |
		  stream << 'Min: ' << (model key key printShowingDecimalPlaces: 2)
		  << String cr << 'Max: '
		  << (model key value printShowingDecimalPlaces: 2) << String cr
		  << 'Ocurrences: ' << model value asString ]
]
