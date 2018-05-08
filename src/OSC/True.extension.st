Extension { #name : #True }

{ #category : #'*OSC-printing' }
True >> printTypeOnOSCStream: aStream [
	aStream nextPut: $T
]
