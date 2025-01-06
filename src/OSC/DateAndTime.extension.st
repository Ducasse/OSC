Extension { #name : 'DateAndTime' }

{ #category : '*OSC-printing' }
DateAndTime >> addLatency: aLatencyInNanoSeconds [
	"add nanoseconds to the current time"

	
	^ self class basicNew
		setJdn: julianDayNumber
			seconds: seconds
			nano: nanos + aLatencyInNanoSeconds 
			offset: self offset;
		yourself
]

{ #category : '*OSC-printing' }
DateAndTime >> asNTPTimeStamp [
" convert DateAndTime to NTPTimestamp for OSC bundles and adds 50 milliseconds of latency, to schedule messages ahead of time in SuperCollider"
	| sec microsec ntpTimeStamp |
	
	sec := self asUnixTime + 2208988800 asByteArrayOfSize: 4.
	microsec := (self nanoSecond * (2 raisedToInteger: 32)
	            / (10 raisedToInteger: 9)) asInteger asByteArrayOfSize: 4.
	ntpTimeStamp := sec , microsec.

	^ ntpTimeStamp
]

{ #category : '*OSC-printing' }
DateAndTime >> asNTPTimeStampWithLatency [
" convert DateAndTime to NTPTimestamp for OSC bundles and adds 50 milliseconds of latency, to schedule messages ahead of time in SuperCollider"
	| sec microsec ntpTimeStamp latency |
	latency :=  50000000.
	sec := self asUnixTime + 2208988800 asByteArrayOfSize: 4.
	microsec := (self nanoSecond + latency * (2 raisedToInteger: 32)
	            / (10 raisedToInteger: 9)) asInteger asByteArrayOfSize: 4.
	ntpTimeStamp := sec , microsec.

	^ ntpTimeStamp
]

{ #category : '*OSC-printing' }
DateAndTime >> microSecond [

^ nanos / 1000
]
