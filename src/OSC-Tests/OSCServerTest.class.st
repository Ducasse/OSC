Class {
	#name : 'OSCServerTest',
	#superclass : 'TestCase',
	#category : 'OSC-Tests',
	#package : 'OSC-Tests'
}

{ #category : 'tests' }
OSCServerTest >> testSendAndReceive [

	| server |
	server := OSCServer listenOnPort: 5432.
	[
	OSCMessage example1
		sendTo: NetNameResolver localHostAddress
		port: 5432.
	30 milliSeconds wait.
	self assert: server hasMessage.
	self assert: server nextMessage equals: #( '/example1' 100 ) ]
		ensure: [ server terminate ]
]
