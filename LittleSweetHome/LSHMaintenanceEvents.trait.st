"
I'm maintenance events.
"
Trait {
	#name : #LSHMaintenanceEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHMaintenanceEvents >> batteryEmpty: component [
	self explicitRequirement
]

{ #category : #events }
LSHMaintenanceEvents >> internalError: component [
	self explicitRequirement
]
