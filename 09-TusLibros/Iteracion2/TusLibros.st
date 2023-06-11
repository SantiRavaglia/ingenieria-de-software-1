!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:54:43'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	self 
		should: [ cart add: objectFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:57:12'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	cart add: objectFactory itemSelledByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:57:25'!
test04CanNotAddNonPositiveNumberOfItems

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	self 
		should: [cart add: 0 of: objectFactory itemSelledByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:57:41'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	self 
		should: [cart add: 2 of: objectFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:57:57'!
test06CartRemembersAddedItems

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	cart add: objectFactory itemSelledByTheStore.
	self assert: (cart includes: objectFactory itemSelledByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:58:09'!
test07CartDoesNotHoldNotAddedItems

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	self deny: (cart includes: objectFactory itemSelledByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'aa 6/11/2023 13:58:22'!
test08CartRemembersTheNumberOfAddedItems

	| cart objectFactory |
	
	objectFactory := ObjectFactory new .
	cart := objectFactory createCart.
	
	cart add: 2 of: objectFactory itemSelledByTheStore.
	self assert: (cart occurrencesOf: objectFactory itemSelledByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'aa 6/10/2023 17:43:52'!
defaultCatalog
	
	^ Array with: self itemSelledByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'aa 6/10/2023 17:43:52'!
itemSelledByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:52:18'!
test01CheckingOutWithAnEmptyCartRaisesError

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	creditCard := objectFactory validCard .
	cart := objectFactory createCart .
	
	self 
		should: [ Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartIsEmptyErrorMessage ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 14:08:05'!
test02CheckingOutWithOneItemSucceeds

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	creditCard := objectFactory validCard .
	cart := objectFactory createCart .
	cart add: objectFactory itemSelledByTheStore .
	self assert: ( Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor ) equals: ('Compra exitosa') .
	self assert: salesBook equals: (OrderedCollection with: objectFactory itemSelledByTheStore -> 1) .
	self assert: 95 equals: (creditCard at: #Credit)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 14:00:58'!
test03CheckingOutWithMultipleItemsSucceeds

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	creditCard := objectFactory validCard .
	cart := objectFactory createCart .
	cart add: objectFactory itemSelledByTheStore .
	cart add: objectFactory anotherItemSelledByTheStore .
	self assert: ( Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor ) equals: ('Compra exitosa') .
	self assert: salesBook equals: (OrderedCollection with: (objectFactory anotherItemSelledByTheStore -> 1) with: (objectFactory itemSelledByTheStore -> 1) ) .
	self assert: 88 equals: (creditCard at: #Credit)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:53:14'!
test04CheckingOutWithExpiredCardRaisesError

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	creditCard := objectFactory expiredCard .
	cart := objectFactory createCart .
	cart add: objectFactory itemSelledByTheStore .
	
	self 
		should: [ ( Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor ) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardIsExpiredErrorMessage ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:53:18'!
test05CheckingOutWithCreditLessCardRaisesError

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	
	creditCard := objectFactory creditLessCard .
	
	cart := objectFactory createCart .
	cart add: 2 of: objectFactory itemSelledByTheStore .
	
	self 
		should: [ ( Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor creditCardHasNotEnoughCreditErrorMessage ]
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:53:20'!
test06CheckingOutWithStolenCardRaisesError

	| cart creditCard salesBook merchantProcessor objectFactory |
	
	objectFactory := ObjectFactory new .
	
	merchantProcessor := MerchantProcessor new .
	salesBook := OrderedCollection new .
	
	creditCard := objectFactory stolenCard .
	
	cart := objectFactory createCart .
	cart add: 2 of: objectFactory itemSelledByTheStore .
	
	self 
		should: [ ( Cashier with: cart card: creditCard time: DateAndTime now register: salesBook through: merchantProcessor) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor creditCardIsStolenErrorMessage ]
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'aa 6/11/2023 13:39:30'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'aa 6/11/2023 13:41:03'!
addItemsToSalesBook: aSalesBook

	catalog keysDo: [ :each | 
		| ocurrences |
		ocurrences := 		self occurrencesOf: each .
		ocurrences > 0 ifTrue: [ aSalesBook add: (each->ocurrences) ] .
		]! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'aa 6/11/2023 13:45:24'!
total

	^items inject: 0 into: [ :sum :each |
		 sum + (catalog at: each)
		]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'aa 6/11/2023 13:46:31'!
checkout: aCart withCard: aCreditCard time: aDate register: aSalesBook through: aMerchantProcessor
	

	aMerchantProcessor debitAmount: aCart total from: aCreditCard .
	aCart addItemsToSalesBook: aSalesBook .
	^'Compra exitosa'! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'aa 6/11/2023 13:16:30'!
with: aCart card: aCreditCard time: aDate register: aSalesBook through: aMerchantProcessor

	self assertCartIsNotEmpty: aCart .
	self assertCardIsNotExpired: aCreditCard on: aDate .
	^self new checkout: aCart withCard: aCreditCard time: aDate register: aSalesBook through: aMerchantProcessor! !


!Cashier class methodsFor: 'asserts' stamp: 'aa 6/11/2023 12:45:39'!
assertCardIsNotExpired: aCreditCard on: aDate

	(aCreditCard at: #Date) < aDate ifTrue: [ ^self error: Cashier creditCardIsExpiredErrorMessage ]! !

!Cashier class methodsFor: 'asserts' stamp: 'aa 6/11/2023 12:45:24'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ ^self error: Cashier cartIsEmptyErrorMessage ] .! !


!Cashier class methodsFor: 'error' stamp: 'aa 6/8/2023 20:17:21'!
cartIsEmptyErrorMessage
	
	^'Cart is empty'! !

!Cashier class methodsFor: 'error' stamp: 'aa 6/10/2023 18:05:14'!
creditCardIsExpiredErrorMessage

	^'La tarjeta está vencida'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 14:07:09'!
debitAmount: anAmount from: aCreditCard
	
	| currentCredit |
	(aCreditCard at: #Stolen) ifTrue: [ self error: MerchantProcessor creditCardIsStolenErrorMessage ] .
	((aCreditCard at: #Credit) < anAmount ) ifTrue: [ self error: MerchantProcessor creditCardHasNotEnoughCreditErrorMessage ] .
	currentCredit := aCreditCard at: #Credit .
	aCreditCard at: #Credit put: (currentCredit - anAmount)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:17:46'!
creditCardHasNotEnoughCreditErrorMessage

	^'La tarjeta no tiene credito suficiente'! !

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:47:48'!
creditCardIsStolenErrorMessage

	^'La tarjeta es robada'! !


!classDefinition: #ObjectFactory category: 'TusLibros'!
Object subclass: #ObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/10/2023 20:31:08'!
anotherItemSelledByTheStore

	^'anotherValidBook'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/10/2023 20:31:20'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:25:52'!
creditLessCard

	| creditCard |
	creditCard := Dictionary new .
	creditCard add: #Date -> self validCardDate .
	creditCard add: #Credit -> 5 .
	creditCard add: #Stolen -> false .
	^creditCard! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:14:27'!
defaultCatalog
	
	| catalog |
	catalog := Dictionary new . 
	catalog add: self itemSelledByTheStore -> 5 .
	catalog add: self anotherItemSelledByTheStore -> 7 .
	^catalog! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:42:42'!
expiredCard

	| creditCard |
	creditCard := Dictionary new .
	creditCard add: #Date -> self invalidCardDate .
	creditCard add: #Credit -> 100 .
	creditCard add: #Stolen -> false .
	^creditCard! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/10/2023 20:31:32'!
invalidCardDate

	^DateAndTime year: 2000 month: 1 day: 1 hour: 0 minute: 0 second: 0
! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:56:52'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/10/2023 20:31:40'!
itemSelledByTheStore
	
	^ 'validBook'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:25:42'!
stolenCard

	| creditCard |
	creditCard := Dictionary new .
	creditCard add: #Date -> self validCardDate .
	creditCard add: #Credit -> 1000 .
	creditCard add: #Stolen -> true .
	^creditCard! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/11/2023 13:26:09'!
validCard

	| creditCard |
	creditCard := Dictionary new .
	creditCard add: #Date -> self validCardDate .
	creditCard add: #Credit -> 100 .
	creditCard add: #Stolen -> false .
	^creditCard! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'aa 6/10/2023 20:31:52'!
validCardDate

	^DateAndTime year: 3000 month: 1 day: 1 hour: 0 minute: 0 second: 0
! !
