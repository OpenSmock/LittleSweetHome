"
I'm a temperature sensor (trait).
Ce composant a pour but de mesurer la température, d’une pièce par exemple. Il doit pouvoir simplement mesurer la température mais également si besoin alerter lorsque cette dernière est trop basse ou trop élevée. L’utilisateur doit donc avoir la capacité de demander une température et de connaitre la température mesurée.
"
Trait {
	#name : #LSHTemperatureSensorComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Sensors Contracts'
}

{ #category : #'accessing - events' }
LSHTemperatureSensorComponent classSide >> producedComponentEvents [
	<componentContract>
	^ {LSHMaintenanceEvents . LSHTemperatureEvents }
]

{ #category : #'accessing - services' }
LSHTemperatureSensorComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHBatteryServices . LSHTemperatureServices }
]

{ #category : #'accessing - services' }
LSHTemperatureSensorComponent classSide >> usedComponentServices [
	<componentContract>
	^ {LSHGlobalServices . LSHTemperatureSettingsServices }
]
