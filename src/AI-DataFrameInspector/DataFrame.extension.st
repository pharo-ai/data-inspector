Extension { #name : #DataFrame }

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> at: anIndex ifAbsent: aBlock [

	^ self row: anIndex ifAbsent: aBlock
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> dataDescriber [
    <inspectorPresentationOrder: 2 title: 'Data Description'>
    
	^ AISpDataFrameDescriberPresenter on: (
		self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameDescriberPresenter maxRows ])
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> dataDescriberContext: aContext [

	aContext withoutEvaluator

]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluatorRowsLimit [

	" Private - The maximum limit to consider a DataFrame is big enough for a visualization "

	^ 5000
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasCategorical [

	" Answer <true> if the receiver has at least one categorical (not numerical) value "

	^ self anySatisfy: [ :each | each isCategorical ]
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasNil [

	" Answer <true> if the receiver has at least one nil value "

	^ self anySatisfy: [ :each | each hasNil ]
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> historigrams [
	^ AISpDataFrameVisualizerPresenter openOn: self
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> numericColumnNames [

	| r |
	r := OrderedCollection new.
	self dataTypes keysAndValuesDo: [ :name :type | (type includesBehavior: Number) ifTrue: [ r add: name asSymbol ] ].
	^ r asArray
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> visualizer [

	<inspectorPresentationOrder: 3 title: 'Visualizations'>
	| roassalPresenter |
	
	roassalPresenter := AISpDataFrameVisualizerPresenter on:
		(self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameDescriberPresenter maxRows ]).
	
	^ SpRoassal3InspectorPresenter new
		canvas: roassalPresenter createCanvas;
		yourself
	

]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> visualizerContext: aContext [

	aContext withoutEvaluator
]
