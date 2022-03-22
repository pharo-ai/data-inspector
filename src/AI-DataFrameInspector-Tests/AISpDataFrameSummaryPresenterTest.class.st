"
An AISpDataFrameSummaryPresenterTest is a test class for testing the behavior of AISpDataFrameSummaryPresenter
"
Class {
	#name : #AISpDataFrameSummaryPresenterTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfSummaryPresenter'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameSummaryPresenterTest >> dfSummaryPresenter [

	^ dfSummaryPresenter
]

{ #category : #running }
AISpDataFrameSummaryPresenterTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	dfSummaryPresenter := AISpDataFrameSummaryPresenter on: self sampleDataFrame.
]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testInitializePresenters [

	self
		assert:
		self dfSummaryPresenter dataFrameSummaryPresenter columns size
		equals: self dfSummaryPresenter dataFrame columns size + 1
]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testRoundResult [

	self assert: (self dfSummaryPresenter roundResult: 56.8787887) equals: '56.88'.
	self deny: (self dfSummaryPresenter roundResult: 56.8787887) equals: '56.87'
]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testSummaryStats [

	self assert: (self dfSummaryPresenter summaryStats isKindOf: Dictionary)
]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testSummaryStatsAt [

	self assert: (self dfSummaryPresenter summaryStatsAt: 'Average') equals: #average.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Mode') equals: #mode.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Median') equals: #median.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Variance') equals: #variance.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Standard deviation') equals: #stdev.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Minimum') equals: #min.
	self assert: (self dfSummaryPresenter summaryStatsAt: 'Maximum') equals: #max.
	self assert: (self dfSummaryPresenter summaryStatsAt: '1st Quartile') equals: #firstQuartile.

]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testSummaryStatsLabels [

	self assert: (self dfSummaryPresenter summaryStatsLabels isKindOf: Collection).
	self deny: self dfSummaryPresenter summaryStatsLabels isEmpty.
]

{ #category : #test }
AISpDataFrameSummaryPresenterTest >> testSummaryStatsValueForIn [

	self assert: (self dfSummaryPresenter summaryStatsValueFor: 'Minimum' in: 'child_mort') equals: '16.60'.
	self assert: (self dfSummaryPresenter summaryStatsValueFor: 'Maximum' in: 'exports') equals: '38.40'.
	self assert: (self dfSummaryPresenter summaryStatsValueFor: 'Average' in: 'gdpp') equals: '3034.33'.
]
