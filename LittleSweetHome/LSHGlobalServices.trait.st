"
I'm global services.
"
Trait {
	#name : #LSHGlobalServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHGlobalServices >> batteryLevel: component [
	self explicitRequirement
]
