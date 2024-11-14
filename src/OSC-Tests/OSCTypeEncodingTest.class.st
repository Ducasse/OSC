Class {
	#name : 'OSCTypeEncodingTest',
	#superclass : 'TestCase',
	#category : 'OSC-Tests',
	#package : 'OSC-Tests'
}

{ #category : 'tests' }
OSCTypeEncodingTest >> testEncodeFloat [
	|aStream|
	aStream := ByteArray new writeStream.
	10.7567 printOnOSCStream: aStream.
	self assert: aStream contents equals: #[65 44 27 113].
]

{ #category : 'tests' }
OSCTypeEncodingTest >> testEncodeSmallInteger [
	| aStream |
	aStream := ByteArray new writeStream.
	1124 printOnOSCStream: aStream.
	self assert: aStream contents equals: #[0 0 4 100].
]

{ #category : 'tests' }
OSCTypeEncodingTest >> testEncodeString [
	|expectedBytes bytesFromEncoder|
	expectedBytes := ByteArray streamContents: [:out |
		out 
			nextPutAll: (ZnCharacterEncoder ascii encodeString: 'abc') ;
			nextPut: 0.
	].

	bytesFromEncoder := ByteArray new writeStream.	
	'abc' printOnOSCStream: bytesFromEncoder.
	self assert: expectedBytes equals: bytesFromEncoder contents.
	
	expectedBytes := ByteArray streamContents: [:out |
		out 
			nextPutAll: (ZnCharacterEncoder ascii encodeString: 'abcd') ;
			nextPutAll: (ByteArray new: 4 withAll: 0).
	].	
	
	bytesFromEncoder := ByteArray new writeStream.
	'abcd' printOnOSCStream: bytesFromEncoder.
	self assert: expectedBytes equals: bytesFromEncoder contents.	
]
