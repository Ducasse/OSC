Class {
	#name : #OSCMessageTest,
	#superclass : #TestCase,
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCMessageTest >> testByteArrayDecreaseVolume [
	"self debug: #testByteArrayDecreaseVolume"
	
	|aByteArray|
	aByteArray := #(47 115 99 47 109 105 120 101 114 47 118 111 108 117 109 101 0 0 0 0 
					44 105 102 0 0 0 0 1 62 76 204 205) asByteArray.
	self assert: (OSCMessage exampleSCDecreaseVolume byteArray = aByteArray)
]

{ #category : #tests }
OSCMessageTest >> testByteArrayIncreaseVolume [
	"self debug: #testByteArrayIncreaseVolume"
	
	| aByteArray |
	aByteArray := #(47 115 99 47 109 105 120 101 114 47 118 111 108 117 109 101 0 0 0 0 44
					105 102 0 0 0 0 1 63 128 0 0) asByteArray.
	self assert: (OSCMessage exampleSCIncreaseVolume byteArray = aByteArray)
]

{ #category : #tests }
OSCMessageTest >> testByteArrayRun [
	" self debug: #testByteArrayRun "
	self assert: (OSCMessage exampleSCRun byteArray = ('/sc/run',(String with: (Character value: 0) with: $,)) asByteArray)
]

{ #category : #tests }
OSCMessageTest >> testByteArrayStop [
	" self debug: #testByteArrayStop "
	
	self assert: (OSCMessage exampleSCStop byteArray = ('/sc/stop',((String new: 4 withAll: (Character value: 0)),',')) asByteArray)


]

{ #category : #tests }
OSCMessageTest >> testExampleBerkeley2 [
	"See http://www.cnmat.berkeley.edu/OpenSoundControl/OSC-spec-examples.html"
	" self debug: #testExampleBerkeley2 "
	| aByteArray |
	aByteArray := #(
16r2F  16r66  16r6F 16r6F 
 0     0   0  0 
 16r2C   16r69   16r69  16r73
 16r66   16r66  0    0 
 0   0  3 16rE8 
 16rFF  16rFF  16rFF  16rFF 
16r68   16r65  16r6C  16r6C
 16r6F   0 0 0
16r3F 16r9D  16rF3  16rB6
 16r40  16rB5   16rB2  16r2D ) asByteArray.
	self assert: (OSCMessage exampleBerkeley2 byteArray = aByteArray)
]
