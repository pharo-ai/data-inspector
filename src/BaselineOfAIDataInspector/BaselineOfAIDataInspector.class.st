Class {
	#name : #BaselineOfAIDataInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDataInspector
}

{ #category : #baselines }
BaselineOfAIDataInspector >> baseline: spec [

	<baseline>
	
	"Pharo 9 support"
	spec for: #'pharo9.x' do: [ 
		self externalDependencies: spec.
		self packages: spec.
		
		spec
			package: 'AI-DataFrameInspectorPharo9'
			with: [ spec requires: #( 'AI-DataFrameInspector' ) ] ].

	"Pharo 10 or >"
	spec for: #( common ) do: [ 
		self externalDependencies: spec.
		self packages: spec.
		self groups: spec ]
]

{ #category : #baselines }
BaselineOfAIDataInspector >> externalDependencies: spec [

	spec
		baseline: 'DataFrame'
		with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ]
]

{ #category : #baselines }
BaselineOfAIDataInspector >> groups: spec [

	^ spec
		  group: 'Core' with: #( 'AI-DataFrameInspector' );
		  group: 'Tests'
		  with: #( 'AI-DataFrameInspector' 'AI-DataFrameInspector-Tests' );
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
