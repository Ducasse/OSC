"
OSCServer is a simple server listening for messages (instance of OSCMessage) on a port.
"
Class {
	#name : 'OSCServer',
	#superclass : 'Object',
	#instVars : [
		'process',
		'socket',
		'messageQueue',
		'responsePeriod',
		'messageCallback'
	],
	#category : 'OSC-Kernel',
	#package : 'OSC',
	#tag : 'Kernel'
}

{ #category : 'as yet unclassified' }
OSCServer class >> listenOnPort: aPort [
	"(self listenOnPort: 7010) inspect"
	^self new listenOnPort: aPort
]

{ #category : 'testing' }
OSCServer >> hasMessage [
	^messageQueue isEmpty not
]

{ #category : 'initialize-release' }
OSCServer >> initialize [
	super initialize.
	messageQueue := SharedQueue new.
	responsePeriod := 10.
	messageCallback := [ :a :v |
	                   ('OSC address: ' , a , ' value: ' , v asString)
		                   traceCr ]
]

{ #category : 'action' }
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

{ #category : 'accessing' }
OSCServer >> messageCalback [
	^ messageCallback
]

{ #category : 'accessing' }
OSCServer >> messageCalback: aBlockWith2Arguments [
	messageCallback := aBlockWith2Arguments
]

{ #category : 'accessing' }
OSCServer >> nextMessage [
	^ messageQueue next
]

{ #category : 'action' }
OSCServer >> receive: aByteStream [

	(OSCParser parse: aByteStream) do: [ :eachMessageArray |
		"| paramAddress |
		paramAddress := ((eachMessageArray first) findTokens: $/) at: 2."
		messageQueue nextPut: eachMessageArray.
		messageCallback value: eachMessageArray "first value: (eachMessageArray at: 2 ifAbsent: [nil])" ].
	Delay forMilliseconds: responsePeriod
]

{ #category : 'initialize-release' }
OSCServer >> terminate [
	socket notNil ifTrue: [socket close.  "Explicitly close the socket"
        socket destroy.
        socket := nil.].
	process notNil ifTrue: [process terminate]
]
