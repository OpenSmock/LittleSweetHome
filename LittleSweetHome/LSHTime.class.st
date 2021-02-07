"
I am the time of the Little Sweet Home.
"
Class {
	#name : #LSHTime,
	#superclass : #Object,
	#instVars : [
		'hour',
		'minute',
		'second'
	],
	#category : #'LittleSweetHome-Model'
}

{ #category : #methods }
LSHTime >> add: time [
	| t |
	t := LSHTime new.
	t second: self second + time second.
	t second > 60
		ifTrue: [ t second: t second - 60.
			t minute: t minute + 1 ].
	t minute: t minute + self minute + time minute.
	t minute > 60
		ifTrue: [ t minute: t minute - 60.
			t hour: t hour + 1 ].
	t hour: t hour + self hour + time hour.
	^ t
]

{ #category : #methods }
LSHTime >> convertSeconds [
	|h m result|
	h := self hour * 3600.
	m := self minute * 60.
	result := h + m + self second.
	^result.
	
]

{ #category : #accessing }
LSHTime >> hour [
	^ hour
]

{ #category : #accessing }
LSHTime >> hour: anObject [
	hour := anObject
]

{ #category : #initialization }
LSHTime >> initialize [
	super initialize.
	self hour: 0.
	self minute: 0.
	self second: 0
]

{ #category : #accessing }
LSHTime >> minute [
	^ minute
]

{ #category : #accessing }
LSHTime >> minute: anObject [
	minute := anObject
]

{ #category : #methods }
LSHTime >> now [
	| t |
	t := Time nowUTC.
	self hour: t hour.
	self minute: t minute.
	self second: t second
]

{ #category : #accessing }
LSHTime >> second [
	^ second
]

{ #category : #accessing }
LSHTime >> second: anObject [
	second := anObject
]

{ #category : #methods }
LSHTime >> substract: time [
	"self - time"
	| t |
	t := LSHTime new.
	t second: self second - time second.
	t second < 0
		ifTrue: [ time second: time second - 60.
			time minute: time minute + 1.
			t second: self second - time second ].
	t minute: self minute - time minute.
	t minute < 0
		ifTrue: [ time minute: time minute - 60.
			time hour: time hour + 1.
			t minute: self minute - time minute ].
	t hour: self hour - time hour.
	^ t
]
