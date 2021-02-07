"
I'm battery services.
"
Trait {
	#name : #LSHBatteryServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHBatteryServices >> batteryLevel [
	self explicitRequirement
]
