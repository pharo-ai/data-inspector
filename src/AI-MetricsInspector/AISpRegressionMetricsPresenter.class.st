Class {
	#name : #AISpRegressionMetricsPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'primaryMetricsTable'
	],
	#category : #'AI-MetricsInspector'
}

{ #category : #layout }
AISpRegressionMetricsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: primaryMetricsTable;
		yourself
]

{ #category : #initialization }
AISpRegressionMetricsPresenter >> initializePresenters [

	primaryMetricsTable := self newTable.
	primaryMetricsTable
		items: model primaryMetrics;
		addColumn: (SpStringTableColumn title: 'Metric' evaluated: [ :each | each key ]);
		addColumn: (SpStringTableColumn title: 'Value' evaluated: [ :each | each value ])
]
