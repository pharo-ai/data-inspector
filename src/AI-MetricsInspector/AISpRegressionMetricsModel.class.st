Class {
	#name : #AISpRegressionMetricsModel,
	#superclass : #AISpAbstractMetricsModel,
	#instVars : [
		'actualValues',
		'predictedValues'
	],
	#category : #'AI-MetricsInspector'
}

{ #category : #'instance creation' }
AISpRegressionMetricsModel class >> predictedValues: predicted actualValues: actual [ 

	^ self new
		predictedValues: predicted;
		actualValues: actual;
		yourself
]

{ #category : #accessing }
AISpRegressionMetricsModel >> actualValues: aCollection [

	actualValues := aCollection
]

{ #category : #accessing }
AISpRegressionMetricsModel >> allMetrics [

	^ self primaryMetrics , self otherMetrics
]

{ #category : #inspector }
AISpRegressionMetricsModel >> inspectorTab [

	<inspectorPresentationOrder: 0 title: 'Regression Metrics'>
	
	^ AISpRegressionMetricsPresenter on: self
]

{ #category : #accessing }
AISpRegressionMetricsModel >> otherMetrics [

	^ AIClassificationMetric subclasses collect: [ :aMetricClass |
		| name value |
		name := aMetricClass name.
		value := aMetricClass new computeForActual: actualValues predicted: predictedValues.
		name -> value ]
]

{ #category : #accessing }
AISpRegressionMetricsModel >> predictedValues: aCollection [

	predictedValues := aCollection
]

{ #category : #accessing }
AISpRegressionMetricsModel >> primaryMetrics [

	^ AIRegressionMetric subclasses collect: [ :aMetricClass |
		| name value |
		name := aMetricClass name.
		value := aMetricClass new computeForActual: actualValues predicted: predictedValues.
		name -> value ]
]
