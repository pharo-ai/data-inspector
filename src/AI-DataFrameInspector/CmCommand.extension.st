Extension { #name : #CmCommand }

{ #category : #'*AI-DataFrameInspector' }
CmCommand class >> asSpecButtonForContext: aContext [

	^ (self forSpecContext: aContext) asButtonPresenter
]
