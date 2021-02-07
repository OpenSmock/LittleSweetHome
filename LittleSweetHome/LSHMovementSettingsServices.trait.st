"
I'm movement settings services to control controlled camera.
"
Trait {
	#name : #LSHMovementSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHMovementSettingsServices >> moveCamera: component horizontally: angleH vertically: angleV [
	self explicitRequirement
]
