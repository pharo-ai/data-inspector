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

{ #category : #accessing }
AISpRegressionMetricsModel >> collectMetrics: aCollectionOfClasses [

	^ aCollectionOfClasses collect: [ :aMetricClass |
		| name value |
		name := aMetricClass metricName.
		value := aMetricClass new computeForActual: actualValues predicted: predictedValues.
		value := self roundResult: value.
		name -> value ]
]

{ #category : #inspector }
AISpRegressionMetricsModel >> inspectorTab [

	<inspectorPresentationOrder: 0 title: 'Regression Metrics'>
	
	^ AISpRegressionMetricsPresenter on: self
]

{ #category : #accessing }
AISpRegressionMetricsModel >> otherMetrics [

	^ self collectMetrics: AIClassificationMetric subclasses
]

{ #category : #accessing }
AISpRegressionMetricsModel >> predictedValues: aCollection [

	predictedValues := aCollection
]

{ #category : #accessing }
AISpRegressionMetricsModel >> primaryMetrics [

	^ self collectMetrics: AIRegressionMetric subclasses
]

{ #category : #defaults }
AISpRegressionMetricsModel >> roundResult: aNumber [

	"We choose to show only 3 decimal places according to the European Association of Science Editors guidelines include the useful rule of thumb: “numbers should be given in (sic) 2–3 effective digits”"

	^ aNumber printShowingDecimalPlaces: 3
]
