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

	dfBrowser := AISpDataFrameBasicInfo on: self sampleDataFrame.
]

{ #category : #test }
AISpDataFrameBasicInfoTest >> testSummaryDescriptions [

	self assert: (self dfBrowser summaryDescriptions isKindOf: Dictionary)
]

{ #category : #test }
AISpDataFrameBasicInfoTest >> testSummaryDescriptionsLabels [

	self assert: (self dfBrowser summaryDescriptionsLabels isKindOf: Collection).
	self deny: self dfBrowser summaryDescriptionsLabels isEmpty.
]

{ #category : #test }
AISpDataFrameBasicInfoTest >> testSummaryValueFor [

	self assert: (self dfBrowser summaryValueFor: 'Dimensions') equals: '(3@9)'.


]
