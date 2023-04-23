!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'aaa 4/21/2023 23:14:41'!
test04PopReturnsLastPushedObject

	| stack pushedObject poppedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	poppedObject := stack pop .
	self assert: poppedObject = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'abstractions' stamp: 'aaa 4/23/2023 16:18:47'!
raiseErrorMessage: errorMessage whenExecutingClosure: aClosure! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:19:26'!
test01StackStaysTheSameAfterFindingByPrefix

	| stack firstPushedObject secondPushedObject thirdPushedObject fourthPushedObject sentencesFound sentenceFinder expectedResult|
	
	stack := OOStack new.
	firstPushedObject := 'ojala me corrija Nico'.
	secondPushedObject := 'mamadera'.
	thirdPushedObject := 'madre'.
	fourthPushedObject := 'mamul'.
	
	expectedResult:= OrderedCollection new.
	expectedResult addLast:  secondPushedObject.
	expectedResult addLast:  thirdPushedObject.
	expectedResult addLast:  fourthPushedObject.
	
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	stack push: thirdPushedObject.
	stack push: fourthPushedObject.
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'ma' inStack: stack.	
	
	self assert: stack pop = fourthPushedObject.
	self assert: stack pop = thirdPushedObject.
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:19:04'!
test02StackCanBeEmpty

	| stack sentencesFound sentenceFinder|
	
	stack := OOStack new.
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'holamaxi' inStack: stack.	
	
	self assert: sentencesFound isEmpty.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:18:56'!
test03SentencesFoundKeepTheOriginalOrder

	| stack sentencesFound sentenceFinder |
	
	stack := OOStack new.
	
	stack push: 'casa'.
	stack push: 'carlos'.
	stack push: 'chocolate'.
	stack push: 'cantidad'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'ca' inStack: stack.	
	
	self assert: (sentencesFound at: 1) = ('cantidad').
	self assert: (sentencesFound at: 2 ) = ('carlos').
	self assert: (sentencesFound at: 3) = ('casa').
	self assert: sentencesFound size = 3.


! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:19:49'!
test04StackCanOnlyHaveStrings
	|stack sentenceFinder|
	
	stack := OOStack new.
	stack push: 1.
	stack push: stack .
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder findSentenceWithPrefix: 'me' inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix elementIsNotAStringErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:02'!
test05ThereCanBeEmptyWords
	|stack sentencesFound sentenceFinder|
	
	stack := OOStack new.
	stack push: ''.
	stack push: ' '.
	stack push: 'turno'.
	stack push: '  '.
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'tu' inStack: stack.	
	
	self assert: (sentencesFound includes: 'turno').
	self assert: sentencesFound size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:11'!
test06PrefixIsCapSensitive
	| stack sentencesFound sentenceFinder|
	
	stack := OOStack new.
	
	stack push: 'cara'.
	stack push: 'casa'.
	stack push: 'Carlos'.
	stack push: 'castillo'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'ca' inStack: stack.	
	
	self assert: sentencesFound includes: 'cara'.
	self assert: sentencesFound includes: 'casa'.
	self assert: sentencesFound includes: 'castillo'.
	self deny: (sentencesFound includes: 'Carlos').
	self deny: (sentencesFound includes: 'carlos').
	self assert: sentencesFound size = 3.


! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:19'!
test07PrefixCanOnlyBeAString
	
	|stack sentenceFinder|
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder findSentenceWithPrefix: stack inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanOnlyBeANonEmptyStringErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:31'!
test08PrefixCannotBeEmpty
	
	|stack sentenceFinder|
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder findSentenceWithPrefix: '' inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanOnlyBeANonEmptyStringErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:38'!
test09PrefixCannotHaveWhitespaces

	|stack sentenceFinder|
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self
		should: [ sentenceFinder findSentenceWithPrefix: 'ho la' inStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotHaveWhitespacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'aaa 4/23/2023 17:20:46'!
test10PrefixIsNotAtTheBegginingOfTheSentence

	|stack sentencesFound sentenceFinder|
	
	stack := OOStack new.
	stack push: 'hernan wilkinson es un excelente profesor' .
	stack push: 'wilkinson, hernan es un sujeto muy agradable' .
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentencesFound := sentenceFinder findSentenceWithPrefix: 'wilkinson' inStack: stack.	
	
	self assert: sentencesFound includes: 'wilkinson, hernan es un sujeto muy agradable'.
	self deny: (sentencesFound includes: 'hernan wilkinson es un excelente profesor').
	self assert: sentencesFound size = 1 ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:58:23'!
initialize

	top := OOStackBase new.
	size := 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 22:34:06'!
isEmpty

	^size = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aa 4/23/2023 14:33:26'!
pop

	^(top pop) element! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/23/2023 17:21:48'!
push: anElement

	| newElement |
	newElement := OOStackElement new element: anElement previousElement: top stack: self .
	top := newElement .
	size := size + 1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 21:43:15'!
size

	^size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:47:53'!
top

	^top element! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:53:19'!
updateStackAfterPopping: anElement

	top := anElement .
	size := size - 1 .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStack subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:48:04'!
element

	^self error: OOStack stackEmptyErrorDescription ! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:51:54'!
initialize 
! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 22:25:58'!
pop

	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
OOStack subclass: #OOStackElement
	instanceVariableNames: 'element previous stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 21:25:31'!
element

	^element! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 22:54:25'!
element: anElement previousElement: previousElement stack: aStack

	previous := previousElement .
	element := anElement .
	stack := aStack
	
	! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 22:11:35'!
initialize! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 23:53:41'!
pop

	stack updateStackAfterPopping: previous .
	^self! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 21:25:15'!
previous

	^previous! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'aaa 4/21/2023 21:24:21'!
initializeWith: anElement previous: previousElement

	^self new element: anElement previousElement: previousElement ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'main' stamp: 'aaa 4/23/2023 17:12:06'!
findSentenceWithPrefix: prefixToFind inStack: stackToExplore

	| collectionOfWordsWithPrefix auxiliarStackToRepopulateStack |
	
	self checkIfPrefixIsValid: prefixToFind .
	
	collectionOfWordsWithPrefix := OrderedCollection new .
	auxiliarStackToRepopulateStack := OOStack new.
		
	self iterateThroughStack: stackToExplore toFindSentencesThatBeginWithAPrefix: prefixToFind resultCollection: collectionOfWordsWithPrefix auxiliaryStack: auxiliarStackToRepopulateStack .
	
	self repopulateStack: stackToExplore withValuesFromAuxiliaryStack: auxiliarStackToRepopulateStack .
	
	^collectionOfWordsWithPrefix! !


!SentenceFinderByPrefix methodsFor: 'abstractions' stamp: 'aaa 4/23/2023 15:14:13'!
checkIfPrefixIsValid: aPrefix

	(aPrefix isKindOf: String) ifFalse: [^self error: SentenceFinderByPrefix prefixCanOnlyBeANonEmptyStringErrorDescription ] .
	(aPrefix includesSubString: ' ') ifTrue: [^self error: SentenceFinderByPrefix prefixCannotHaveWhitespacesErrorDescription ] .
	(aPrefix isEmpty) ifTrue: [^self error: SentenceFinderByPrefix prefixCanOnlyBeANonEmptyStringErrorDescription ] .! !

!SentenceFinderByPrefix methodsFor: 'abstractions' stamp: 'aaa 4/23/2023 17:13:14'!
ifASentence: aSentence beginsWithPrefix: aPrefix addToResultCollection: resultCollection andAuxiliaryStack: auxiliaryStack

	(aSentence isKindOf: String) ifFalse: [^self error: SentenceFinderByPrefix elementIsNotAStringErrorDescription ] .
	(aSentence beginsWith: aPrefix ) ifTrue: [resultCollection addLast: aSentence ].
	auxiliaryStack push: aSentence .! !

!SentenceFinderByPrefix methodsFor: 'abstractions' stamp: 'aaa 4/23/2023 17:13:22'!
iterateThroughStack: aStack toFindSentencesThatBeginWithAPrefix: aPrefix resultCollection: resultCollection auxiliaryStack: auxiliaryStack

	| currentWordToMatchToPrefix |

	(aStack size) timesRepeat: [
		currentWordToMatchToPrefix := aStack pop.
		self ifASentence: currentWordToMatchToPrefix beginsWithPrefix: aPrefix addToResultCollection: resultCollection andAuxiliaryStack: auxiliaryStack .
		].! !

!SentenceFinderByPrefix methodsFor: 'abstractions' stamp: 'aaa 4/23/2023 17:12:25'!
repopulateStack: aStack withValuesFromAuxiliaryStack: auxiliaryStack

	(auxiliaryStack size) timesRepeat: [
		aStack push: auxiliaryStack pop.
		].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'aaa 4/23/2023 14:38:22'!
elementIsNotAStringErrorDescription

	^'Element is not a string!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'aaa 4/23/2023 14:41:16'!
prefixCanOnlyBeANonEmptyStringErrorDescription

	^'Prefix can only be a non empty string!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'aaa 4/23/2023 14:41:58'!
prefixCannotHaveWhitespacesErrorDescription

	^'Prefix cannot have whitespaces!!!!'! !
