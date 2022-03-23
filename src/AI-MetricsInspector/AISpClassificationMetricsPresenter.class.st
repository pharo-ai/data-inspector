Class {
	#name : #AISpClassificationMetricsPresenter,
	#superclass : #AISpAbstractMetricsPresenter,
	#category : #'AI-MetricsInspector'
}

{ #category : #initialization }
AISpClassificationMetricsPresenter >> initializeRecommendedLabel [

	recommendedMetricsLabel := self newLabel.
	recommendedMetricsLabel label: 'Recommended Metrics for a Classification Model'
]
