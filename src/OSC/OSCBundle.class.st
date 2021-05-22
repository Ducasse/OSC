Class {
	#name : #OSCBundle,
	#superclass : #OSCPacket,
	#instVars : [
		'packets'
	],
	#category : #'OSC-Kernel'
}

{ #category : #examples }
OSCBundle class >> example1 [
	^self for: {OSCMessage example1 .  OSCMessage example2}
	
]

{ #category : #examples }
OSCBundle class >> example2 [
	^self for: {OSCBundle example1 . OSCMessage example3}
]

{ #category : #printing }
OSCBundle >> print: somePackets onOSCStream: aStream [

	'#bundle' printOnOSCStream: aStream.
	self printTimeTagOnOSCStream: aStream.
	somePackets do: [ :aPacket |
		aPacket oSCSize printOnOSCStream: aStream.
		aStream nextPutAll: aPacket bytes ]
	
]

{ #category : #printing }
OSCBundle >> printTimeTagOnOSCStream: aStream [
	"Not yet implemented, just print 8 empty bytes"
	8 timesRepeat: [ aStream nextPut: 0 ]
]
