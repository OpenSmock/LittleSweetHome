"
I'm a camera manager (trait).
"
Trait {
	#name : #LSHCameraManagerComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #'accessing - events' }
LSHCameraManagerComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHCameraManagerEvents}
]

{ #category : #'accessing - services' }
LSHCameraManagerComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHCameraManagerServices}
]

{ #category : #'accessing - services' }
LSHCameraManagerComponent classSide >> usedComponentServices [
	<componentContract>
	^ {	LSHCameraManagerSettingsServices}
]
