Class {
	#name : #BaselineOfOSC,
	#superclass : #BaselineOf,
	#category : #BaselineOfOSC
}

{ #category : #baselines }
BaselineOfOSC >> baseline: spec [
	<baseline>
	
	spec
		for: #pharo
		do: [ 
			spec
				package: 'OSC'.
			spec
				package: 'OSC-Tests'
				with: [ spec requires: #( 'OSC') ].
			]
]
