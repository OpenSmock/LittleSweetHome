"
I'm a fixed camera (trait).
"
Trait {
	#name : #LSHFixedCameraComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #'accessing - events' }
LSHFixedCameraComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHMaintenanceEvents.
	LSHMemoryEvents.
	LSHDetectionEvents }
]

{ #category : #'accessing - services' }
LSHFixedCameraComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHBatteryServices . LSHVisualServices . LSHRecordingServices }
]

{ #category : #'accessing - services' }
LSHFixedCameraComponent classSide >> usedComponentServices [
	<componentContract>
	^ {LSHVisualSettingsServices.
	LSHGlobalServices.
	LSHRecordingSettingsServices}
]
