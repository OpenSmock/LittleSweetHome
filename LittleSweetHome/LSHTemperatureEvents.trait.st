"
I'm temperature events.
"
Trait {
	#name : #LSHTemperatureEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHTemperatureEvents >> coldTemperature [
	self explicitRequirement
]

{ #category : #events }
LSHTemperatureEvents >> hotTemperature [
	self explicitRequirement
]
