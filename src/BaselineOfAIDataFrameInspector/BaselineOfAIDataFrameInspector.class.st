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
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
			
		"Packages"
		spec
			package: 'AI-DataFrameInspector' with: [ spec requires: #( 'DataFrame' ) ];
			package: 'AI-DataFrameInspector-Tests' with: [ spec requires: #( 'AI-DataFrameInspector' ) ].
		
		"Groups"
		spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' );
		  group: 'Tests' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
		  group: 'default' with: #( 'Core' 'Tests' ) ]

]
