Class {
	#name : #BaselineOfLittleSweetHome,
	#superclass : #BaselineOf,
	#instVars : [
		'previousDynamicContractUpdateActivated'
	],
	#category : #BaselineOfLittleSweetHome
}

{ #category : #baselines }
BaselineOfLittleSweetHome >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			"Dependencies"
			self molecule: spec.
			"Packages"
			spec package: 'LittleSweetHome'.
		 ]
]

{ #category : #baselines }
BaselineOfLittleSweetHome >> molecule: spec [
	spec
		baseline: 'Molecule'
		with: [ spec repository: 'github://OpenSmock/Molecule/src' ]
]
