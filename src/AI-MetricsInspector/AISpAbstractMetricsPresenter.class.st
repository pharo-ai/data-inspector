"
I am a presenter that show in two tables the metrics that can be applied for a regression model or a classification model. For the moment, I will work with linear regression and logistic regression models.
"
Class {
	#name : #AISpAbstractMetricsPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'primaryMetricsTable',
		'otherMetricsTable',
		'showOtherMetricsButton',
		'isOtherMetricsTableShown',
		'recommendedMetricsLabel',
		'otherMetricsLabel'
	],
	#category : #'AI-MetricsInspector'
}

{ #category : #layout }
AISpAbstractMetricsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: recommendedMetricsLabel expand: false;
		add: primaryMetricsTable;
		add: (SpBoxLayout newLeftToRight
			add: otherMetricsLabel expand: false;
			add: showOtherMetricsButton withConstraints: [ :constraints |
				constraints
					height: 18;
					width: 18 ];
			yourself)
		expand: false;
		yourself
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initialize [

	super initialize.
	isOtherMetricsTableShown := false
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializeOtherMetricsLabel [

	otherMetricsLabel := self newLabel.
	otherMetricsLabel label: 'Other Metrics'
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializeOtherMetricsTable [

	otherMetricsTable := self newTable.
	otherMetricsTable
		items: model otherMetrics;
		addColumn: (SpStringTableColumn title: 'Metric' evaluated: [ :each | each key ]);
		addColumn: (SpStringTableColumn title: 'Value' evaluated: [ :each | each value ])
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializePresenters [

	self initializePrimaryMetricsTable.
	self initializeShowOtherMetricsButton.
	self initializeOtherMetricsTable.

	self initializeOtherMetricsLabel.
	self initializeRecommendedLabel
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializePrimaryMetricsTable [

	primaryMetricsTable := self newTable.
	primaryMetricsTable
		items: model primaryMetrics;
		addColumn: (SpStringTableColumn title: 'Metric' evaluated: [ :each | each key ]);
		addColumn: (SpStringTableColumn title: 'Value' evaluated: [ :each | each value ])
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializeRecommendedLabel [

	self subclassResponsibility
]

{ #category : #initialization }
AISpAbstractMetricsPresenter >> initializeShowOtherMetricsButton [

	showOtherMetricsButton := self newButton.
	showOtherMetricsButton
		action: [ self toggleOtherMetricsTable ];
		icon: (self iconNamed: #arrowDown)
]

{ #category : #actions }
AISpAbstractMetricsPresenter >> toggleOtherMetricsTable [

	isOtherMetricsTableShown
		ifTrue: [
			showOtherMetricsButton iconName: #arrowDown.
			self layout remove: otherMetricsTable ]
		ifFalse: [
			showOtherMetricsButton iconName: #arrowUp.
			self layout add: otherMetricsTable ].

	isOtherMetricsTableShown := isOtherMetricsTableShown not
]
