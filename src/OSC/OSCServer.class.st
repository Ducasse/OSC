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
	| buffer bytesReceived |
	self terminate.
	socket := (Socket udpCreateIfFail: [self error: 'Problems connecting to:',aPort asString]) setPort: aPort.
	process := 
	[
		buffer := ByteArray new: 2048.
		[
			bytesReceived := (socket receiveUDPDataInto: buffer) first 
			"N.B.: receiveUDPDataInto: returns an array with [bytesReceived | IP Address | port | more datagrams follow?]".
			bytesReceived > 0 ifTrue: [ self receive: (buffer copyFrom: 1 to: bytesReceived) readStream].
		] repeat 
	] forkAt: Processor userBackgroundPriority.

]

{ #category : #accessing }
OSCServer >> nextMessage [
	^ messageQueue next
]

{ #category : #action }
OSCServer >> receive: aByteStream [
	(OSCParser parse: aByteStream)
		do: [:eachMessageArray |  messageQueue nextPut: eachMessageArray].
	Delay forMilliseconds: responsePeriod.
]

{ #category : #'initialize-release' }
OSCServer >> terminate [
	socket notNil ifTrue: [socket destroy].
	process notNil ifTrue: [process terminate]
]
