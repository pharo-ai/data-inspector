Extension { #name : #DataFrame }

{ #category : #'*AI-GT-Inspector' }
DataFrame >> gtInspectorDataEvaluatorIn: composite [
	<gtInspectorPresentationOrder: 1>
	<gtInspectorTag: #basic>

	composite custom: (AIGTDataFrameBrowser new startOn: self)
]

{ #category : #'*AI-GT-Inspector' }
DataFrame >> hasCategorical [
	" Answer <true> if the receiver has at least one categorical (not numerical) value "
	
	^ self anySatisfy: #isCategorical.
]

{ #category : #'*AI-GT-Inspector' }
DataFrame >> hasNil [
	" Answer <true> if the receiver has at least one nil value "
	
	^ self anySatisfy: #hasNil.
]
