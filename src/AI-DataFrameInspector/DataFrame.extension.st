Extension { #name : #DataFrame }

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> at: anIndex ifAbsent: aBlock [

	^ self row: anIndex ifAbsent: aBlock
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluator [
    <inspectorPresentationOrder: 2 title: 'DataFrame'>
    
	^ AISpDataFrameInspector on: (
		self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameInspector maxRows ])
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluatorContext: aContext [

	aContext withoutEvaluator

]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluatorRowsLimit [
	" Private - The maximum limit to consider a DataFrame is big enough for a visualization "

	^ 10000
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasCategorical [
	" Answer <true> if the receiver has at least one categorical (not numerical) value "
	
	^ self anySatisfy: #isCategorical.
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> hasNil [
	" Answer <true> if the receiver has at least one nil value "
	
	^ self anySatisfy: #hasNil.
]
