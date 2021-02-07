"
I'm the home manager (trait).
Il a pour but de gérer l’ensemble des composants sans pour autant les connaitre directement. En effet, les  composants matériels sont stockés dans les variables d’instance locales du CameraManager et du TemperatureSensorManager. Il y accède donc par leur intermédiaire. Le homeManager a également pour objectif de demander la création et de régler les paramètres des différents composants. Aussi, il récupère toutes les demandes de l’utilisateur pour exécuter via les services. Il fait également remonter à l’utilisateur les informations des composants via l’écoute de la totalité des événements émis.
"
Trait {
	#name : #LSHHomeManagerComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'LittleSweetHome-Managers Contracts'
}

{ #category : #'accessing - events' }
LSHHomeManagerComponent classSide >> consumedComponentEvents [
	<componentContract>
	^ {LSHMovementEvents.
	LSHMaintenanceEvents.
	LSHMemoryEvents.
	LSHDetectionEvents.
	LSHTemperatureEvents.
	LSHCantTakePhotoEvents.
	LSHCameraManagerEvents.
	LSHTemperatureManagerEvents}
]

{ #category : #'accessing - services' }
LSHHomeManagerComponent classSide >> providedComponentServices [
	<componentContract>
	^ {LSHVisualSettingsServices.
	LSHGlobalServices.
	LSHTemperatureSettingsServices.
	LSHMovementSettingsServices.
	LSHRecordingSettingsServices.
	LSHCameraManagerSettingsServices. LSHTemperatureSensorManagerSettingsServices }
]

{ #category : #'accessing - services' }
LSHHomeManagerComponent classSide >> usedComponentServices [
	<componentContract>
	^ {LSHCameraManagerServices.
	LSHBatteryServices.
	LSHMovementServices.
	LSHVisualServices.
	LSHRecordingServices.
	LSHTemperatureServices. LSHTemperatureManagerServices }
]
