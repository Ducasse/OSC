Extension { #name : #SmallInteger }

{ #category : #'*OSC-printing' }
SmallInteger >> printOnOSCStream: aStream [
	aStream nextInt32Put: self
]

{ #category : #'*OSC-printing' }
SmallInteger >> printTypeOnOSCStream: aStream [
	aStream nextPut: $i
]
