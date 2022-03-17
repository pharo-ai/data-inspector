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
		
			"Packages"
			spec 
				package: 'AI-DataFrameInspector' with: [ spec requires: #('DataFrame') ];
				package: 'AI-DataFrameInspector-Tests' with: [ spec requires: #('AI-DataFrameInspector') ].
			
			"Pharo 9 support"
			spec
				for: #'pharo9.x'
				do: [
					spec package: 'AI-DataFrameInspector'.
					spec package: 'AI-DataFrameInspectorPharo9' with: [ spec requires: #('AI-DataFrameInspector') ] ].
			
			"Groups"
			spec
				group: 'Core' with: #('AI-DataFrameInspector');
				group: 'Tests' with: #('AI-DataFrameInspector' 'AI-DataFrameInspector-Tests');
				group: 'default' with: #('Core' 'Tests') ].
]
