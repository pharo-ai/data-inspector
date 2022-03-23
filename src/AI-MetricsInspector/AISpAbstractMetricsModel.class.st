Class {
	#name : #AISpAbstractMetricsModel,
	#superclass : #Object,
	#category : #'AI-MetricsInspector'
}

{ #category : #accessing }
AISpAbstractMetricsModel >> allMetrics [

	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractMetricsModel >> otherMetrics [

	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractMetricsModel >> primaryMetrics [

	^ self subclassResponsibility
]
