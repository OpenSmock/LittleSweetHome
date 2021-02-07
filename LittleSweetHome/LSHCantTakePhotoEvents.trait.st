"
I notify others that the component can't take photos.
"
Trait {
	#name : #LSHCantTakePhotoEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #events }
LSHCantTakePhotoEvents >> cantTakePhoto: compName [
	self explicitRequirement
]
