"
After the null that terminates a string, a well-formed incoming OSC message stream will have been padded with nulls if needed to reach a 32-bit word boundary, as per the OSC specification. This test checks that the parser handles this OK wherever the boundary may fall for a particular string in an incoming message.
"
Class {
	#name : 'OSCParserWordAlignmentTest',
	#superclass : 'TestCase',
	#instVars : [
		'string',
		'endingNumberArray',
		'startingNumberArray',
		'numberArrays',
		'streams',
		'parsedMessages'
	],
	#category : 'OSC-Tests',
	#package : 'OSC-Tests'
}

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUp [
	self setUpString.
	self setUpStartingNumberArray.
	self setUpEndingNumberArray.
	self setUpNumberArrays.
	self setUpStreams.
	self setUpParsedMessages.
]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpEndingNumberArray [
	endingNumberArray := string asArray collect: [ :each | each asInteger ]  
	

]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpNumberArrays [
	|  endArray |
	numberArrays := Dictionary new.
	(1 to: 4) keysAndValuesDo:
		[:key :value | 
			endArray := endingNumberArray copyFrom: key  to: endingNumberArray size.
			numberArrays at: key put: (startingNumberArray , endArray) ].
	
	

]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpParsedMessages [
	parsedMessages := Dictionary new.
	streams keysAndValuesDo: 
		[ :key :value |  parsedMessages at: key put: (OSCParser parse: value ascii) ].
		
		

]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpStartingNumberArray [
	| headerString typeMarker sizeOfPad nulls headerArray |
	headerString := 'Head'.
	typeMarker := ',s'.
	sizeOfPad :=  4 -  typeMarker size.
	nulls := Array new: sizeOfPad withAll: 0.
	headerArray := (headerString , typeMarker ) asArray.
	startingNumberArray  := (   headerArray , nulls  ) .
	
]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpStreams [
	streams := Dictionary new.
	numberArrays keysAndValuesDo: [ :key :value |  streams at: key put: (self streamFromArray: value) ].
		
		

]

{ #category : 'setup' }
OSCParserWordAlignmentTest >> setUpString [
	string := 'Reaktivision is  highly Groovy 0123456789' 
	

]

{ #category : 'converting' }
OSCParserWordAlignmentTest >> streamFromArray: anArray [
	^(ByteArray streamContents: [:out |
		anArray do: [:each | out nextPut: each asInteger ].
	]) readStream.
]

{ #category : 'tests' }
OSCParserWordAlignmentTest >> testWordAlignment [
	parsedMessages keysAndValuesDo: [ :key :value | "Transcript cr; show:  ' Actual - ' , ((parsedMessages at:key) first second); cr.
		Transcript cr; show:  ' Should be - ', ( string copyFrom: key to: string size ); cr."
		self
			assert: (parsedMessages at: key) first second
			equals: (string copyFrom: key to: string size) ]
]
