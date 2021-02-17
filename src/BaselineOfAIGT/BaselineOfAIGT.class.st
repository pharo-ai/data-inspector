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
			spec 
				package: 'AI-GT'.
				"package: 'AI-GT-Tests'	with: [ spec requires: #(#'AI-GT') ]."
			spec 
				group: 'Core' 						with: #(#'AI-GT');
				"group: 'Tests' 						with: #(#'AI-GT' #'AI-GT-Tests');"
				group: 'default' 					with: #('Core' "'Tests'") ]
]
