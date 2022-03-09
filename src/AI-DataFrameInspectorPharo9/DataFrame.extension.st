Extension { #name : #DataFrame }

{ #category : #'*AI-DataFrameInspectorPharo9' }
DataFrame >> evaluator [
    <inspectorPresentationOrder: 2 title: 'DataFrame'>
    
	^ AISpDataFrameInspectorPharo9 on: (
		self numberOfRows > self evaluatorRowsLimit
			ifFalse: [ self ]
			ifTrue: [ self head: AISpDataFrameInspectorPharo9 maxRows ])
]
