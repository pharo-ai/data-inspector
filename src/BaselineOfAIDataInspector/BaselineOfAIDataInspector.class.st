Class {
	#name : #BaselineOfAIDataInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDataInspector
}

{ #category : #baselines }
BaselineOfAIDataInspector >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			"Baselines"
			spec
  				baseline: 'DataFrame'
  				with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
		
			spec 
				package: 'AI-DataFrameInspector'			with: [ spec requires: #('DataFrame') ];
				package: 'AI-DataFrameInspector-Tests'	with: [ spec requires: #('AI-DataFrameInspector') ].
			spec
				group: 'Core' 						with: #('AI-DataFrameInspector');
				group: 'Tests' 						with: #('AI-DataFrameInspector' 'AI-DataFrameInspector-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
