"
OSCServer is a simple server listening for messages (instance of OSCMessage) on a port.
"
Class {
	#name : #OSCServer,
	#superclass : #Object,
	#instVars : [
		'process',
		'socket',
		'messageQueue',
		'responsePeriod'
	],
	#category : #'OSC-Kernel'
}

{ #category : #'as yet unclassified' }
OSCServer class >> listenOnPort: aPort [
	"(self listenOnPort: 7010) inspect"
	^self new listenOnPort: aPort
]

{ #category : #testing }
OSCServer >> hasMessage [
	^messageQueue isEmpty not
]

{ #category : #'initialize-release' }
OSCServer >> initialize [
	super initialize.
	messageQueue := SharedQueue new.
	responsePeriod := 10.
]

{ #category : #action }
OSCServer >> listenOnPort: aPort [
	|  dataStream buf anArray sizeOfBuf |
	self terminate.
	socket := (Socket udpCreateIfFail: [self error: 'Problems connecting to:',aPort asString]) setPort:  aPort.
	process := 
	[
		[dataStream := (RWBinaryOrTextStream on: (String new: 2048)) binary;yourself.
		buf := String new: 2048. 
		anArray:=socket receiveUDPDataInto: buf.
		sizeOfBuf := anArray first.
		1 to: sizeOfBuf do: [:ii | dataStream nextPut: (buf at: ii)].
		dataStream reset.
		sizeOfBuf > 0 ifTrue: [ self receive: dataStream] ] 
			repeat ]  forkAt: Processor userBackgroundPriority.

]

{ #category : #accessing }
OSCServer >> nextMessage [
	^ messageQueue next
]

{ #category : #action }
OSCServer >> receive:aByteStream [

	(OSCParser parse: aByteStream ascii) 
		do: [:eachMessageArray |  messageQueue nextPut:eachMessageArray ].
	Delay forMilliseconds: responsePeriod.
]

{ #category : #'initialize-release' }
OSCServer >> terminate [
	socket notNil ifTrue: [socket destroy].
	process notNil ifTrue: [process terminate]
]
