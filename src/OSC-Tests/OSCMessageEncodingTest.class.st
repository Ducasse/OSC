Class {
	#name : #OSCMessageEncodingTest,
	#superclass : #TestCase,
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCMessageEncodingTest >> testByteArrayDecreaseVolume [
	self 
		assert: OSCMessage exampleSCDecreaseVolume bytes
		equals: #[47 115 99 47 109 105 120 101 114 47 118 111 108 117 109 101 0 0 0 0 44 105 102 0 0 0 0 1 62 76 204 205].
]

{ #category : #tests }
OSCMessageEncodingTest >> testByteArrayIncreaseVolume [
	self 
		assert: OSCMessage exampleSCIncreaseVolume bytes
		equals: #[47 115 99 47 109 105 120 101 114 47 118 111 108 117 109 101 0 0 0 0 44 105 102 0 0 0 0 1 63 128 0 0].
	
]

{ #category : #tests }
OSCMessageEncodingTest >> testByteArrayRun [
	self
		assert: OSCMessage exampleSCRun bytes
		equals: ('/sc/run' , (String with: (Character value: 0) with: $,)) asByteArray
]

{ #category : #tests }
OSCMessageEncodingTest >> testByteArrayStop [	
	self 
		assert: OSCMessage exampleSCStop bytes
		equals: ('/sc/stop',((String new: 4 withAll: (Character value: 0)),',')) asByteArray


]

{ #category : #tests }
OSCMessageEncodingTest >> testExampleBerkeley2 [
	"See http://www.cnmat.berkeley.edu/OpenSoundControl/OSC-spec-examples.html"
	self 
		assert: OSCMessage exampleBerkeley2 bytes
		equals:  #[
			16r2F  16r66  16r6F 16r6F 
			0      0      0     0 
			16r2C  16r69  16r69  16r73
			16r66  16r66  0      0 
			0      0      3      16rE8 
			16rFF  16rFF  16rFF  16rFF 
			16r68  16r65  16r6C  16r6C
 			16r6F  0      0      0
			16r3F  16r9D  16rF3  16rB6
			16r40  16rB5  16rB2  16r2D].
]
