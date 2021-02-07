"
I am a temperature manager (class).
"
Class {
	#name : #LSHTemperatureManagerComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHTemperatureManagerComponent + LSHTemperatureManagerServices',
	#classTraits : 'LSHTemperatureManagerComponent classTrait + LSHTemperatureManagerServices classTrait',
	#instVars : [
		'temperatureSensorDict'
	],
	#category : #'LittleSweetHome-Managers Components'
}

{ #category : #services }
LSHTemperatureManagerComponentImpl >> addSensor: aClass named: name [
	| manager sensor |
	"Check if the sensor doesnt exists"
	(self getSensor: name) ifNotNil:[ ^ self ].
	manager := MolComponentManager default.
	"Instanciation"
	sensor := manager homeServices instanciateComponent: aClass named: name.
	"Activation"
	manager homeServices activateComponent: aClass named: name.
	sensor name: name.
	self temperatureSensorDict at: name put: sensor.
	self getLSHTemperatureManagerEventsNotifier newTemperatureSensor: name
]

{ #category : #'life cycle' }
LSHTemperatureManagerComponentImpl >> componentActivate [
	'temperature manager activated.' traceCr.
]

{ #category : #'life cycle' }
LSHTemperatureManagerComponentImpl >> componentInitialize [
	"On déploie l'ensemble des classes de sonde de température pour permettre leurs potentielles créations ensuite. On ne peut pas le faire lors de la craétion car on risquerait de déployer plusieurs fois une meme classe."
	"Deployment of cameras class to permit creation then."
	self deploymentTemperatureSensor.
	self forServices: LSHTemperatureSensorManagerSettingsServices useProvider: #homeManager.
	"key: sensorName value: Sensor"
	self temperatureSensorDict: Dictionary new
]

{ #category : #'life cycle' }
LSHTemperatureManagerComponentImpl >> componentPassivate [
	LSHTemperatureSensorComponentImpl undeploy.
	'temperature manager passivated.' traceCr
]

{ #category : #'life cycle' }
LSHTemperatureManagerComponentImpl >> componentRemove [
	self temperatureSensorDict: nil.
]

{ #category : #'life cycle' }
LSHTemperatureManagerComponentImpl >> deploymentTemperatureSensor [
	LSHTemperatureSensorComponentImpl deploy.
]

{ #category : #'component accessing' }
LSHTemperatureManagerComponentImpl >> getLSHTemperatureManagerEventsNotifier [
	^self eventsNotifiers at: LSHTemperatureManagerEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHTemperatureManagerEvents name: nil].
]

{ #category : #'component accessing' }
LSHTemperatureManagerComponentImpl >> getLSHTemperatureSensorManagerSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHTemperatureSensorManagerSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHTemperatureSensorManagerSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #services }
LSHTemperatureManagerComponentImpl >> getSensor: name [
	self temperatureSensorDict
		keysAndValuesDo: [ :k :v | 
			name = k
				ifTrue: [ ^ v ] ]
]

{ #category : #accessing }
LSHTemperatureManagerComponentImpl >> temperatureSensorDict [
	^ temperatureSensorDict
]

{ #category : #accessing }
LSHTemperatureManagerComponentImpl >> temperatureSensorDict: anObject [
	temperatureSensorDict := anObject
]
