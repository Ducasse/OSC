Extension { #name : #UndefinedObject }

{ #category : #'*OSC-printing' }
UndefinedObject >> printOnOSCStream: aStream [
	^self
]

{ #category : #'*OSC-printing' }
UndefinedObject >> printTypeOnOSCStream: aStream [
	aStream nextPut: $N

]
