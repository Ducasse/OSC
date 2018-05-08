"
OSCParser is a message parser.
Its main method is parse: which returns a collection of messages. 
"
Class {
	#name : #OSCParser,
	#superclass : #Object,
	#instVars : [
		'byteStream',
		'message',
		'types'
	],
	#category : #'OSC-Kernel'
}

{ #category : #parse }
OSCParser class >> parse: aByteStream [
	| messageArrays messageArray |		
	messageArrays := OrderedCollection new.	
	[ aByteStream atEnd] whileFalse:
	      [ messageArray := (self new initializeFor: aByteStream) parse.
		messageArray ifNotNil: [ messageArrays add: messageArray asArray ]].
	^messageArrays
]

{ #category : #initialization }
OSCParser >> initializeFor: aByteStream [
	byteStream := aByteStream.
	message := OrderedCollection new.
	types := OrderedCollection new.
]

{ #category : #accessing }
OSCParser >> parse [
	self 
		parseHeader;
		parseTypes;
		parseValues.
	^message asArray
]

{ #category : #action }
OSCParser >> parseBlob [
	^ nil
]

{ #category : #accessing }
OSCParser >> parseFloat [
	message add: (Float fromIEEE32Bit: (byteStream binary nextNumber: 4))
]

{ #category : #accessing }
OSCParser >> parseHeader [
	message add: ((byteStream ascii upTo: $, ) copyWithout: (Character value: 0))

]

{ #category : #accessing }
OSCParser >> parseInt32 [
	message add: byteStream binary nextInt32
]

{ #category : #accessing }
OSCParser >> parseNextValueTyped: aType [
	aType = $i ifTrue: [^self parseInt32].
	aType = $f ifTrue: [^self parseFloat].
	aType = $s ifTrue: [^self parseString].
	aType = $b ifTrue: [^self parseBlob]


]

{ #category : #parse }
OSCParser >> parseString [
	message add:  (byteStream ascii upTo: (Character value: 0)).
	(4 - (byteStream position))\\4  timesRepeat: [   byteStream next  ]
	
]

{ #category : #action }
OSCParser >> parseTypes [
	| next |
	byteStream atEnd ifTrue: [^self].
	next:= byteStream next.
	next = (Character value: 0) 
		ifTrue: [
			((4 - (byteStream position \\ 4)) \\ 4) timesRepeat: [byteStream next].
			^self].
	('ifsb' includes: next) ifTrue: [types add: next].
	self parseTypes
]

{ #category : #accessing }
OSCParser >> parseValues [
	| aTypeStream |
	aTypeStream := ReadStream on: types.
	[aTypeStream atEnd] whileFalse: [self parseNextValueTyped: aTypeStream next]
]
