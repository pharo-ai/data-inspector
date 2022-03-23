Class {
	#name : #AISpRegressionMetricsPresenter,
	#superclass : #AISpAbstractMetricsPresenter,
	#category : #'AI-MetricsInspector'
}

{ #category : #initialization }
AISpRegressionMetricsPresenter >> initializeRecommendedLabel [

	recommendedMetricsLabel := self newLabel.
	recommendedMetricsLabel label: 'Recommended Metrics for a Regression Model'
]
