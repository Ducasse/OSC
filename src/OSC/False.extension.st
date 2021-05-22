Extension { #name : #False }

{ #category : #'*OSC-printing' }
False >> printTypeOnOSCStream: aStream [
	aStream nextPut: $F asInteger
]
