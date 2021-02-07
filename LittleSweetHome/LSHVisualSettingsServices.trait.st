"
I'm visual settings services to control cameras.
"
Trait {
	#name : #LSHVisualSettingsServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #services }
LSHVisualSettingsServices >> activateIR: component and: aBoolean [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> copyPhoto: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> copyVideo: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> listPhoto: component [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> listVideo: component [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> removePhoto: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> removeVideo: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> takePhoto: component [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> transferPhoto: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> transferVideo: component named: listname [
	self explicitRequirement
]

{ #category : #services }
LSHVisualSettingsServices >> zoom: component and: aBoolean value: value [
	self explicitRequirement
]
