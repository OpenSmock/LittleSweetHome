"
I'm a home manager component (class).
"
Class {
	#name : #LSHHomeManagerComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHHomeManagerComponent + LSHMovementEvents + LSHMaintenanceEvents + LSHMemoryEvents + LSHDetectionEvents + LSHTemperatureEvents + LSHCantTakePhotoEvents + LSHVisualSettingsServices + LSHGlobalServices + LSHTemperatureSettingsServices + LSHMovementSettingsServices + LSHRecordingSettingsServices + LSHCameraManagerEvents + LSHTemperatureManagerEvents + LSHCameraManagerSettingsServices + LSHTemperatureSensorManagerSettingsServices',
	#classTraits : 'LSHHomeManagerComponent classTrait + LSHMovementEvents classTrait + LSHMaintenanceEvents classTrait + LSHMemoryEvents classTrait + LSHDetectionEvents classTrait + LSHTemperatureEvents classTrait + LSHCantTakePhotoEvents classTrait + LSHVisualSettingsServices classTrait + LSHGlobalServices classTrait + LSHTemperatureSettingsServices classTrait + LSHMovementSettingsServices classTrait + LSHRecordingSettingsServices classTrait + LSHCameraManagerEvents classTrait + LSHTemperatureManagerEvents classTrait + LSHCameraManagerSettingsServices classTrait + LSHTemperatureSensorManagerSettingsServices classTrait',
	#instVars : [
		'temperature',
		'camNames',
		'tempSensorNames',
		'photoNamesDict',
		'videoNamesDict',
		'photoDict',
		'videoDict'
	],
	#category : #'LittleSweetHome-Managers Components'
}

{ #category : #'accessing - events' }
LSHHomeManagerComponentImpl class >> consumedComponentEvents [
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

{ #category : #services }
LSHHomeManagerComponentImpl >> activateIR: component and: aBoolean [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self ].
	componentused toggleVideoIR: aBoolean
]

{ #category : #services }
LSHHomeManagerComponentImpl >> activateTemperatureRegulation: component and: aBoolean value: value [
	| componentused |
	componentused := self getLSHTemperatureManagerServicesProvider getSensor: component.
	componentused ifNil:[ ^ self].
	aBoolean
		ifTrue: [ componentused measureTemperature: value ].
]

{ #category : #services }
LSHHomeManagerComponentImpl >> addCamera: aClass named: name [
	| cameraManager |
	cameraManager := self getLSHCameraManagerServicesProvider.
	cameraManager addCamera: aClass named: name.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> addTemperatureSensor: name [
	| temperatureManager |
	self tempSensorNames add: name.
	temperatureManager := self getLSHTemperatureManagerServicesProvider.
	temperatureManager addSensor: LSHTemperatureSensorComponentImpl named: name.
]

{ #category : #events }
LSHHomeManagerComponentImpl >> batteryEmpty: component [
	'the battery of ', component printString , ' is empty.' traceCr.
	
]

{ #category : #services }
LSHHomeManagerComponentImpl >> batteryLevel: compName [
	| componentused isTemperatureSensor |
	"know the component nature (temperature sensor or camera)."
	isTemperatureSensor := false.
	self tempSensorNames do: [ :name | 
			name = compName
				ifTrue: [ isTemperatureSensor := true ] ].
	isTemperatureSensor traceCr.
	isTemperatureSensor
		ifTrue: [ componentused := self getLSHTemperatureManagerServicesProvider getSensor: compName.
			componentused ifNil:[ ^ self].
			componentused traceCr.
			componentused batteryLevel ]
		ifFalse: [ componentused := self getLSHCameraManagerServicesProvider getCamera: compName.
			componentused ifNil:[ ^ self].
			componentused traceCr.
			componentused batteryLevel ]
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> camNames [
	^ camNames
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> camNames: anObject [
	camNames := anObject
]

{ #category : #events }
LSHHomeManagerComponentImpl >> cantMove: compName [
	(compName printString , ' cant move.') traceCr
]

{ #category : #events }
LSHHomeManagerComponentImpl >> cantTakePhoto: compName [
	(compName printString , ' cant take photos.') traceCr.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> choosePeriod: component during: time [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self ].
	time isNil
		ifTrue: [ componentused stopRecordVideo ]
		ifFalse: [ componentused recordVideo: time ]
]

{ #category : #events }
LSHHomeManagerComponentImpl >> coldTemperature [
	'The temperature of the house is too cold.' traceCr
]

{ #category : #'life cycle' }
LSHHomeManagerComponentImpl >> componentActivate [
	self getLSHCameraManagerEventsSubscriber subscribe: self.
	self getLSHTemperatureManagerEventsSubscriber subscribe: self
]

{ #category : #'life cycle' }
LSHHomeManagerComponentImpl >> componentInitialize [
	self forServices: LSHCameraManagerServices useProvider: #cameraManager.
	self forServices: LSHTemperatureManagerServices useProvider: #temperatureManager.
	self forEvents: LSHCameraManagerEvents useProducer: #cameraManager.
	self forEvents: LSHTemperatureManagerEvents useProducer: #temperatureManager.

	"A dictionary to store cameras names, key:cameraNature value: orderedCollection with cameras names"
	self camNames: Dictionary new.
	"An orderedCollection to store temperature sensors names."
	self tempSensorNames: OrderedCollection new.
	"A dictionary to store photos names, key: cameraName value: OrderedCollection with photo names"
	self photoNamesDict: Dictionary new.
	"A dictionary to store video names, key: cameraName value: OrderedCollection with vide names"
	self videoNamesDict: Dictionary new.
	"A dictionary to store photos, key: cameraName value: (dictionary, key: photoName value: OrderedCollection of photos)"
	self photoDict: Dictionary new.
	"A dictionary to store videos, key: cameraName value: (dictionary, key: videoName value: OrderedCollection of videos)"
	self videoDict: Dictionary new.
	"measured temperature"
	self temperature: nil
]

{ #category : #'life cycle' }
LSHHomeManagerComponentImpl >> componentPassivate [
	self getLSHCameraManagerEventsSubscriber unsubscribe: self.
	self getLSHTemperatureManagerEventsSubscriber unsubscribe: self
]

{ #category : #'life cycle' }
LSHHomeManagerComponentImpl >> componentRemove [
	self camNames: nil.
	self tempSensorNames: nil.
	self photoNamesDict: nil.
	self videoNamesDict: nil.
	self photoDict: nil.
	self videoDict: nil.
	self temperature: nil.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> copyPhoto:  component named: listname [
	|componentused|
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused copyPhoto: listname
]

{ #category : #services }
LSHHomeManagerComponentImpl >> copyVideo: component named: listname [
	|componentused|
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused copyVideo: listname
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHBatteryServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHBatteryServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHBatteryServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHCameraManagerEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHCameraManagerEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHCameraManagerEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHCameraManagerServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHCameraManagerServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHCameraManagerServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHCantTakePhotoEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHCantTakePhotoEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHCantTakePhotoEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHDetectionEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHDetectionEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHDetectionEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHMaintenanceEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHMaintenanceEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHMaintenanceEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHMemoryEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHMemoryEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHMemoryEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHMovementEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHMovementEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHMovementEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHMovementServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHMovementServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHMovementServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHRecordingServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHRecordingServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHRecordingServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHTemperatureEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHTemperatureEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHTemperatureEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHTemperatureManagerEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := LSHTemperatureManagerEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: LSHTemperatureManagerEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHTemperatureManagerServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHTemperatureManagerServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHTemperatureManagerServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHTemperatureServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHTemperatureServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHTemperatureServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHHomeManagerComponentImpl >> getLSHVisualServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHVisualServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHVisualServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #services }
LSHHomeManagerComponentImpl >> getTemperature: component [
	| usedcomponent |
	usedcomponent := self getLSHTemperatureManagerServicesProvider getSensor: component.
	usedcomponent ifNil:[ ^ self].
	self temperature: usedcomponent transferTemperature
]

{ #category : #events }
LSHHomeManagerComponentImpl >> hotTemperature [
	'The temperature of the house is too hot.' traceCr
]

{ #category : #events }
LSHHomeManagerComponentImpl >> internalError: component [
	('There is an internal error in the ', component printString) traceCr.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> listPhoto: component [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self].
	componentused transferPhotoNames.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> listVideo: component [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self].
	componentused transferVideoNames
]

{ #category : #events }
LSHHomeManagerComponentImpl >> memoryFull: component [
	('The memory of the ', component printString, ' is full.') traceCr.
]

{ #category : #services }
LSHHomeManagerComponentImpl >> moveCamera: component horizontally: angleH vertically: angleV [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused moveHorizontally: angleH.
	componentused moveVertically: angleV
]

{ #category : #events }
LSHHomeManagerComponentImpl >> movementDetected: component [
	('WARNING a movement is detected by the ', component printString) traceCr.
]

{ #category : #events }
LSHHomeManagerComponentImpl >> newCamera: aClass named: name [
	| controlledCameras fixedCameras motionSensors allCameras allComponents |
	"unsuscribe cameras events to be able to add producers"
	self getLSHCantTakePhotoEventsSubscriber unsubscribe: self.
	self getLSHDetectionEventsSubscriber unsubscribe: self.
	self getLSHMaintenanceEventsSubscriber unsubscribe: self.
	self getLSHMemoryEventsSubscriber unsubscribe: self.
	self getLSHMovementEventsSubscriber unsubscribe: self.

	"Get components"
	controlledCameras := self camNames
		at: LSHControlledCameraComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	fixedCameras := self camNames
		at: LSHFixedCameraComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	motionSensors := self camNames
		at: LSHMotionSensorComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	allCameras := OrderedCollection new.
	allCameras addAll: controlledCameras.
	allCameras addAll: fixedCameras.
	allCameras addAll: motionSensors.
	allComponents := allCameras copy.
	allComponents addAll: self tempSensorNames.

	"Add producers"
	self forEvents: LSHCantTakePhotoEvents useAllProducers: motionSensors.
	self forEvents: LSHDetectionEvents useAllProducers: allCameras.
	self forEvents: LSHMaintenanceEvents useAllProducers: allComponents.
	self forEvents: LSHMemoryEvents useProducer: allCameras.
	self forEvents: LSHMovementEvents useProducer: controlledCameras.

	"Suscribe to listen events of the producers"
	self getLSHDetectionEventsSubscriber subscribe: self.
	self getLSHMaintenanceEventsSubscriber subscribe: self.
	self getLSHMemoryEventsSubscriber subscribe: self.
	motionSensors isEmpty
		ifFalse: [ self getLSHCantTakePhotoEventsSubscriber subscribe: self ].
	controlledCameras isEmpty
		ifFalse: [ self getLSHMovementEventsSubscriber subscribe: self ]
]

{ #category : #events }
LSHHomeManagerComponentImpl >> newTemperatureSensor: name [
	| controlledCameras fixedCameras motionSensors all |
	"Unsubscribe events to add producers"
	self getLSHTemperatureEventsSubscriber unsubscribe: self.
	self getLSHMaintenanceEventsSubscriber unsubscribe: self.

	"get all components"
	controlledCameras := self camNames
		at: LSHControlledCameraComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	fixedCameras := self camNames
		at: LSHFixedCameraComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	motionSensors := self camNames
		at: LSHMotionSensorComponentImpl printString
		ifAbsent: [ OrderedCollection new ].
	all := OrderedCollection new.
	all addAll: controlledCameras.
	all addAll: fixedCameras.
	all addAll: motionSensors.
	all addAll: self tempSensorNames.

	"Add producers"
	self forEvents: LSHTemperatureEvents useAllProducers: self tempSensorNames.
	self forEvents: LSHMaintenanceEvents useAllProducers: all.

	"Suscribe events"
	self getLSHTemperatureEventsSubscriber subscribe: self.
	self getLSHMaintenanceEventsSubscriber subscribe: self
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> photoDict [
	^ photoDict
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> photoDict: anObject [
	photoDict := anObject
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> photoNamesDict [
	^ photoNamesDict
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> photoNamesDict: anObject [
	photoNamesDict := anObject
]

{ #category : #services }
LSHHomeManagerComponentImpl >> removePhoto: component named: listname [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	"Delete in the Home Manager"
	"Delete in the photos dictionary"
	listname
		do: [ :name | 
			name isNil
				ifFalse: [ (self photoDict at: component) removeKey: name ] ].
	"Delete names in the OrderedCollection"
	listname
		do: [ :name | 
			name isNil
				ifFalse: [ (self photoNamesDict at: component) remove: name ifAbsent: [ nil ] ] ].
	"Delete photos in the dictionnay of the camera, warning : photos can be absent if they have been transfered"
	listname
		do: [ :name | 
			name isNil
				ifFalse: [ componentused photo
						removeKey: name
						ifAbsent: [ ('not photo named ' , name printString) traceCr ] ] ]
]

{ #category : #services }
LSHHomeManagerComponentImpl >> removeVideo: component named: listname [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	"Delete in the Home Manager"
	"Delete in the videos dictionary"
	listname do: [ :name | (self videoDict at: component) removeKey: name ifAbsent:[ nil ] ].
	"Delete names in the OrderedCollection"
	listname do: [ :name | (self videoNamesDict at: component) remove: name ifAbsent:[ nil ] ].
	"Delete photos in the dictionnay of the camera, warning : photos can be absent if they have been transfered"
	listname do: [ :name | componentused video removeKey: name ifAbsent: [ nil ] ]
]

{ #category : #services }
LSHHomeManagerComponentImpl >> takePhoto: component [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self ]. 
	componentused getPhoto
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> tempSensorNames [
	^ tempSensorNames
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> tempSensorNames: anObject [
	tempSensorNames := anObject
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> temperature [
	^ temperature
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> temperature: anObject [
	temperature := anObject
]

{ #category : #services }
LSHHomeManagerComponentImpl >> transferPhoto: component named: listname [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	"Copy photos in the Home Manager"
	self copyPhoto: component named: listname.
	"Delete photos in the camera"
	listname do: [ :name | componentused photo removeKey: name ]
]

{ #category : #services }
LSHHomeManagerComponentImpl >> transferVideo: component named: listname [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	"Copy videos in the Home Manager"
	self copyVideo: component named: listname.
	"Delete videos in the camera"
	listname do: [ :name | componentused video removeKey: name ]
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> videoDict [
	^ videoDict
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> videoDict: anObject [
	videoDict := anObject
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> videoNamesDict [
	^ videoNamesDict
]

{ #category : #accessing }
LSHHomeManagerComponentImpl >> videoNamesDict: anObject [
	videoNamesDict := anObject
]

{ #category : #services }
LSHHomeManagerComponentImpl >> zoom: component and: aBoolean value: value [
	| componentused |
	componentused := self getLSHCameraManagerServicesProvider getCamera: component.
	componentused ifNil:[ ^ self ].
	componentused zoom: aBoolean value: value.
]
