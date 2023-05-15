!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:26'!
test01CreatingARoverPlacesItInAPosition

	self assert: 1@1 equals: (MarsRover placeIn: 1@1 facing: North new) position! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:37'!
test02CreatingARoverMakesItFaceADirection

	self assert: North equals: ((MarsRover placeIn: 1@1 facing: North new) direction) class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:45'!
test03ReceivingAnEmptyCommandStringDoesNothing

	| rover |
	rover := MarsRover placeIn: 1@1 facing: North new .
	rover processCommands: '' .

	self assert: 1@1 equals: rover position .
	self assert: North equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:48'!
test04ReceivingAForwardCommandStringMovesItsPosition

	| rover |
	rover := MarsRover placeIn: 1@1 facing: South new .
	rover processCommands: 'f' .

	self assert: 1@0 equals: rover position .
	self assert: South equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:50'!
test05ReceivingABackwardsCommandStringMovesItsPosition

	| rover |
	rover := MarsRover placeIn: 1@1 facing: East new .
	rover processCommands: 'b' .

	self assert: 0@1 equals: rover position .
	self assert: East equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:52'!
test06ReceivingALeftCommandStringRotatesIt90DegreesAnticlockwise

	| rover |
	rover := MarsRover placeIn: 1@1 facing: East new .
	rover processCommands: 'l' .

	self assert: 1@1 equals: rover position .
	self assert: North equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:53'!
test07ReceivingARightCommandStringRotatesIt90DegreesClockwise

	| rover |
	rover := MarsRover placeIn: 1@1 facing: South new .
	rover processCommands: 'r' .

	self assert: 1@1 equals: rover position .
	self assert: West equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:32:55'!
test08ReceivingMultipleForwardCommandStringMovesItsPositionMultipleTimes

	| rover |
	rover := MarsRover placeIn: 1@1 facing: East new .
	rover processCommands: 'ffff' .

	self assert: 5@1 equals: rover position .
	self assert: East equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:33:00'!
test09ReceivingMultipleBackwardsCommandStringMovesItsPositionMultipleTimes

	| rover |
	rover := MarsRover placeIn: 1@1 facing: North new .
	rover processCommands: 'bbbbbb' .

	self assert: 1@-5 equals: rover position .
	self assert: North equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:33:03'!
test10ReceivingMultipleLeftCommandStringChangesItsDirectionMultipleTimes

	| rover |
	rover := MarsRover placeIn: 1@1 facing: North new .
	rover processCommands: 'lllll' .

	self assert: 1@1 equals: rover position .
	self assert: West equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:33:05'!
test11ReceivingMultipleRightCommandStringChangesItsDirectionMultipleTimes

	| rover |
	rover := MarsRover placeIn: 1@1 facing: East new .
	rover processCommands: 'rrrrrrrr' .

	self assert: 1@1 equals: rover position .
	self assert: East equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 18:33:07'!
test12ReceivingAnInvalidCommandStopsTheExecution

	| rover |
	rover := MarsRover placeIn: 1@1 facing: East new .

	self
		should: [ rover processCommands: 'rtrr' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidCommandError ]! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 19:57:25'!
test13ReceivingShuffledCommandStringChangesDirectionProperly

	| rover |
	rover := MarsRover placeIn: 1@1 facing: North new .
	rover processCommands: 'lrfbffrfbrlbbbll' .
	
	"en este test pusimos varios comandos para probar el correcto funcionamiento en un caso general, prestar atención a que hacer fb o bf cancela el movimiento asi como hacer lr o rl   cancela el giro"
	
	self assert: -2@3 equals: rover position .
	self assert: West equals: rover direction class! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 19:57:34'!
test14FailsWhenPlacingTheRoverInANonMapPosition

	self
		should: [MarsRover placeIn: 1 facing: East new ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidPositionError ]! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 19:57:41'!
test15FailsWhenPlacingTheRoverInANonCardinalPointDirection

	self
		should: [MarsRover placeIn: 1@1 facing: 90 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidOrientationError ]! !


!classDefinition: #CardinalDirections category: 'MarsRover'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #East category: 'MarsRover'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:23'!
howToMoveBackwards

	^-1@0! !

!East methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:09'!
howToMoveForward 

	^1@0! !

!East methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:37'!
howToRotateLeft

	^North new! !

!East methodsFor: 'as yet unclassified' stamp: 'aa 5/14/2023 19:51:01'!
howToRotateRight

	^South new! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:24'!
howToMoveBackwards

	^0@-1! !

!North methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:09'!
howToMoveForward

	^0@1! !

!North methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:37'!
howToRotateLeft

	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:45'!
howToRotateRight

	^East new! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:24'!
howToMoveBackwards

	^0@1! !

!South methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:09'!
howToMoveForward

	^0@-1! !

!South methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:37'!
howToRotateLeft

	^East new! !

!South methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:45'!
howToRotateRight

	^West new! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:24'!
howToMoveBackwards

	^1@0! !

!West methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:09'!
howToMoveForward

	^-1@0! !

!West methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:37'!
howToRotateLeft

	^South new! !

!West methodsFor: 'as yet unclassified' stamp: 'aa 5/13/2023 22:50:45'!
howToRotateRight

	^North new! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction availableCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'aa 5/14/2023 18:32:08'!
initializeIn: aPosition facing: aDirection 

	position := aPosition .
	direction := aDirection .
	self populateCommandsDictionary! !

!MarsRover methodsFor: 'initialization' stamp: 'aa 5/13/2023 22:58:12'!
populateCommandsDictionary

	availableCommands := Dictionary new  
	add:	$f ->[:rover | rover moveForward ] ; 
	add: $b ->[:rover | rover moveBackwards ]; 
	add: $l ->[:rover | rover rotateLeft ]; 
	add: $r ->[:rover | rover rotateRight ]; yourself! !


!MarsRover methodsFor: 'getters' stamp: 'aa 5/13/2023 18:45:16'!
direction

	^direction! !

!MarsRover methodsFor: 'getters' stamp: 'aa 5/13/2023 18:44:26'!
position

	^position! !


!MarsRover methodsFor: 'actions' stamp: 'aa 5/13/2023 22:56:28'!
moveBackwards

	position := position + direction howToMoveBackwards ! !

!MarsRover methodsFor: 'actions' stamp: 'aa 5/13/2023 22:56:18'!
moveForward

	position := position + direction howToMoveForward ! !

!MarsRover methodsFor: 'actions' stamp: 'aa 5/13/2023 23:00:23'!
processCommands: stringCommand 
	
	stringCommand asOrderedCollection do: [:each | 
		(availableCommands at: each ifAbsent: [^self error: MarsRover invalidCommandError]) value: self
		] .
	
		! !

!MarsRover methodsFor: 'actions' stamp: 'aa 5/13/2023 22:59:16'!
rotateLeft

	direction := direction howToRotateLeft! !

!MarsRover methodsFor: 'actions' stamp: 'aa 5/13/2023 22:57:15'!
rotateRight

	direction := direction howToRotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 5/13/2023 22:27:57'!
invalidCommandError

	^'Invalid command received'! !

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 5/14/2023 18:19:49'!
invalidOrientationError

	^'That is not a valid starting orientation!!'! !

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 5/14/2023 18:19:37'!
invalidPositionError

	^'That is not a valid starting position!!'! !

!MarsRover class methodsFor: 'instance creation' stamp: 'aa 5/14/2023 18:32:14'!
placeIn: aPoint facing: aDirection 
		
	(aPoint isKindOf: Point) ifFalse: [^self error: MarsRover invalidPositionError ] .
	(aDirection isKindOf: CardinalDirections) ifFalse: [^self error: MarsRover invalidOrientationError ] .
	
	^self new initializeIn: aPoint facing: aDirection ! !
