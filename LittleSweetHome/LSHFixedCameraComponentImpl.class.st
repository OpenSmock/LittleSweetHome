"
I'm a fixed camera component (class).
"
Class {
	#name : #LSHFixedCameraComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHFixedCameraComponent + LSHBatteryServices + LSHVisualServices + LSHRecordingServices',
	#classTraits : 'LSHFixedCameraComponent classTrait + LSHBatteryServices classTrait + LSHVisualServices classTrait + LSHRecordingServices classTrait',
	#instVars : [
		'name',
		'photo',
		'video',
		'zoom',
		'time',
		'iR',
		'memory',
		'memoryCapacity',
		'battery',
		'startTime',
		'incrementName'
	],
	#category : #'LittleSweetHome-Sensors Components'
}

{ #category : #accessing }
LSHFixedCameraComponentImpl >> battery [
	^ battery
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> battery: anObject [
	battery := anObject
]

{ #category : #services }
LSHFixedCameraComponentImpl >> batteryLevel [
	(self name1 printString, ' battery : ' , self battery printString) traceCr
]

{ #category : #services }
LSHFixedCameraComponentImpl >> changeBattery [
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
LSHFixedCameraComponentImpl >> componentActivate [
	'fixed camera activated' traceCr
]

{ #category : #'life cycle' }
LSHFixedCameraComponentImpl >> componentInitialize [
	"Events and services to permit gets function working"
	self forServices: LSHVisualSettingsServices useProvider: #homeManager.
	self forServices: LSHGlobalServices useProvider: #homeManager.
	self forServices: LSHRecordingSettingsServices useProvider: #homeManager.
	self forServices: LSHCameraManagerServices useProvider: #cameraManager.
	"local instanciation"
	self iR: false.
	self photo: Dictionary new.
	self time: nil.
	self video: Dictionary new.
	self zoom: 100.
	self memory: 0.
	self memoryCapacity: 1000.
	self battery: 100.
	self startTime: LSHTime new.
	self startTime now.
	self incrementName: 0
]

{ #category : #'life cycle' }
LSHFixedCameraComponentImpl >> componentPassivate [
	'Fixed camera passivated' traceCr
]

{ #category : #'life cycle' }
LSHFixedCameraComponentImpl >> componentRemove [
	self iR: nil.
	self photo: nil.
	self time: nil.
	self video: nil.
	self zoom: nil.
	self memory: nil.
	self memoryCapacity: nil.
	self battery: nil.
	self startTime: nil
]

{ #category : #services }
LSHFixedCameraComponentImpl >> copyPhoto: listname [
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
LSHFixedCameraComponentImpl >> copyVideo: listname [
	| homeManager videoDictionary |
	homeManager := self getLSHVisualSettingsServicesProvider.
	"get videos of this camera stored by the Home Manager"
	videoDictionary := homeManager videoDict at: self name1 ifAbsent: [ Dictionary new ].
	"add photos in this dictionary if the name is in listname"
	listname
		do: [ :videoName | 
			videoName
				ifFalse: [ videoDictionary at: videoName put: (video at: videoName) ] ].
	"store photos in the home manager"
	homeManager videoDict at: self name1 put: videoDictionary.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #'component accessing' }
LSHFixedCameraComponentImpl >> getLSHDetectionEventsNotifier [
	^self eventsNotifiers at: LSHDetectionEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHDetectionEvents name: nil].
]

{ #category : #'component accessing' }
LSHFixedCameraComponentImpl >> getLSHGlobalServicesProvider [
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
LSHFixedCameraComponentImpl >> getLSHMaintenanceEventsNotifier [
	^self eventsNotifiers at: LSHMaintenanceEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMaintenanceEvents name: nil].
]

{ #category : #'component accessing' }
LSHFixedCameraComponentImpl >> getLSHMemoryEventsNotifier [
	^self eventsNotifiers at: LSHMemoryEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMemoryEvents name: nil].
]

{ #category : #'component accessing' }
LSHFixedCameraComponentImpl >> getLSHRecordingSettingsServicesProvider [
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
LSHFixedCameraComponentImpl >> getLSHVisualSettingsServicesProvider [
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
LSHFixedCameraComponentImpl >> getPhoto [
	| takenPhoto photoName |
	(self name1 printString, ' is taking photos.') traceCr.
	self memory: self memory + 1.
	self incrementName: self incrementName + 1.
	photoName := 'photo' , self incrementName printString.
	takenPhoto := LSHPhoto new.
	photo at: photoName put: takenPhoto.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> iR [
	^ iR
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> iR: anObject [
	iR := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> incrementName [
	^ incrementName
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> incrementName: anObject [
	incrementName := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> memory [
	^ memory
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> memory: anObject [
	memory := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> memoryCapacity [
	^ memoryCapacity
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> memoryCapacity: anObject [
	memoryCapacity := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> name1 [
	^ name
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> photo [
	^ photo
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> photo: anObject [
	photo := anObject
]

{ #category : #services }
LSHFixedCameraComponentImpl >> raiseBatteryEmptyEvents [
	self battery < 5
		ifTrue: [ self getLSHMaintenanceEventsNotifier batteryEmpty: self name1 -> self battery ]
]

{ #category : #services }
LSHFixedCameraComponentImpl >> raiseFullMemoryEvents [
	memory = memoryCapacity
		ifTrue: [ self getLSHMemoryEventsNotifier memoryFull: self name1 ]
]

{ #category : #services }
LSHFixedCameraComponentImpl >> raiseRandomInternalErrorEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have an internal error"
	rand next < 0.2
		ifTrue: [ self getLSHMaintenanceEventsNotifier internalError: self name1 ]
]

{ #category : #services }
LSHFixedCameraComponentImpl >> raiseRandomMovementDetectedEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have a movement detected"
	rand next < 0.2
		ifTrue: [ self getLSHDetectionEventsNotifier movementDetected: self name1 ]
]

{ #category : #services }
LSHFixedCameraComponentImpl >> raiseSimulatedEvents [
	self raiseBatteryEmptyEvents.
	self raiseRandomInternalErrorEvents.
	self raiseRandomMovementDetectedEvents.
	self raiseFullMemoryEvents
]

{ #category : #services }
LSHFixedCameraComponentImpl >> recordVideo: t [
	| recordedVideo videoName |
	time := t.
	"show in the Transcript"
	(self name1 printString , ' is recording video during' , time printString , ' seconds.')
		traceCr.
	"Recording"
	[ (Duration seconds: t) wait.
	self memory: self memory + t.
	self incrementName: self incrementName + 1.
	videoName := 'video' , self incrementName printString.
	recordedVideo := LSHVideo new.
	video at: videoName put: recordedVideo.
	self stopRecordVideo ] fork
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> startTime [
	^ startTime
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> startTime: anObject [
	startTime := anObject
]

{ #category : #services }
LSHFixedCameraComponentImpl >> stopRecordVideo [
	time := nil.
	(self name1 printString , ' stops to record video.') traceCr.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> time [
	^ time
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> time: anObject [
	time := anObject
]

{ #category : #services }
LSHFixedCameraComponentImpl >> toggleVideoIR: aBoolean [
	iR := aBoolean.
	aBoolean
		ifTrue: [ 'The IR recording is activated.' traceCr ]
		ifFalse: [ 'The IR recording is passivated.' traceCr ].
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHFixedCameraComponentImpl >> transferPhotoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager photoNamesDict at: self name1 put: self photo keys asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHFixedCameraComponentImpl >> transferVideoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager videoNamesDict at: self name1 put: self video keys asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> video [
	^ video
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> video: anObject [
	video := anObject
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> zoom [
	^ zoom
]

{ #category : #accessing }
LSHFixedCameraComponentImpl >> zoom: anObject [
	zoom := anObject
]

{ #category : #services }
LSHFixedCameraComponentImpl >> zoom: aBoolean value: value [
	aBoolean
		ifTrue: [ self zoom: value ]
		ifFalse: [ self zoom: 100 ]. self changeBattery.
	self raiseSimulatedEvents
]
