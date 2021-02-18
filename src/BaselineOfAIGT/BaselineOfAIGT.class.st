Class {
	#name : #BaselineOfAIGT,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIGT
}

{ #category : #baselines }
BaselineOfAIGT >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			"Baselines"
			spec
  				baseline: 'DataFrame'
  				with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
		
			spec 
				package: 'AI-GT'			with: [ spec requires: #('DataFrame') ];
				package: 'AI-GT-Tests'	with: [ spec requires: #('AI-GT') ].
			spec 
				group: 'Core' 						with: #('AI-GT');
				group: 'Tests' 						with: #('AI-GT' 'AI-GT-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
