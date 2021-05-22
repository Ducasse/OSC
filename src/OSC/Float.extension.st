Extension { #name : #Float }

{ #category : #'*OSC-printing' }
Float >> printOnOSCStream: aStream [
	aStream nextNumber: 4 put: self asIEEE32BitWord
]

{ #category : #'*OSC-printing' }
Float >> printTypeOnOSCStream: aStream [
	aStream nextPut: $f asInteger.
]
