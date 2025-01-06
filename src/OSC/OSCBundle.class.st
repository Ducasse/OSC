"
An OSC Bundle consists of the OSC-string “#bundle” followed by an OSC Time Tag , followed by zero or more OSC Bundle Elements. 
"

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
	"Add a timestamp with 50 milliseconds of latency, as necessary to use together with SuperCollider - remove addLatency: 50000000 or change the latency value
	if necesaary"
| dateAndTimeInBytes |
	
	dateAndTimeInBytes := (DateAndTime now addLatency: 50000000 ) asNTPTimeStamp  .
	
	aStream nextPutAll: dateAndTimeInBytes  

]
