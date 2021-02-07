"
I'm a controlled camera component (class).
"
Class {
	#name : #LSHControlledCameraComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHControlledCameraComponent + LSHBatteryServices + LSHMovementServices + LSHVisualServices + LSHRecordingServices',
	#classTraits : 'LSHControlledCameraComponent classTrait + LSHBatteryServices classTrait + LSHMovementServices classTrait + LSHVisualServices classTrait + LSHRecordingServices classTrait',
	#instVars : [
		'name',
		'photo',
		'video',
		'zoom',
		'time',
		'iR',
		'horizontalAngle',
		'verticalAngle',
		'horizontalAngleMax',
		'horizontalAngleMin',
		'verticalAngleMax',
		'verticalAngleMin',
		'memory',
		'memoryCapacity',
		'battery',
		'startTime',
		'incrementName'
	],
	#category : #'LittleSweetHome-Sensors Components'
}

{ #category : #accessing }
LSHControlledCameraComponentImpl >> battery [
	^ battery
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> battery: anObject [
	battery := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> batteryLevel [
	(self name1 printString, ' battery : ' , self battery printString) traceCr
]

{ #category : #services }
LSHControlledCameraComponentImpl >> changeBattery [
	| nowt t lessBattery timeInSeconds |
	nowt := LSHTime new.
	nowt now.
	t := nowt substract: startTime.
	timeInSeconds := t convertSeconds.
	"The battery lose 1% each 10 seconds."
	lessBattery := (timeInSeconds / 10) asInteger.
	self battery: self battery - lessBattery
]

{ #category : #'life cycle' }
LSHControlledCameraComponentImpl >> componentActivate [
	'controlled camera activated' traceCr
]

{ #category : #'life cycle' }
LSHControlledCameraComponentImpl >> componentInitialize [
	"Events and services"
	self forServices: LSHVisualSettingsServices useProvider: #homeManager.
	self forServices: LSHGlobalServices useProvider: #homeManager.
	self forServices: LSHMovementSettingsServices useProvider: #homeManager.
	self forServices: LSHRecordingSettingsServices useProvider: #homeManager.
	self forServices: LSHCameraManagerServices useProvider: #cameraManager.
	
	"local instanciation"
	self verticalAngle: 0.
	self horizontalAngle: 0.
	self iR: false.
	self photo: Dictionary new.
	self time: nil.
	self video: Dictionary new.
	self zoom: 100.
	self horizontalAngleMin: -45.
	self horizontalAngleMax: 45.
	self verticalAngleMax: 45.
	self verticalAngleMin: -45.
	self memory: 0.
	self memoryCapacity: 1000.
	self battery: 100.
	self startTime: LSHTime new.
	self startTime now.
	self incrementName: 0
]

{ #category : #'life cycle' }
LSHControlledCameraComponentImpl >> componentPassivate [
	'Controlled camera passivated' traceCr
]

{ #category : #'life cycle' }
LSHControlledCameraComponentImpl >> componentRemove [
	self verticalAngle: nil.
	self horizontalAngle: nil.
	self iR: nil.
	self photo: nil.
	self time: nil.
	self video: nil.
	self zoom: nil.
	self horizontalAngleMin: nil.
	self horizontalAngleMax: nil.
	self verticalAngleMax: nil.
	self verticalAngleMin: nil.
	self memory: nil.
	self memoryCapacity: nil.
	self battery: nil.
	self startTime: nil.
	self incrementName: nil
]

{ #category : #services }
LSHControlledCameraComponentImpl >> copyPhoto: listname [
	| homeManager photoDictionary |
	homeManager := self getLSHVisualSettingsServicesProvider.
	"get photos of this camera stored by the Home Manager"
	photoDictionary := homeManager photoDict at: self name1 ifAbsent: [ Dictionary new ].
	"add photos in this dictionary if the name is in listname"
	listname
		do: [ :photoName | 
			photoName isNil
				ifFalse: [ photoDictionary at: photoName put: (photo at: photoName) ] ].
	"store photos in the home manager"
	homeManager photoDict at: self name1 put: photoDictionary.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHControlledCameraComponentImpl >> copyVideo: listname [
	| homeManager videoDictionary |
	homeManager := self getLSHVisualSettingsServicesProvider.
	"get videos of this camera stored by the Home Manager"
	videoDictionary := homeManager videoDict at: self name1 ifAbsent: [ Dictionary new ].
	"add photos in this dictionary if the name is in listname"
	listname
		do: [ :videoName | 
			videoName isNil
				ifFalse: [ videoDictionary at: videoName put: (video at: videoName) ] ].
	"store photos in the home manager"
	homeManager videoDict at: self name1 put: videoDictionary.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHDetectionEventsNotifier [
	^self eventsNotifiers at: LSHDetectionEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHDetectionEvents name: nil].
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHGlobalServicesProvider [
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
LSHControlledCameraComponentImpl >> getLSHMaintenanceEventsNotifier [
	^self eventsNotifiers at: LSHMaintenanceEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMaintenanceEvents name: nil].
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHMemoryEventsNotifier [
	^self eventsNotifiers at: LSHMemoryEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMemoryEvents name: nil].
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHMovementEventsNotifier [
	^self eventsNotifiers at: LSHMovementEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMovementEvents name: nil].
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHMovementSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHMovementSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHMovementSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHRecordingSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHRecordingSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHRecordingSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
LSHControlledCameraComponentImpl >> getLSHVisualSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHVisualSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHVisualSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #services }
LSHControlledCameraComponentImpl >> getPhoto [
	| takenPhoto photoName |
	(self name1 printString , ' is taking photos.') traceCr.
	self memory: self memory + 1.
	self incrementName: self incrementName + 1.
	photoName := 'photo' , self incrementName printString.
	takenPhoto := LSHPhoto new.
	photo at: photoName put: takenPhoto.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngle [
	^ horizontalAngle
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngle: anObject [
	horizontalAngle := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngleMax [
	^ horizontalAngleMax
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngleMax: anObject [
	horizontalAngleMax := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngleMin [
	^ horizontalAngleMin
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> horizontalAngleMin: anObject [
	horizontalAngleMin := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> iR [
	^ iR
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> iR: anObject [
	iR := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> incrementName [
	^ incrementName
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> incrementName: anObject [
	incrementName := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> memory [
	^ memory
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> memory: anObject [
	memory := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> memoryCapacity [
	^ memoryCapacity
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> memoryCapacity: anObject [
	memoryCapacity := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> moveHorizontally: angle [
	| newAngle |
	newAngle := horizontalAngle + angle.
	newAngle < horizontalAngleMax
		ifTrue: [ horizontalAngleMin < newAngle
				ifTrue: [ horizontalAngle := newAngle ]
				ifFalse: [ self getLSHMovementEventsNotifier cantMove: self name1 ] ].
	self horizontalAngle traceCr.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHControlledCameraComponentImpl >> moveVertically: angle [
	| newAngle |
	newAngle := verticalAngle + angle.
	verticalAngleMin < newAngle
		ifTrue: [ newAngle < verticalAngleMax
				ifTrue: [ verticalAngle := newAngle ]
				ifFalse: [ self getLSHMovementEventsNotifier cantMove: self name1 ] ].
	self verticalAngle traceCr.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> name1 [
	^ name
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> photo [
	^ photo
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> photo: anObject [
	photo := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> raiseBatteryEmptyEvents [
	self battery < 5
		ifTrue: [ self getLSHMaintenanceEventsNotifier batteryEmpty: self name1 -> self battery ]
]

{ #category : #services }
LSHControlledCameraComponentImpl >> raiseFullMemoryEvents [
	memory = memoryCapacity
		ifTrue: [ self getLSHMemoryEventsNotifier memoryFull: self name1 ]
]

{ #category : #services }
LSHControlledCameraComponentImpl >> raiseRandomInternalErrorEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have an internal error"
	rand next < 0.2
		ifTrue: [ self getLSHMaintenanceEventsNotifier internalError: self name1 ]
]

{ #category : #services }
LSHControlledCameraComponentImpl >> raiseRandomMovementDetectedEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have a movement detected"
	rand next < 0.2
		ifTrue: [ self getLSHDetectionEventsNotifier movementDetected: self name1 ]
]

{ #category : #services }
LSHControlledCameraComponentImpl >> raiseSimulatedEvents [
	self raiseBatteryEmptyEvents.
	self raiseRandomInternalErrorEvents.
	self raiseRandomMovementDetectedEvents.
	self raiseFullMemoryEvents
]

{ #category : #services }
LSHControlledCameraComponentImpl >> recordVideo: t [
	| recordedVideo videoName |
	time := t.
	"show in the Transcript"
	(self name1 printString , ' is recording video during ' , time printString , ' seconds.')
		traceCr.
	"Recording"
	[ (Duration seconds: t) wait.
	self memory: self memory + t.
	self incrementName: self incrementName + 1.
	videoName := 'video' , self incrementName printString.
	recordedVideo := LSHVideo new.
	video at: videoName put: recordedVideo.
	video traceCr.
	self stopRecordVideo ] fork
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> startTime [
	^ startTime
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> startTime: anObject [
	startTime := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> stopRecordVideo [
	time := nil.
	(self name1 printString , ' stops to record video.') traceCr.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> time [
	^ time
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> time: anObject [
	time := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> toggleVideoIR: aBoolean [
	iR := aBoolean.
	aBoolean
		ifTrue: [ 'The IR recording is activated.' traceCr ]
		ifFalse: [ 'The IR recording is passivated.' traceCr ].
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHControlledCameraComponentImpl >> transferPhotoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager photoNamesDict at: self name1 put: self photo keys asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHControlledCameraComponentImpl >> transferVideoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager videoNamesDict at: self name1 put: (self video keys) asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngle [
	^ verticalAngle
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngle: anObject [
	verticalAngle := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngleMax [
	^ verticalAngleMax
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngleMax: anObject [
	verticalAngleMax := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngleMin [
	^ verticalAngleMin
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> verticalAngleMin: anObject [
	verticalAngleMin := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> video [
	^ video
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> video: anObject [
	video := anObject
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> zoom [
	^ zoom
]

{ #category : #accessing }
LSHControlledCameraComponentImpl >> zoom: anObject [
	zoom := anObject
]

{ #category : #services }
LSHControlledCameraComponentImpl >> zoom: aBoolean value: value [
	aBoolean
		ifTrue: [ self zoom: value ]
		ifFalse: [ self zoom: 100 ].
	self changeBattery.
	self raiseSimulatedEvents
]
