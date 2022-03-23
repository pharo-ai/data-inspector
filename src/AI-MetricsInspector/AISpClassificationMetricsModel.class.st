Class {
	#name : #AISpClassificationMetricsModel,
	#superclass : #AISpAbstractMetricsModel,
	#category : #'AI-MetricsInspector'
}

{ #category : #inspector }
AISpClassificationMetricsModel >> inspectorTab [

	<inspectorPresentationOrder: 0 title: 'Classification Metrics'>
	
	^ AISpClassificationMetricsPresenter on: self
]

{ #category : #inspector }
AISpClassificationMetricsModel >> inspectorTabContext: aContext [

	aContext withoutEvaluator
]

{ #category : #accessing }
AISpClassificationMetricsModel >> otherMetrics [

	^ self collectMetrics: AIRegressionMetric subclasses
]

{ #category : #accessing }
AISpClassificationMetricsModel >> primaryMetrics [

	^ self collectMetrics: AIClassificationMetric subclasses
]
