"
I'm recording settings services to control the recording of cameras.
"
Trait {
	#name : #LSHRecordingSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHRecordingSettingsServices >> choosePeriod: component during: time [
	self explicitRequirement
]
