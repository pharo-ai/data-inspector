Class {
	#name : #AISpDataFrameAbstractTest,
	#superclass : #TestCase,
	#category : #'AI-DataFrameInspector-Tests'
}

{ #category : #accessing }
AISpDataFrameAbstractTest >> sampleDataFrame [

	^ DataFrame readFromCsvWithRowNames: 'country,child_mort,exports,health,imports,income,inflation,life_expec,total_fer,gdpp
Afghanistan,90.2,10,7.58,44.9,1610,9.44,56.2,5.82,553
Albania,16.6,28,6.55,48.6,9930,4.49,76.3,1.65,4090
Algeria,27.3,38.4,4.17,31.4,12900,16.1,76.5,2.89,4460'.
]
