Class {
	#name : #OSCSmallIntegerTest,
	#superclass : #TestCase,
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCSmallIntegerTest >> testPrintOnOSCStream [
	"self debug: #testPrintOnOSCStream"
	| aByteArray aStream |
	aStream := (RWBinaryOrTextStream on: '') binary.
	aByteArray :=
		((RWBinaryOrTextStream on: '')
			binary;
			nextPut: 0;
			nextPut: 0;
			nextPut: 4;
			nextPut: 100;
			contents).
	1124 printOnOSCStream: aStream.
	self assert: aStream contents equals: aByteArray
]
