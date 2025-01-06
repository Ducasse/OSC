"
OSC Packet ishe unit of transmission of OSC is an . Any application that sends OSC Packets is an OSC Client; any application that receives OSC Packets is an OSC Server
An OSC packet consists of its contents , a contiguous block of binary data, and its size , the number of 8-bit bytes that comprise the contents. The size of an OSC packet is always a multiple of 4.
"
Class {
	#name : 'OSCPacket',
	#superclass : 'Object',
	#instVars : [
		'byteStream'
	],
	#category : 'OSC-Kernel',
	#package : 'OSC',
	#tag : 'Kernel'
}

{ #category : 'access to cache' }
OSCPacket class >> for: somePackets [
	^ self new initializeFor: somePackets 
]

{ #category : 'accessing' }
OSCPacket >> byteArray [
	^self byteStream binary contents
]

{ #category : 'accessing' }
OSCPacket >> byteStream [
	^byteStream
]

{ #category : 'accessing' }
OSCPacket >> bytes [
	^self byteStream contents
]

{ #category : 'initialization' }
OSCPacket >> initializeFor: somePackets [
	byteStream := ByteArray new writeStream.
	self print: somePackets onOSCStream: byteStream
]

{ #category : 'testing' }
OSCPacket >> isBundle [
	^ (byteStream contents at: 1 ) = 35
	
 
]

{ #category : 'accessing' }
OSCPacket >> oSCSize [
	^self bytes size
]

{ #category : 'printing' }
OSCPacket >> print: somePackets onOSCStream: aStream [
	self subclassResponsibility
]

{ #category : 'action' }
OSCPacket >> sendTo: aByteArray port: aPort [ 
	"Take care, A byte array is not a string.
	If you want to send to e.g. '192.168.0.2' 
	sendToAddressString: port: instead
	But use this one if you want to be fast."
	| aSocket |
	Socket initializeNetwork.
	aSocket := Socket newUDP.
	aSocket
		sendUDPData: self bytes
		toHost: aByteArray
		port: aPort;
		 close;
		 destroy
]

{ #category : 'action' }
OSCPacket >> sendToAddressString: anAddressString port: aPort [ 
	self 
		sendTo: ((anAddressString findTokens: '.') collect: [:e | e asNumber]) 
				asByteArray
		port: aPort
]

{ #category : 'action' }
OSCPacket >> sendToYourself [
	self sendTo: NetNameResolver localHostAddress port: 57123
]
