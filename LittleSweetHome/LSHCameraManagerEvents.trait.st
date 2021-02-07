"
I am Camera Manager Events.
"
Trait {
	#name : #LSHCameraManagerEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #'instance creation' }
LSHCameraManagerEvents >> newCamera: aClass named: name [
	self explicitRequirement
]
