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
	[aByteStream atEnd] whileFalse: [
		messageArray := (self new initializeFor: aByteStream) parse.
		messageArray ifNotNil: [
			messageArrays add: messageArray asArray 
		]
	].
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
OSCParser >> parseBundle [
	self 
		parseHeader;
		parseTimestamp;
		parseMessage.
	^message asArray
]

{ #category : #accessing }
OSCParser >> parseBundleHeader [
	|header|
	header := (byteStream upTo: 0) copyWithout: 0.
	message add: (ZnCharacterEncoder ascii decodeBytes: header).

]

{ #category : #accessing }
OSCParser >> parseFloat [
	message add: (Float fromIEEE32Bit: (byteStream binary nextNumber: 4))
]

{ #category : #accessing }
OSCParser >> parseHeader [
	|header|
	header := (byteStream upTo: $, asInteger) copyWithout: 0.
	message add: (ZnCharacterEncoder ascii decodeBytes: header).

]

{ #category : #accessing }
OSCParser >> parseInt32 [
	message add: byteStream nextInt32
]

{ #category : #accessing }
OSCParser >> parseMessage [
	self 
		parseHeader;
		parseTypes;
		parseValues.
	^message asArray
]

{ #category : #accessing }
OSCParser >> parseNextValueTyped: aType [
	aType = 105 "i" ifTrue: [^self parseInt32].
	aType = 102 "f" ifTrue: [^self parseFloat].
	aType = 115 "s" ifTrue: [^self parseString].
	aType = 98  "b" ifTrue: [^self parseBlob]


]

{ #category : #parse }
OSCParser >> parseString [
	message add: (ZnCharacterEncoder ascii decodeBytes: (byteStream upTo: 0)).
	(4 - (byteStream position)) \\ 4 timesRepeat: [ byteStream next ]
	
]

{ #category : #accessing }
OSCParser >> parseTimestamp [ 
   |byteTimestamp |
	byteTimestamp:= (9 to: 16) collect: [ :i | byteStream contents at: i ].
	"byteTimeStamp should be transformed into a readable date"
	message add: byteTimestamp .
	
	
]

{ #category : #action }
OSCParser >> parseTypes [
	| next |
	byteStream atEnd ifTrue: [^self].
	next := byteStream next.
	next = 0 ifTrue: [
		((4 - (byteStream position \\ 4)) \\ 4) timesRepeat: [byteStream next].
		^self
	].
	  "i   f   s   b"
	(#[105 102 115 98] includes: next) ifTrue: [types add: next].
	self parseTypes.
]

{ #category : #accessing }
OSCParser >> parseValues [
	| aTypeStream |
	aTypeStream := ReadStream on: types.
	[aTypeStream atEnd] whileFalse: [self parseNextValueTyped: aTypeStream next]
]
