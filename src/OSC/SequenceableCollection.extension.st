Extension { #name : #SequenceableCollection }

{ #category : #'*OSC-printing' }
SequenceableCollection >> printOnOSCStream: aStream [
	self do: [:each | each printOnOSCStream: aStream]
]

{ #category : #'*OSC-printing' }
SequenceableCollection >> printTypeOnOSCStream: aStream [
	aStream nextPut: $[.
	self do: [:each | each printTypeOnOSCStream: aStream].
	aStream nextPut: $]
]
