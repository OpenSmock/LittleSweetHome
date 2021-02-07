"
I'm a motion sensor (trait).
"
Trait {
	#name : #LSHMotionSensorComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #'accessing - events' }
LSHMotionSensorComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHMaintenanceEvents . LSHMemoryEvents . LSHDetectionEvents . LSHCantTakePhotoEvents }
]

{ #category : #'accessing - services' }
LSHMotionSensorComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHBatteryServices . LSHVisualServices }
]

{ #category : #'accessing - services' }
LSHMotionSensorComponent classSide >> usedComponentServices [
	<componentContract>
	^ {LSHVisualSettingsServices.
	LSHGlobalServices}
]
