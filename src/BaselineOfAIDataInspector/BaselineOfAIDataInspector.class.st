Class {
	#name : #BaselineOfAIDataInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDataInspector
}

{ #category : #baselines }
BaselineOfAIDataInspector >> baseline: spec [

	<baseline>
	
	spec for: #( common ) do: [ 
		self externalDependencies: spec.
		self packages: spec.
		
		spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' );
		  group: 'Tests' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
		  group: 'default' with: #( 'Core' 'Tests' ) ].
	
	"Pharo 9 support"
	spec for: #'pharo9.x' do: [ 
		self externalDependencies: spec.
		self packages: spec.
		
		spec
			package: 'AI-DataFrameInspectorPharo9'
			with: [ spec requires: #( 'AI-DataFrameInspector' ) ].
		
		"Add AI-DataFrameInspectorPharo9 to the Core group"
		spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspectorPharo9' );
		  group: 'Tests' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
		  group: 'default' with: #( 'Core' 'Tests' )].

]

{ #category : #baselines }
BaselineOfAIDataInspector >> externalDependencies: spec [

	spec
		baseline: 'DataFrame'
		with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3:v0.9.9f' ]
]

{ #category : #baselines }
BaselineOfAIDataInspector >> groups: spec [

	^ spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' );
		  group: 'Tests' with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
		  group: 'default' with: #( 'Core' 'Tests' )
]

{ #category : #baselines }
BaselineOfAIDataInspector >> packages: spec [

	spec
		package: 'AI-DataFrameInspector'
		with: [ spec requires: #( 'DataFrame' ) ];
		package: 'AI-DataFrameInspector-Tests'
		with: [ spec requires: #( 'AI-DataFrameInspector' ) ]
]
