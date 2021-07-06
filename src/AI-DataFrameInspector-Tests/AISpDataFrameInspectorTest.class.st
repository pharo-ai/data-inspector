Class {
	#name : #AISpDataFrameInspectorTest,
	#superclass : #TestCase,
	#instVars : [
		'dataFrameBrowser'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameInspectorTest >> dataFrameBrowser [
	^ dataFrameBrowser
]

{ #category : #accessing }
AISpDataFrameInspectorTest >> dataFrameBrowser: anObject [
	dataFrameBrowser := anObject
]

{ #category : #accessing }
AISpDataFrameInspectorTest >> entity [

	^ self dataFrameBrowser entity
]

{ #category : #accessing }
AISpDataFrameInspectorTest >> sampleDataFrame [

	^ DataFrame readFromCsvWithRowNames: 'country,child_mort,exports,health,imports,income,inflation,life_expec,total_fer,gdpp
Afghanistan,90.2,10,7.58,44.9,1610,9.44,56.2,5.82,553
Albania,16.6,28,6.55,48.6,9930,4.49,76.3,1.65,4090
Algeria,27.3,38.4,4.17,31.4,12900,16.1,76.5,2.89,4460'.
]

{ #category : #running }
AISpDataFrameInspectorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	dataFrameBrowser := AISpDataFrameInspector on: self sampleDataFrame.
]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryDescriptions [

	self assert: (self dataFrameBrowser summaryDescriptions isKindOf: Dictionary)
]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryDescriptionsLabels [

	self assert: (self dataFrameBrowser summaryDescriptionsLabels isKindOf: Collection).
	self deny: self dataFrameBrowser summaryDescriptionsLabels isEmpty.
]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryDescriptorsAt [

	self assert: (self dataFrameBrowser summaryDescriptorsAt: 'Dimensions') equals: #dimensions.
	self assert: (self dataFrameBrowser summaryDescriptorsAt: 'Has nil') equals: #hasNil.
	self assert: (self dataFrameBrowser summaryDescriptorsAt: 'Has categorical') equals: #hasCategorical.


]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryStats [

	self assert: (self dataFrameBrowser summaryStats isKindOf: Dictionary)
]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryStatsAt [

	self assert: (self dataFrameBrowser summaryStatsAt: 'Average') equals: #average.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Mode') equals: #mode.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Median') equals: #median.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Variance') equals: #variance.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Standard deviation') equals: #stdev.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Minimum') equals: #min.
	self assert: (self dataFrameBrowser summaryStatsAt: 'Maximum') equals: #max.
	self assert: (self dataFrameBrowser summaryStatsAt: '1st Quartile') equals: #firstQuartile.

]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryStatsLabels [

	self assert: (self dataFrameBrowser summaryStatsLabels isKindOf: Collection).
	self deny: self dataFrameBrowser summaryStatsLabels isEmpty.
]

{ #category : #test }
AISpDataFrameInspectorTest >> testSummaryValueFor [

	self assert: (self dataFrameBrowser summaryValueFor: 'Dimensions') equals: '(3@9)'.


]
