"
I'm movement services for controlled camera.
"
Trait {
	#name : #LSHMovementServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHMovementServices >> moveHorizontally: angle [
	self explicitRequirement
]

{ #category : #services }
LSHMovementServices >> moveVertically: angle [
	self explicitRequirement
]
