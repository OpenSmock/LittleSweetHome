"
I am temperature sensor manager settings services.
"
Trait {
	#name : #LSHTemperatureSensorManagerSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #adding }
LSHTemperatureSensorManagerSettingsServices >> addTemperatureSensor: name [
	self explicitRequirement
]
