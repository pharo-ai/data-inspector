"
I am an abtract model that calculates all the available metrics for a given actual and predicted values.

I must be instantiated with the actual and predicted values that a model returns. See my class side instantiation method.
"
Class {
	#name : #AISpAbstractMetricsModel,
	#superclass : #Object,
	#instVars : [
		'actualValues',
		'predictedValues'
	],
	#category : #'AI-MetricsInspector'
}

{ #category : #'instance creation' }
AISpAbstractMetricsModel class >> predictedValues: predicted actualValues: actual [ 

	^ self new
		predictedValues: predicted;
		actualValues: actual;
		yourself
]

{ #category : #accessing }
AISpAbstractMetricsModel >> actualValues: aCollection [

	actualValues := aCollection
]

{ #category : #accessing }
AISpAbstractMetricsModel >> allMetrics [

	^ self primaryMetrics , self otherMetrics
]

{ #category : #defaults }
AISpAbstractMetricsModel >> collectMetrics: aCollectionOfClasses [

	^ aCollectionOfClasses collect: [ :aMetricClass |
		| name value |
		name := aMetricClass metricName.
		value := aMetricClass new computeForActual: actualValues predicted: predictedValues.
		value := self roundResult: value.
		name -> value ]
]

{ #category : #inspector }
AISpAbstractMetricsModel >> inspectorTab [
	^ self subclassResponsibility
]

{ #category : #inspector }
AISpAbstractMetricsModel >> inspectorTabContext: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractMetricsModel >> otherMetrics [

	^ self subclassResponsibility
]

{ #category : #accessing }
AISpAbstractMetricsModel >> predictedValues: aCollection [

	predictedValues := aCollection
]

{ #category : #accessing }
AISpAbstractMetricsModel >> primaryMetrics [

	^ self subclassResponsibility
]

{ #category : #defaults }
AISpAbstractMetricsModel >> roundResult: aNumber [

	"We choose to show only 3 decimal places according to the European Association of Science Editors guidelines include the useful rule of thumb: “numbers should be given in (sic) 2–3 effective digits”"

	^ aNumber printShowingDecimalPlaces: 3
]
