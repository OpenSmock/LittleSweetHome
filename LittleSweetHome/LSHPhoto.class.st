"
I am a photo.
"
Class {
	#name : #LSHPhoto,
	#superclass : #Object,
	#instVars : [
		'name',
		'file'
	],
	#category : #'LittleSweetHome-Model'
}

{ #category : #accessing }
LSHPhoto >> file [
	^ file
]

{ #category : #accessing }
LSHPhoto >> file: anObject [
	file := anObject
]

{ #category : #accessing }
LSHPhoto >> initialize [
	super initialize.
	self file: nil.
	self name: nil
]

{ #category : #accessing }
LSHPhoto >> name1 [
	^ name
]

{ #category : #accessing }
LSHPhoto >> name: anObject [
	name := anObject
]
