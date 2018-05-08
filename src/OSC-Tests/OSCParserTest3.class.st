"
After the null that terminates a string, a well-formed incoming OSC message stream will have been padded with nulls if needed to reach a 32-bit word boundary, as per the OSC specification. This test checks that the parser handles this OK wherever the boundary may fall for a particular string in an incoming message.
"
Class {
	#name : #OSCParserTest3,
	#superclass : #TestCase,
	#instVars : [
		'string',
		'endingNumberArray',
		'startingNumberArray',
		'numberArrays',
		'streams',
		'parsedMessages'
	],
	#category : #'OSC-Tests'
}

{ #category : #setup }
OSCParserTest3 >> setUp [
	self setUpString.
	self setUpStartingNumberArray.
	self setUpEndingNumberArray.
	self setUpNumberArrays.
	self setUpStreams.
	self setUpParsedMessages.
]

{ #category : #setup }
OSCParserTest3 >> setUpEndingNumberArray [
	endingNumberArray := string asArray collect: [ :each | each asInteger ]  
	

]

{ #category : #setup }
OSCParserTest3 >> setUpNumberArrays [
	|  endArray |
	numberArrays := Dictionary new.
	(1 to: 4) keysAndValuesDo:
		[:key :value | 
			endArray := endingNumberArray copyFrom: key  to: endingNumberArray size.
			numberArrays at: key put: (startingNumberArray , endArray) ].
	
	

]

{ #category : #setup }
OSCParserTest3 >> setUpParsedMessages [
	parsedMessages := Dictionary new.
	streams keysAndValuesDo: 
		[ :key :value |  parsedMessages at: key put: (OSCParser parse: value ascii) ].
		
		

]

{ #category : #setup }
OSCParserTest3 >> setUpStartingNumberArray [
	| headerString typeMarker sizeOfPad nulls headerArray |
	headerString := 'Head'.
	typeMarker := ',s'.
	sizeOfPad :=  4 -  typeMarker size.
	nulls := Array new: sizeOfPad withAll: 0.
	headerArray := (headerString , typeMarker ) asArray.
	startingNumberArray  := (   headerArray , nulls  ) .
	
]

{ #category : #setup }
OSCParserTest3 >> setUpStreams [
	streams := Dictionary new.
	numberArrays keysAndValuesDo: [ :key :value |  streams at: key put: (self streamFromArray: value) ].
		
		

]

{ #category : #setup }
OSCParserTest3 >> setUpString [
	string := 'Reaktivision is  highly Groovy 0123456789' 
	

]

{ #category : #converting }
OSCParserTest3 >> streamFromArray: anArray [
	| stream |
	stream:= (RWBinaryOrTextStream on: (String new: 2048)) binary; yourself.
	anArray  do: [:each  | stream nextPut: each asInteger].
	stream reset.
	^ stream binary



	
]

{ #category : #testSuite }
OSCParserTest3 >> testSuite [
	| suite  |
	suite := TestSuite named: 'ParseStringsUsingWordAlignment'.
	suite  addTest: (OSCParserTest3 selector: #testWordAlignment).		
	^ suite

		

]

{ #category : #tests }
OSCParserTest3 >> testWordAlignment [

	parsedMessages keysAndValuesDo: [ :key :value | 
		"Transcript cr; show:  ' Actual - ' , ((parsedMessages at:key) first second); cr.
		Transcript cr; show:  ' Should be - ', ( string copyFrom: key to: string size ); cr."
		 self assert:  ((parsedMessages at: key) first second ) =  ( string copyFrom: key to: string size )  ].



		

]
