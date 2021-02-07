"
I'm movement events.
"
Trait {
	#name : #LSHMovementEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHMovementEvents >> cantMove: compName [
	self explicitRequirement
]
