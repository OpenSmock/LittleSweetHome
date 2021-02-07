"
I notify others that a component has detected something anormal.
"
Trait {
	#name : #LSHDetectionEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHDetectionEvents >> movementDetected: component [
	self explicitRequirement
]
