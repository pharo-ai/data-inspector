"
I am a baseline
"
Class {
	#name : #BaselineOfAIDataFrameInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDataFrameInspector
}

{ #category : #baselines }
BaselineOfAIDataFrameInspector >> baseline: spec [

	<baseline>
	
	spec for: #( common ) do: [ 
		"External dependencies"
		spec
    			baseline: 'AIExternalRoassal3'
    			with: [ spec repository: 'github://pharo-ai/external-dependencies' ].
		spec
    			baseline: 'AIExternalDataFrame'
    			with: [ spec repository: 'github://pharo-ai/external-dependencies' ].
			
		"pharo-ai dependencies"
		spec 
			baseline: 'AIMetrics' 
			with: [ spec repository: 'github://pharo-ai/metrics' ].
		
		"Packages"
		spec
			package: 'AI-DataFrameInspector' with: [ spec requires: #( 'AIExternalDependencies' ) ];
			package: 'AI-MetricsInspector' with: [ spec requires: #('AIMetrics') ];
			package: 'AI-DataFrameInspector-Tests' with: [ spec requires: #( 'AI-DataFrameInspector' ) ].
		
		"Groups"
		spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' 'AI-MetricsInspector' );
		  group: 'Tests' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
		  group: 'default' with: #( 'Core' 'Tests' ) ]

]
