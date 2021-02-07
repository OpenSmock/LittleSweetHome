"
I am temperature manager events.
"
Trait {
	#name : #LSHTemperatureManagerEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #'instance creation' }
LSHTemperatureManagerEvents >> newTemperatureSensor: name [
	self explicitRequirement
]
