"
I'm temperature services for temperature sensor.
"
Trait {
	#name : #LSHTemperatureServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHTemperatureServices >> measureTemperature: temperature [
	self explicitRequirement
]

{ #category : #services }
LSHTemperatureServices >> transferTemperature [
	self explicitRequirement
]
