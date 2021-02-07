"
I'm temperature settings services to control temperature sensor in the Home Manager.
"
Trait {
	#name : #LSHTemperatureSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHTemperatureSettingsServices >> activateTemperatureRegulation: component and:aBoolean value: value [
	self explicitRequirement
]

{ #category : #services }
LSHTemperatureSettingsServices >> getTemperature: component [
	self explicitRequirement
]
