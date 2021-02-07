"
I'm memory events.
"
Trait {
	#name : #LSHMemoryEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHMemoryEvents >> memoryFull: component [
	self explicitRequirement
]
