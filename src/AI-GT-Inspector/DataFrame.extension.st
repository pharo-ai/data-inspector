Extension { #name : #DataFrame }

{ #category : #'*AI-GT-Inspector' }
DataFrame >> gtInspectorDataEvaluatorIn: composite [
	<gtInspectorPresentationOrder: 1>
	<gtInspectorTag: #basic>

	composite custom: (AIGTDataFrameBrowser new startOn: self)
]
