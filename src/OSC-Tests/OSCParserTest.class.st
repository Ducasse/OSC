Class {
	#name : #OSCParserTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCParserTest >> testParse [
	"self debug: #testParse"
	 
	self assert: ((OSCParser parse: OSCMessage exampleSCIncreaseVolume byteStream reset) first = OSCMessage increaseVolumeMessage)
]

{ #category : #tests }
OSCParserTest >> testParseExampleBerkely3Message [
	"self debug: #testParseExampleBerkely3Message"
	 
	self assert: ((OSCParser parse: OSCMessage exampleBerkeley3 byteStream reset) first = OSCMessage exampleBerkeley3Message )
]

{ #category : #tests }
OSCParserTest >> testParseIncreaseVolumeMessage [
	"self debug: #testParseIncreaseVolumeMessage"
	 
	self assert: ((OSCParser parse: OSCMessage exampleSCIncreaseVolume byteStream reset) first = OSCMessage increaseVolumeMessage)
]
