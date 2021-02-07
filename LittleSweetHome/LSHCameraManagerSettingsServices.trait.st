"
I am camera manager settings services.
"
Trait {
	#name : #LSHCameraManagerSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #adding }
LSHCameraManagerSettingsServices >> addCamera: aClass named: name [
	self explicitRequirement.
]
