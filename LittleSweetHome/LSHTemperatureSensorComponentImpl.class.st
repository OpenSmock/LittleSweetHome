"
I'm a temperature sensor component (class).
"
Class {
	#name : #LSHTemperatureSensorComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHTemperatureSensorComponent + LSHBatteryServices + LSHTemperatureServices',
	#classTraits : 'LSHTemperatureSensorComponent classTrait + LSHBatteryServices classTrait + LSHTemperatureServices classTrait',
	#instVars : [
		'name',
		'selectedTemperature',
		'battery',
		'temperature'
	],
	#category : #'LittleSweetHome-Sensors Components'
}

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> battery [
	^ battery
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> battery: anObject [
	battery := anObject
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> batteryLevel [
	(self name1 printString , ' battery : ' , self battery printString) traceCr
]

{ #category : #'life cycle' }
LSHTemperatureSensorComponentImpl >> componentActivate [
	'Temperature sensor activated' traceCr
]

{ #category : #'life cycle' }
LSHTemperatureSensorComponentImpl >> componentInitialize [
	self forServices: LSHGlobalServices useProvider: #homeManager.
	self forServices: LSHTemperatureSettingsServices useProvider: #homeManager.
	"Local Instanciation"
	self selectedTemperature: nil.
	self battery: 100.
	self temperature: 20
]

{ #category : #'life cycle' }
LSHTemperatureSensorComponentImpl >> componentPassivate [
	'Temperature sensor passivated' traceCr
]

{ #category : #'life cycle' }
LSHTemperatureSensorComponentImpl >> componentRemove [
	self selectedTemperature: nil.
	self battery: nil.
	self temperature: nil
]

{ #category : #'component accessing' }
LSHTemperatureSensorComponentImpl >> getLSHGlobalServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHGlobalServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHGlobalServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHTemperatureSensorComponentImpl >> getLSHMaintenanceEventsNotifier [
	^self eventsNotifiers at: LSHMaintenanceEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMaintenanceEvents name: nil].
]

{ #category : #'component accessing' }
LSHTemperatureSensorComponentImpl >> getLSHTemperatureEventsNotifier [
	^self eventsNotifiers at: LSHTemperatureEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHTemperatureEvents name: nil].
]

{ #category : #'component accessing' }
LSHTemperatureSensorComponentImpl >> getLSHTemperatureSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHTemperatureSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHTemperatureSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> measureTemperature: temp [
	| rand |
	"If the temperature is nil, the sencor measure temperature only but doesnt alert if the temperature is not the good one."
	self selectedTemperature: temp.
	temp isNil
		ifTrue: [ (self name1 printString , ' measure temperature.') traceCr ]
		ifFalse: [ rand := Random new.
			rand next > 0.8
				ifTrue: [ "Probability of 0.8 to have the temperature of the room been the selected temperature."
					self temperature: temp.
					('The temperature has to be at ' , temp printString , ' degrees.') traceCr ]
				ifFalse: [ ('The temperature has to be at ' , temp printString , ' degrees.') traceCr ].
			"If the temperature of the room is the wrong one, the alarm is activated."
			selectedTemperature = temperature
				ifFalse: [ selectedTemperature > temperature
						ifTrue: [ self getLSHTemperatureEventsNotifier hotTemperature ]
						ifFalse: [ self getLSHTemperatureEventsNotifier coldTemperature ] ] ]
	"If the temperature of the room is the wrong one, the alarm is activated."
	"selectedTemperature = temperature
		ifFalse: [ selectedTemperature > temperature
				ifTrue: [ self getLSHTemperatureEventsNotifier hotTemperature ]
				ifFalse: [ self getLSHTemperatureEventsNotifier coldTemperature ] ]"
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> name1 [
	^ name
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> name: anObject [
	name := anObject
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> raiseBatteryEmptyEvents [
	self battery < 5
		ifTrue: [ self getLSHMaintenanceEventsNotifier batteryEmpty: self name1 -> self battery ]
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> raiseRandomInternalErrorEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have an internal error"
	rand next < 0.2
		ifTrue: [ self getLSHMaintenanceEventsNotifier internalError: self name1 ]
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> raiseSimulatedEvents [
	self raiseBatteryEmptyEvents.
	self raiseRandomInternalErrorEvents
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> selectedTemperature [
	^ selectedTemperature
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> selectedTemperature: anObject [
	selectedTemperature := anObject
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> temperature [
	^ temperature
]

{ #category : #accessing }
LSHTemperatureSensorComponentImpl >> temperature: anObject [
	temperature := anObject
]

{ #category : #services }
LSHTemperatureSensorComponentImpl >> transferTemperature [
	self temperature.
]
