Extension { #name : #String }

{ #category : #'*OSC-printing' }
String >> printOnOSCStream: aStream [

	self isEmpty ifTrue: [^self].
	aStream nextPutAll: self asByteArray.
	(4 - (self size \\ 4)) timesRepeat: [aStream nextPut: 0]

]

{ #category : #'*OSC-printing' }
String >> printTypeOnOSCStream: aStream [
	aStream nextPut: $s asInteger

]
