"
I'm camera manager services.
"
Trait {
	#name : #LSHCameraManagerServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #services }
LSHCameraManagerServices >> addCamera: aClass named: name [
	self explicitRequirement
]

{ #category : #services }
LSHCameraManagerServices >> getCamera: name [
	self explicitRequirement
]
