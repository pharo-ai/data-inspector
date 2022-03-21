Class {
	#name : #AISpDataFrameBasicInfoPresenterTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfBrowser'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameBasicInfoPresenterTest >> dfBrowser [
	^ dfBrowser
]

{ #category : #accessing }
AISpDataFrameBasicInfoPresenterTest >> entity [

	^ self dfBrowser entity
]

{ #category : #running }
AISpDataFrameBasicInfoPresenterTest >> setUp [

	super setUp.
	dfBrowser := AISpDataFrameBasicInfoPresenter on: self sampleDataFrame
]

{ #category : #tests }
AISpDataFrameBasicInfoPresenterTest >> testInitializePresenters [

	self
		assertCollection: dfBrowser dataFrameBasicInfoPresenter items
		hasSameElements: dfBrowser summaryDescriptionsLabels
]

{ #category : #tests }
AISpDataFrameBasicInfoPresenterTest >> testSummaryDescriptions [

	self assert:
		(self dfBrowser summaryDescriptions isKindOf: Dictionary)
]

{ #category : #tests }
AISpDataFrameBasicInfoPresenterTest >> testSummaryDescriptionsLabels [

	self
		assertCollection: self dfBrowser summaryDescriptionsLabels
		hasSameElements: { 'Dimensions'. 'Has nil'. 'Has categorical' }
]

{ #category : #tests }
AISpDataFrameBasicInfoPresenterTest >> testSummaryDescriptorsAt [

	self
		assert: (self dfBrowser summaryDescriptorsAt: 'Dimensions')
		equals: #dimensions.
	self
		assert: (self dfBrowser summaryDescriptorsAt: 'Has nil')
		equals: #hasNil.
	self
		assert: (self dfBrowser summaryDescriptorsAt: 'Has categorical')
		equals: #hasCategorical
]

{ #category : #tests }
AISpDataFrameBasicInfoPresenterTest >> testSummaryValueFor [

	self
		assert: (self dfBrowser summaryValueFor: 'Dimensions')
		equals: '(3@9)'.
		self
		assert: (self dfBrowser summaryValueFor: 'Has nil')
		equals: 'false'.
		self
		assert: (self dfBrowser summaryValueFor: 'Has categorical')
		equals: 'false'.
]
