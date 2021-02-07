"
I'm a controlled camera (trait).
"
Trait {
	#name : #LSHControlledCameraComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #'accessing - events' }
LSHControlledCameraComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHMovementEvents . LSHMaintenanceEvents . LSHMemoryEvents . LSHDetectionEvents}
]

{ #category : #'accessing - services' }
LSHControlledCameraComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHBatteryServices . LSHMovementServices . LSHVisualServices . LSHRecordingServices }
]

{ #category : #'accessing - services' }
LSHControlledCameraComponent classSide >> usedComponentServices [
	<componentContract>
	^ {LSHVisualSettingsServices.
	LSHGlobalServices.
	LSHMovementSettingsServices.
	LSHRecordingSettingsServices}
]
