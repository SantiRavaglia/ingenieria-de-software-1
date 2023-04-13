!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'abstractions' stamp: 'santi 4/12/2023 10:44:49'!
addCustomer: nameOfCustomerToSuspend andSuspendItFromCustomerBook: customerBook 

	customerBook addCustomerNamed: nameOfCustomerToSuspend.
	customerBook suspendCustomerNamed: nameOfCustomerToSuspend.! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'santi 4/12/2023 23:21:09'!
assertWhoIsTheOnlyCustomer: nameOfTheOnlyCustomer inACustomerBook: customerBook

    self assert: customerBook numberOfCustomers = 1.
    self assert: (customerBook includesCustomerNamed: nameOfTheOnlyCustomer)
! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'as 4/10/2023 21:45:02'!
calculatesExecutionTime: codeToExecute 

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	[codeToExecute].
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning)! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'santi 4/12/2023 10:48:22'!
testCustomerBook: customerBook mustHaveActiveCustomers: NumberOfactiveCustomers suspendedCustomers: NumberOfsuspendedCustomers totalCustomers: NumberOftotalCustomers

	self assert: NumberOfactiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: NumberOfsuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: NumberOftotalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'santi 4/13/2023 12:50:26'!
testsInvalidAction: codeToExecute returnsErrorType: errorType assertsOnError: assertsToExecute

	[ codeToExecute value .
	self fail ]
		on: errorType 
		do: [assertsToExecute]
		! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'santi 4/12/2023 23:34:14'!
time: time mustBeLowerThan: maxTime

	self assert: (time ) < (maxTime * millisecond)! !


!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/12/2023 23:34:22'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook finalMinusInitialMiliseconds |
	
	customerBook := CustomerBook new.
	
	finalMinusInitialMiliseconds := self calculatesExecutionTime: [customerBook addCustomerNamed: 'John Lennon'] .
	
	self time: finalMinusInitialMiliseconds mustBeLowerThan: 50
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/12/2023 23:34:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook finalMinusInitialMiliseconds paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	finalMinusInitialMiliseconds := self calculatesExecutionTime: [customerBook removeCustomerNamed: paulMcCartney] .
	
	self time: finalMinusInitialMiliseconds mustBeLowerThan: 100
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/13/2023 12:50:09'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self testsInvalidAction: [customerBook addCustomerNamed: ''] returnsErrorType: Error assertsOnError: [:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/13/2023 12:50:19'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self testsInvalidAction: [customerBook removeCustomerNamed: 'Paul McCartney'] returnsErrorType: NotFound assertsOnError: [ :anError | 
			self assertWhoIsTheOnlyCustomer: johnLennon inACustomerBook: customerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/12/2023 23:14:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addCustomer: paulMcCartney andSuspendItFromCustomerBook: customerBook .
	
	self testCustomerBook: customerBook mustHaveActiveCustomers: 0 suspendedCustomers: 1 totalCustomers: 1 .
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/12/2023 23:05:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	self addCustomer: paulMcCartney andSuspendItFromCustomerBook: customerBook .
	customerBook removeCustomerNamed: paulMcCartney.

	self testCustomerBook: customerBook mustHaveActiveCustomers: 0 suspendedCustomers: 0 totalCustomers: 0 .
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/13/2023 12:53:34'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self testsInvalidAction: [ customerBook suspendCustomerNamed: 'George Harrison'] returnsErrorType: CantSuspend assertsOnError: [:anError | self assertWhoIsTheOnlyCustomer: johnLennon inACustomerBook: customerBook ]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'santi 4/13/2023 12:53:52'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addCustomer: johnLennon andSuspendItFromCustomerBook: customerBook .
	
	self testsInvalidAction: [ customerBook suspendCustomerNamed: johnLennon] returnsErrorType: CantSuspend assertsOnError: [:anError | self assertWhoIsTheOnlyCustomer: johnLennon inACustomerBook: customerBook ] .
	
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'abstractions' stamp: 'santi 4/13/2023 13:03:37'!
removesElement: elementToRemove fromCollection: collectionToModify
 
	1 to: collectionToModify size do: 
	[ :index |
		elementToRemove = (collectionToModify at: index)
			ifTrue: [
				collectionToModify removeAt: index.
				^[^elementToRemove] .
			] 
	].
	
! !


!CustomerBook methodsFor: 'customer management' stamp: 'santi 4/13/2023 13:06:53'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'santi 4/13/2023 12:55:59'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'santi 4/13/2023 13:13:40'!
removeCustomerNamed: aName 
 
	self removesElement: aName fromCollection: active . 
	self removesElement: aName fromCollection: suspended .

	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
