Class {
	#name : #OSCFloatTest,
	#superclass : #TestCase,
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCFloatTest >> testPrintOnOSCStream [
"
	self debug: #testPrintOnOSCStream
"
	|aByteArray aStream|
	aStream :=  (RWBinaryOrTextStream on: '') binary.
	aByteArray :=
		((RWBinaryOrTextStream on: '')
			binary;
			nextPut: 65;
			nextPut: 44;
			nextPut: 27;
			nextPut: 113;
			contents).
	10.7567 printOnOSCStream: aStream.
	self assert: aStream contents equals: aByteArray
]
