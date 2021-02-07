"
I'm a motion sensor component (class).
"
Class {
	#name : #LSHMotionSensorComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHMotionSensorComponent + LSHBatteryServices + LSHVisualServices',
	#classTraits : 'LSHMotionSensorComponent classTrait + LSHBatteryServices classTrait + LSHVisualServices classTrait',
	#instVars : [
		'name',
		'takePhoto',
		'zoom',
		'photo',
		'video',
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
LSHMotionSensorComponentImpl >> battery [
	^ battery
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> battery: anObject [
	battery := anObject
]

{ #category : #services }
LSHMotionSensorComponentImpl >> batteryLevel [
	(self name1 printString , ' battery : ' , self battery printString) traceCr
]

{ #category : #services }
LSHMotionSensorComponentImpl >> changeBattery [
	| nowt t lessBattery timeInSeconds |
	nowt := LSHTime new.
	nowt now.
	t := nowt substract: startTime.
	timeInSeconds := t convertSeconds.
	"The battery lose 1% each 10 seconds."
	timeInSeconds traceCr.
	lessBattery := (timeInSeconds / 10) asInteger.
	self battery: self battery - lessBattery
]

{ #category : #'life cycle' }
LSHMotionSensorComponentImpl >> componentActivate [
	'Motion sensor activated' traceCr.
]

{ #category : #'life cycle' }
LSHMotionSensorComponentImpl >> componentInitialize [
	"Services assignation"
	self forServices: LSHVisualSettingsServices useProvider: #homeManager.
	self forServices: LSHGlobalServices useProvider: #homeManager.
	self forServices: LSHCameraManagerServices useProvider: #cameraManager.

	"Local Instantiation"
	self iR: false.
	self photo: Dictionary new.
	self takePhoto: true.
	self video: Dictionary new.
	self zoom: 100.
	self memory: 0.
	self memoryCapacity: 1000.
	self battery: 100.
	self startTime: LSHTime new.
	self startTime now.
	self incrementName: 0.
	"Recording Video"
	self recordVideo: 10
]

{ #category : #'life cycle' }
LSHMotionSensorComponentImpl >> componentPassivate [
	'Motion sensor passivated' traceCr
]

{ #category : #'life cycle' }
LSHMotionSensorComponentImpl >> componentRemove [
	self iR: nil.
	self photo: nil.
	self takePhoto: nil.
	self video: nil.
	self zoom: nil.
	self memory: nil.
	self memoryCapacity: nil.
	self battery: nil.
	self startTime: nil.
]

{ #category : #services }
LSHMotionSensorComponentImpl >> copyPhoto: listname [
	| homeManager photoDictionary |
	"copy photos in the Home Manager if the motion sensor can take photos"
	self takePhoto
		ifTrue: [ homeManager := self getLSHVisualSettingsServicesProvider.
			"get photos of this camera stored by the Home Manager"
			photoDictionary := homeManager photoDict at: self name1 ifAbsent: [ Dictionary new ].
			"add photos in this dictionary if the name is in listname"
			listname
				do: [ :photoName | 
					photoName isNil
						ifFalse: [ photoDictionary at: photoName put: (photo at: photoName) ] ].
			"store photos in the home manager"
			homeManager photoDict at: self name1 put: photoDictionary ]
		ifFalse: [ self getLSHCantTakePhotoEventsNotifier cantTakePhoto: self name1 ].
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHMotionSensorComponentImpl >> copyVideo: listname [
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
LSHMotionSensorComponentImpl >> getLSHCantTakePhotoEventsNotifier [
	^self eventsNotifiers at: LSHCantTakePhotoEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHCantTakePhotoEvents name: nil].
]

{ #category : #'component accessing' }
LSHMotionSensorComponentImpl >> getLSHDetectionEventsNotifier [
	^self eventsNotifiers at: LSHDetectionEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHDetectionEvents name: nil].
]

{ #category : #'component accessing' }
LSHMotionSensorComponentImpl >> getLSHGlobalServicesProvider [
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
LSHMotionSensorComponentImpl >> getLSHMaintenanceEventsNotifier [
	^self eventsNotifiers at: LSHMaintenanceEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMaintenanceEvents name: nil].
]

{ #category : #'component accessing' }
LSHMotionSensorComponentImpl >> getLSHMemoryEventsNotifier [
	^self eventsNotifiers at: LSHMemoryEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHMemoryEvents name: nil].
]

{ #category : #'component accessing' }
LSHMotionSensorComponentImpl >> getLSHVisualSettingsServicesProvider [
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
LSHMotionSensorComponentImpl >> getPhoto [
	| takenPhoto photoName |
	takePhoto
		ifTrue: [ (self name1 printString , ' is taking photos.') traceCr.
			self memory: self memory + 1.
			self incrementName: self incrementName + 1.
			photoName := 'photo' , self incrementName printString.
			takenPhoto := LSHPhoto new.
			photo at: photoName put: takenPhoto ]
		ifFalse: [ self getLSHCantTakePhotoEventsNotifier cantTakePhoto: self name1 ].
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> iR [
	^ iR
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> iR: anObject [
	iR := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> incrementName [
	^ incrementName
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> incrementName: anObject [
	incrementName := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> memory [
	^ memory
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> memory: anObject [
	memory := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> memoryCapacity [
	^ memoryCapacity
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> memoryCapacity: anObject [
	memoryCapacity := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> name1 [
	^ name
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> photo [
	^ photo
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> photo: anObject [
	photo := anObject
]

{ #category : #services }
LSHMotionSensorComponentImpl >> raiseBatteryEmptyEvents [
	self battery < 5
		ifTrue: [ self getLSHMaintenanceEventsNotifier batteryEmpty: self name1 -> self battery ]
]

{ #category : #services }
LSHMotionSensorComponentImpl >> raiseFullMemoryEvents [
	memory = memoryCapacity
		ifTrue: [ self getLSHMemoryEventsNotifier memoryFull: self name1 ]
]

{ #category : #services }
LSHMotionSensorComponentImpl >> raiseRandomInternalErrorEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have an internal error"
	rand next < 0.2
		ifTrue: [ self getLSHMaintenanceEventsNotifier internalError: self name1 ]
]

{ #category : #services }
LSHMotionSensorComponentImpl >> raiseRandomMovementDetectedEvents [
	| rand |
	rand := Random new.
	"probabilité of 0.2 to have a movement detected"
	rand next < 0.2
		ifTrue: [ self getLSHDetectionEventsNotifier movementDetected: self name1 ]
]

{ #category : #services }
LSHMotionSensorComponentImpl >> raiseSimulatedEvents [
	self raiseBatteryEmptyEvents.
	self raiseRandomInternalErrorEvents.
	self raiseRandomMovementDetectedEvents.
	self raiseFullMemoryEvents
]

{ #category : #services }
LSHMotionSensorComponentImpl >> recordVideo: t [
	| recordedVideo videoName |
	"show in the Transcript"
	(self name1 printString , ' is recording video during' , t printString , ' seconds.')
		traceCr.
	"Recording"
	[ (Duration seconds: t) wait.
	self memory: self memory + t.
	self incrementName: self incrementName + 1.
	videoName := 'video' , self incrementName printString.
	recordedVideo := LSHVideo new.
	video at: videoName put: recordedVideo.
	self changeBattery ] fork
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> startTime [
	^ startTime
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> takePhoto [
	^ takePhoto
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> takePhoto: anObject [
	takePhoto := anObject
]

{ #category : #services }
LSHMotionSensorComponentImpl >> toggleVideoIR: aBoolean [
	iR := aBoolean.
	aBoolean
		ifTrue: [ 'The IR recording is activated.' traceCr ]
		ifFalse: [ 'The IR recording is passivated.' traceCr ].
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHMotionSensorComponentImpl >> transferPhotoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager photoNamesDict at: self name1 put: self photo keys asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #services }
LSHMotionSensorComponentImpl >> transferVideoNames [
	| homeManager |
	homeManager := self getLSHVisualSettingsServicesProvider.
	homeManager videoNamesDict at: self name1 put: self video keys asOrderedCollection.
	self changeBattery.
	self raiseSimulatedEvents
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> video [
	^ video
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> video: anObject [
	video := anObject
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> zoom [
	^ zoom
]

{ #category : #accessing }
LSHMotionSensorComponentImpl >> zoom: anObject [
	zoom := anObject
]

{ #category : #services }
LSHMotionSensorComponentImpl >> zoom: aBoolean value: value [
	aBoolean
		ifTrue: [ self zoom: value ]
		ifFalse: [ self zoom: 100 ]. self raiseSimulatedEvents.
	self raiseSimulatedEvents
]
