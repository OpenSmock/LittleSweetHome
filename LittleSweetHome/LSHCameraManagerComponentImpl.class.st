"
I'm a camera manager (class).
"
Class {
	#name : #LSHCameraManagerComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'LSHCameraManagerComponent + LSHCameraManagerServices',
	#classTraits : 'LSHCameraManagerComponent classTrait + LSHCameraManagerServices classTrait',
	#instVars : [
		'camDict'
	],
	#category : #'LittleSweetHome-Managers Components'
}

{ #category : #'accessing - services' }
LSHCameraManagerComponentImpl class >> usedComponentServices [
	<componentContract>
	^ {LSHCameraManagerSettingsServices}
]

{ #category : #services }
LSHCameraManagerComponentImpl >> addCamera: aClass named: name [
	| manager camera homeManager collection |
	"Check if the camera doesnt exists"
	(self getCamera: name) ifNotNil:[ ^ self ].
	manager := MolComponentManager default.
	"Deployment during the initialization"
	"manager deploymentServices deployComponentImplementation: aClass."
	"Instanciation"
	camera := manager homeServices instanciateComponent: aClass named: name.
	"Activation"
	manager homeServices activateComponent: aClass named: name.
	camera name: name.
	self camDict at: name put: camera.
	"add the new name at the name dictionary of the Home Manager"
	homeManager := self getLSHCameraManagerSettingsServicesProvider.
	collection := homeManager camNames
		at: aClass printString
		ifAbsent: [ OrderedCollection new ].
	collection add: name.
	homeManager camNames at: aClass printString put: collection.
	self getLSHCameraManagerEventsNotifier newCamera: aClass named: name
]

{ #category : #accessing }
LSHCameraManagerComponentImpl >> camDict [
	^ camDict
]

{ #category : #accessing }
LSHCameraManagerComponentImpl >> camDict: anObject [
	camDict := anObject
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> componentActivate [
	'camera manager activated' traceCr
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> componentInitialize [
	"On déploie l'ensemble des classes de caméras pour permettre leurs potentielles créations ensuite. On ne peut pas le faire lors de la craétion car on risquerait de déployer plusieurs fois une meme classe."
	"Deployment of cameras class to permit creation then."
	self deployementCamera.
	self forServices: LSHCameraManagerSettingsServices useProvider: #homeManager.
	"key: nom de camera value: camera"
	self camDict: Dictionary new.
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> componentPassivate [
	LSHControlledCameraComponentImpl undeploy.
	LSHFixedCameraComponentImpl undeploy.
	LSHMotionSensorComponentImpl undeploy.
	'Camera manager passivated and cameras undeployed' traceCr.
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> componentRemove [

]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> deployementCamera [
	LSHFixedCameraComponentImpl deploy.
	LSHControlledCameraComponentImpl deploy.
	LSHMotionSensorComponentImpl deploy.
]

{ #category : #services }
LSHCameraManagerComponentImpl >> getCamera: name [
	self camDict
		keysAndValuesDo: [ :k :v | 
			name = k
				ifTrue: [ ^ v ] ].
	^ nil
]

{ #category : #'component accessing' }
LSHCameraManagerComponentImpl >> getLSHCameraManagerEventsNotifier [
	^self eventsNotifiers at: LSHCameraManagerEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: LSHCameraManagerEvents name: nil].
]

{ #category : #'component accessing' }
LSHCameraManagerComponentImpl >> getLSHCameraManagerSettingsServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := LSHCameraManagerSettingsServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: LSHCameraManagerSettingsServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> passivationCamera [
	LSHControlledCameraComponentImpl passivate: #controlledCamera.
	LSHFixedCameraComponentImpl passivate: #fixedCamera.
	LSHMotionSensorComponentImpl passivate: #motionSensor
]

{ #category : #'life cycle' }
LSHCameraManagerComponentImpl >> undeployementCamera [
	LSHControlledCameraComponentImpl undeploy.
	LSHFixedCameraComponentImpl undeploy.
	LSHMotionSensorComponentImpl undeploy
]
