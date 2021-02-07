"
I am Temperature Manager services.
"
Trait {
	#name : #LSHTemperatureManagerServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #adding }
LSHTemperatureManagerServices >> addSensor: aClass named: name [
	self explicitRequirement
]

{ #category : #services }
LSHTemperatureManagerServices >> getSensor: name [
	self explicitRequirement
]
