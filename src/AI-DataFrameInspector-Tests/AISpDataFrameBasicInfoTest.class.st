Class {
	#name : #AISpDataFrameBasicInfoTest,
	#superclass : #AISpDataFrameAbstractTest,
	#instVars : [
		'dfBrowser'
	],
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameBasicInfoTest >> dfBrowser [
	^ dfBrowser
]

{ #category : #accessing }
AISpDataFrameBasicInfoTest >> entity [

	^ self dfBrowser entity
]

{ #category : #running }
AISpDataFrameBasicInfoTest >> setUp [

	dfBrowser := AISpDataFrameBasicInfo on: self sampleDataFrame
]

{ #category : #tests }
AISpDataFrameBasicInfoTest >> testSummaryDescriptions [

	self assert:
		(self dfBrowser summaryDescriptions isKindOf: Dictionary)
]

{ #category : #tests }
AISpDataFrameBasicInfoTest >> testSummaryDescriptionsLabels [

	self
		assertCollection: self dfBrowser summaryDescriptionsLabels
		hasSameElements: { 'Dimensions'. 'Has nil'. 'Has categorical' }
]

{ #category : #tests }
AISpDataFrameBasicInfoTest >> testSummaryValueFor [

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
