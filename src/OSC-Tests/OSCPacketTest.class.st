Class {
	#name : 'OSCPacketTest',
	#superclass : 'TestCase',
	#category : 'OSC-Tests',
	#package : 'OSC-Tests'
}

{ #category : 'tests' }
OSCPacketTest >> testOSCPacketIsBundle [

| pk |
pk := OSCBundle for: { OSCMessage for: { 'test' . 99 } }.
self assert: pk isBundle
]
