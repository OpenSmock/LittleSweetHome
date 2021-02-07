"
I'm recording services.
"
Trait {
	#name : #LSHRecordingServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHRecordingServices >> recordVideo: time [
	self explicitRequirement
]

{ #category : #services }
LSHRecordingServices >> stopRecordVideo [
	self explicitRequirement
]
