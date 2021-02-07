"
I'm a test of the little sweet home.
"
Class {
	#name : #LSHLauncher,
	#superclass : #Object,
	#instVars : [
		'homeManager'
	],
	#category : #'LittleSweetHome-Launcher'
}

{ #category : #run }
LSHLauncher class >> start [
	<script:'self start inspect'>
	^ self new
]

{ #category : #run }
LSHLauncher class >> startAndOpenTranscript [
	<script:'self start inspect. Transcript open'>
	^ self start
]

{ #category : #initialization }
LSHLauncher >> activation [
	LSHHomeManagerComponentImpl activate: #homeManager.
	LSHCameraManagerComponentImpl activate: #cameraManager.
	LSHTemperatureManagerComponentImpl activate: #temperatureManager
]

{ #category : #demo }
LSHLauncher >> demoAddCameras [
	self homeManager addCamera: LSHControlledCameraComponentImpl named: #controlledCamera1.
	self homeManager addCamera: LSHFixedCameraComponentImpl named: #fixedCamera1.
	self homeManager addCamera: LSHMotionSensorComponentImpl named: #motionSensor1
]

{ #category : #demo }
LSHLauncher >> demoAddTemperatureSensor [
	self homeManager addTemperatureSensor: #tempSensor1
]

{ #category : #demo }
LSHLauncher >> demoMotionSensor [
	| listP listV |
	self homeManager addCamera: LSHMotionSensorComponentImpl named: #fixedCamera1.
	self homeManager choosePeriod: #fixedCamera1 during: 5.
	self homeManager takePhoto: #fixedCamera1.
	self homeManager zoom: #fixedCamera1 and: true value: 150.
	self homeManager takePhoto: #fixedCamera1.
	self homeManager zoom: #fixedCamera1 and: false value: nil.
	self homeManager activateIR: #fixedCamera1 and: true.
	self homeManager activateIR: #fixedCamera1 and: false.
	self homeManager listPhoto: #fixedCamera1.
	self homeManager listVideo: #fixedCamera1.
	listP := self homeManager photoNamesDict at: #fixedCamera1.
	listV := self homeManager videoNamesDict at: #fixedCamera1.
	self homeManager copyPhoto: #fixedCamera1 named: listP.
	self homeManager copyVideo: #fixedCamera1 named: listV.
	self homeManager batteryLevel: #fixedCamera1.
	self homeManager removePhoto: #fixedCamera1 named: listP.
	self homeManager removeVideo: #fixedCamera1 named: listV.
	"self homeManager transferPhoto: #fixedCamera1 named: listP.
	self homeManager transferVideo: #fixedCamera1 named: listV"
]

{ #category : #demo }
LSHLauncher >> demoRecording [
	self homeManager addCamera: LSHControlledCameraComponentImpl named: #controlledCamera1.
	self homeManager choosePeriod: #controlledCamera1 during: 5.
]

{ #category : #demo }
LSHLauncher >> demoRecordingControlledCamera [
	| listP listV |
	self homeManager addCamera: LSHControlledCameraComponentImpl named: #controlledCamera1.
	self homeManager choosePeriod: #controlledCamera1 during: 5.
	self homeManager moveCamera: #controlledCamera1 horizontally: 10 vertically: 30.
	self homeManager moveCamera: #controlledCamera1 horizontally: 10 vertically: 20.	"cantMove"
	self homeManager takePhoto: #controlledCamera1.
	self homeManager zoom: #controlledCamera1 and: true value: 150.
	self homeManager takePhoto: #controlledCamera1.
	self homeManager zoom: #controlledCamera1 and: false value: nil.
	self homeManager activateIR: #controlledCamera1 and: true.
	self homeManager activateIR: #controlledCamera1 and: false.
	self homeManager listPhoto: #controlledCamera1.
	self homeManager listVideo: #controlledCamera1.
	listP := self homeManager photoNamesDict at: #controlledCamera1.
	listV := self homeManager videoNamesDict at: #controlledCamera1.
	self homeManager copyPhoto: #controlledCamera1 named: listP.
	self homeManager copyVideo: #controlledCamera1 named: listV.
	self homeManager batteryLevel: #controlledCamera1.
	self homeManager removePhoto: #controlledCamera1 named: listP.
	self homeManager removeVideo: #controlledCamera1 named: listV
	"self homeManager transferPhoto: #controlledCamera1 named: listP.
	self homeManager transferVideo: #controlledCamera1 named: listV."
]

{ #category : #demo }
LSHLauncher >> demoRecordingFixedCamera [
	| listP listV |
	self homeManager addCamera: LSHFixedCameraComponentImpl named: #fixedCamera1.
	self homeManager choosePeriod: #fixedCamera1 during: 5.
	self homeManager takePhoto: #fixedCamera1.
	self homeManager zoom: #fixedCamera1 and: true value: 150.
	self homeManager takePhoto: #fixedCamera1.
	self homeManager zoom: #fixedCamera1 and: false value: nil.
	self homeManager activateIR: #fixedCamera1 and: true.
	self homeManager activateIR: #fixedCamera1 and: false.
	self homeManager listPhoto: #fixedCamera1.
	self homeManager listVideo: #fixedCamera1.
	listP := self homeManager photoNamesDict at: #fixedCamera1.
	listV := self homeManager videoNamesDict at: #fixedCamera1.
	self homeManager copyPhoto: #fixedCamera1 named: listP.
	self homeManager copyVideo: #fixedCamera1 named: listV.
	self homeManager batteryLevel: #fixedCamera1.
	self homeManager removePhoto: #fixedCamera1 named: listP.
	self homeManager removeVideo: #fixedCamera1 named: listV.
	"self homeManager transferPhoto: #fixedCamera1 named: listP.
	self homeManager transferVideo: #fixedCamera1 named: listV"
]

{ #category : #demo }
LSHLauncher >> demoTemperatureSensor [
	self homeManager addTemperatureSensor: #tempSensor1.
	self homeManager activateTemperatureRegulation: #tempSensor1 and: true value: 25.
	self homeManager batteryLevel: #tempSensor1.
	self homeManager getTemperature: #tempSensor1
]

{ #category : #initialization }
LSHLauncher >> deployment [
	LSHTemperatureManagerComponentImpl deploy.
	LSHCameraManagerComponentImpl deploy.
	LSHHomeManagerComponentImpl deploy
]

{ #category : #accessing }
LSHLauncher >> homeManager [
	^ homeManager
]

{ #category : #accessing }
LSHLauncher >> homeManager: anObject [
	homeManager := anObject
]

{ #category : #initialization }
LSHLauncher >> initialize [
	"initialization of the managers"
	super initialize.
	self deployment.
	self instanciation.
	self activation
]

{ #category : #initialization }
LSHLauncher >> instanciation [
	self homeManager: (LSHHomeManagerComponentImpl instanciate: #homeManager).
	LSHCameraManagerComponentImpl instanciate: #cameraManager.
	LSHTemperatureManagerComponentImpl instanciate: #temperatureManager
]

{ #category : #removing }
LSHLauncher >> passivation [
	LSHCameraManagerComponentImpl passivate: #cameraManager.
	LSHTemperatureManagerComponentImpl passivate: #temperatureManager.
	LSHHomeManagerComponentImpl passivate: #homeManager
]

{ #category : #removing }
LSHLauncher >> remove [
	self passivation.
	self undeployement.
	MolComponentManager cleanUp.
]

{ #category : #removing }
LSHLauncher >> undeployement [
	LSHHomeManagerComponentImpl undeploy.
	LSHTemperatureManagerComponentImpl undeploy.
	LSHCameraManagerComponentImpl undeploy.
]
