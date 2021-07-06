Extension { #name : #DataFrame }

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> at: anIndex ifAbsent: aBlock [

	^ self row: anIndex ifAbsent: aBlock
]

{ #category : #'*AI-DataFrameInspector' }
DataFrame >> evaluator [
    <inspectorPresentationOrder: 0 title: 'Inspector'>
    
	^ AISpDataFrameInspector on: (
		self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: 100 ])
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
