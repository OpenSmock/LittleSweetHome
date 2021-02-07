"
I am a video.
"
Class {
	#name : #LSHVideo,
	#superclass : #Object,
	#instVars : [
		'name',
		'file'
	],
	#category : #'LittleSweetHome-Model'
}

{ #category : #accessing }
LSHVideo >> file [
	^ file
]

{ #category : #accessing }
LSHVideo >> file: anObject [
	file := anObject
]

{ #category : #initialization }
LSHVideo >> initialize [
	super initialize.
	self file: nil.
	self name: nil
]

{ #category : #accessing }
LSHVideo >> name1 [
	^ name
]

{ #category : #accessing }
LSHVideo >> name: anObject [
	name := anObject
]
