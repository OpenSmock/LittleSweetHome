"
I'm visual services for cameras.
"
Trait {
	#name : #LSHVisualServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHVisualServices >> copyPhoto: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> copyVideo: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> getPhoto [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> toggleVideoIR: aBoolean [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> transferPhotoNames [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> transferVideoNames [
	self explicitRequirement
]

{ #category : #services }
LSHVisualServices >> zoom: aBoolean value: value [
	self explicitRequirement
]
