Extension { #name : #Symbol }

{ #category : #'*OSC-printing' }
Symbol >> printTypeOnOSCStream: aStream [
	aStream nextPut: $s
]
