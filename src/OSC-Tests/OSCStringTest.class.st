Class {
	#name : #OSCStringTest,
	#superclass : #TestCase,
	#category : #'OSC-Tests'
}

{ #category : #tests }
OSCStringTest >> testPrintOnOSCStream [
	"self debug: #testPrintOnOSCStream"
	
	| aString aStream |
	aStream := (RWBinaryOrTextStream on: '') binary.
	aString := 
		((WriteStream on: '')
			nextPutAll: 'abc';
			nextPut: (Character value: 0);
			contents).
	'abc' printOnOSCStream: aStream.
	self assert: (aStream ascii contents = aString).
	aStream := (RWBinaryOrTextStream on: '') binary.
	aString := 
		((WriteStream on: '')
			nextPutAll: 'abcd';
			nextPutAll: (Array new: 4 withAll: (Character value: 0));
			contents).
	'abcd' printOnOSCStream: aStream.
	self assert: aStream ascii contents equals: aString
]
