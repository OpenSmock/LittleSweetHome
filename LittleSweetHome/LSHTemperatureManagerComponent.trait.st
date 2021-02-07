"
I'm the trait of the Temperature Manager.
"
Trait {
	#name : #LSHTemperatureManagerComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #'accessing - events' }
LSHTemperatureManagerComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHTemperatureManagerEvents}
]

{ #category : #'accessing - services' }
LSHTemperatureManagerComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHTemperatureManagerServices}
]

{ #category : #'accessing - services' }
LSHTemperatureManagerComponent classSide >> usedComponentServices [
	<componentContract>
	^ {	LSHTemperatureSensorManagerSettingsServices}
]
