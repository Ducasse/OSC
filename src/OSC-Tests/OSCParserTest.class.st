Class {
	#name : 'OSCParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'OSC-Tests',
	#package : 'OSC-Tests'
}

{ #category : 'tests' }
OSCParserTest >> rawBundle [
	^#[35 98 117 110 100 108 101 0 0 0 0 0 0 0 0 1 0 0 0 32 47 116 117 105 111 47 50 68 111 98 106 0 44 115 115 0 115 111 117 114 99 101 0 0 118 105 115 105 111 110 0 0 0 0 0 76 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 105 105 105 105 105 105 105 105 0 0 0 0 97 108 105 118 101 0 0 0 0 0 0 42 0 0 0 43 0 0 0 44 0 0 0 45 0 0 0 46 0 0 0 47 0 0 0 48 0 0 0 49 0 0 0 50 0 0 0 51 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 42 0 0 0 14 63 88 136 237 63 47 122 89 62 37 252 84 61 115 94 16 60 154 81 117 0 0 0 0 186 128 127 210 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 43 0 0 0 13 63 88 151 24 63 102 3 195 62 1 60 116 61 137 156 31 60 130 116 93 0 0 0 0 186 105 27 53 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 44 0 0 0 7 63 23 3 240 63 92 135 87 61 238 4 233 61 149 61 24 0 0 0 0 0 0 0 0 186 182 82 171 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 45 0 0 0 10 63 56 107 155 63 97 75 217 61 226 44 41 62 17 0 62 60 161 91 39 0 0 0 0 59 13 245 244 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 46 0 0 0 1 62 159 147 223 63 82 44 101 61 217 161 105 61 147 225 210 0 0 0 0 0 0 0 0 186 211 195 233 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 47 0 0 0 4 62 232 110 187 63 87 110 53 61 253 117 41 61 151 241 117 0 0 0 0 0 0 0 0 186 198 7 73 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 48 0 0 0 5 62 241 108 216 63 29 239 197 62 20 220 212 61 147 100 218 0 0 0 0 0 0 0 0 186 164 190 84 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 49 0 0 0 8 63 25 248 194 63 36 28 76 62 18 63 84 61 136 42 109 0 0 0 0 0 0 0 0 186 172 239 184 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 50 0 0 0 11 63 57 145 158 63 41 213 19 62 29 206 148 61 131 164 93 60 178 155 39 0 0 0 0 186 140 41 253 0 0 0 0 0 0 0 72 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 105 102 102 102 102 102 102 102 102 0 0 0 0 115 101 116 0 0 0 0 51 0 0 0 2 62 172 214 28 63 23 74 151 62 9 116 116 61 137 202 171 60 188 34 233 0 0 0 0 186 170 24 46 0 0 0 0 0 0 0 28 47 116 117 105 111 47 50 68 111 98 106 0 44 115 105 0 102 115 101 113 0 0 0 0 0 0 6 70]
]

{ #category : 'tests' }
OSCParserTest >> testParse [
	self
		assert: (OSCParser parse: OSCMessage exampleSCIncreaseVolume bytes readStream) first
		equals: OSCMessage increaseVolumeMessage
]

{ #category : 'tests' }
OSCParserTest >> testParseBundle [

	| messages |
	messages := OSCParser parse: self rawBundle readStream.
	self assert: messages size equals: 13.
	self assert: (messages at: 2) second equals: 'alive'.
	self assert: (messages at: 12) second equals: 'set'.
	self assert: (messages at: 13) second equals: 'fseq'
]

{ #category : 'tests' }
OSCParserTest >> testParseBundleHeader [
	|messages  byteHeader decodedHeader byteStream|
	messages := OSCBundle new. "sendToAddressString: '127.0.0.1'port: 5432."
   byteStream := ByteArray new writeStream .
   messages print: {OSCMessage for: { '/test' . 99}} onOSCStream: byteStream .
   byteStream close.
	byteHeader := (byteStream contents readStream upTo: 0 asInteger) copyWithout: 0.
	decodedHeader := OrderedCollection new add: (ZnCharacterEncoder ascii decodeBytes: byteHeader).
	self assert: decodedHeader equals: '#bundle'.
	
	
]

{ #category : 'tests' }
OSCParserTest >> testParseExampleBerkely3Message [
	self
		assert: (OSCParser parse: OSCMessage exampleBerkeley3 bytes readStream) first
		equals: OSCMessage exampleBerkeley3Message
]

{ #category : 'tests' }
OSCParserTest >> testParseIncreaseVolumeMessage [
	self
		assert: (OSCParser parse: OSCMessage exampleSCIncreaseVolume bytes readStream) first
		equals: OSCMessage increaseVolumeMessage
]

{ #category : 'tests' }
OSCParserTest >> testParseTimestamp [
	|messages  byteTimestamp  byteStream|
	messages := OSCBundle new. "sendToAddressString: '127.0.0.1'port: 5432."
   byteStream := ByteArray new writeStream .
   messages print: {OSCMessage for: { '/test' . 99}} onOSCStream: byteStream .
   byteStream close.
	byteTimestamp:= (9 to: 16) collect: [ :i | byteStream contents at: i ].
	
	self assert: byteTimestamp  equals: DateAndTime now asNTPTimeStampWithLatency 
	
	
]
