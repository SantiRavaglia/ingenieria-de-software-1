!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:06:35'!
test01NewCartIsEmpty

	| carrito store result |

	store := Store new .
	carrito := 	Cart createCartFor: store .
	result := Dictionary new.
	self assert: result equals: carrito items! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:59:41'!
test02GivenACartWhenAddingAvailableItemsThenAreAddedSuccesfuly

	| carrito store item result |

	item := Book isbn: 23 .
	store := Store new .
	store addISBN: 23 .
	store addStock: item amount: 2 .
	
	carrito := 	Cart createCartFor: store .
	carrito addToCart: item amount: 1 .
	
	result := Dictionary new .
	result add: item -> 1 .
	
	self assert: result equals: carrito items! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:59:43'!
test03GivenACartWhenAddingUnavailableItemsThenPromptsError

	| carrito store item |

	item := Book isbn: 23 .
	store := Store new .
	store addISBN: 23 .
	carrito := 	Cart createCartFor: store .

	self 
		should: [ carrito addToCart: item amount: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart errorStockIsNotEnough equals: anError messageText. ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:23:39'!
test04GivenACartThenCantAddNegativeAmountOfItems

	| carrito store item |

	item := Book isbn: 23 .
	store := Store new .
	carrito := 	Cart createCartFor: store .

	self 
		should: [ carrito addToCart: item amount: -1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart errorCantAddNoItems equals: anError messageText. ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:58:16'!
test05GivenACartWhenAddingValidItemsThenAreAddedSuccesfuly

	| carrito store item result |

	item := Book isbn: 23 .
	store := Store new .
	store addISBN: 23 .
	store addStock: item amount: 2 .
	
	carrito := 	Cart createCartFor: store .
	carrito addToCart: item amount: 1 .
	
	result := Dictionary new .
	result add: item -> 1 .
	
	self assert: result equals: carrito items! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 13:03:11'!
test06GivenACartWhenAddingInvalidItemsThenPromptsError

	| carrito store item |

	item := Book isbn: 23 .
	store := Store new .
	
	carrito := 	Cart createCartFor: store .
	
	self 
		should: [ carrito addToCart: item amount: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart errorISBNIsNotAvailable equals: anError messageText. ]! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'isbn isbn_CHANGE_ME anIsbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 11:34:28'!
isbn 

	^isbn! !


!Book methodsFor: 'initialization' stamp: 'aa 6/8/2023 11:35:59'!
initialize: AnIsbn 
	isbn := AnIsbn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'aa 6/8/2023 11:35:42'!
isbn: AnIsbn 
	^self new initialize: AnIsbn ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items store'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'aa 6/8/2023 11:54:36'!
initializeCartWith: aStore
	
	items := Dictionary new .
	store := aStore ! !


!Cart methodsFor: 'getters' stamp: 'aa 6/8/2023 11:38:26'!
items

	^items copy! !


!Cart methodsFor: 'adding' stamp: 'aa 6/8/2023 12:56:12'!
addToCart: anItem amount: anAmount 
	
	
	anAmount < 1 ifTrue: [ ^self error: Cart errorCantAddNoItems ] .
	
	(store checkISBNIsAvailable: anItem isbn) 
		ifFalse: [ ^self error: Cart errorISBNIsNotAvailable ] .
	
	(store checkStockIsEnough: anItem amount: anAmount) 
		ifFalse: [ ^self error: Cart errorStockIsNotEnough ] .
		
	items add: anItem->anAmount
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'aa 6/8/2023 11:54:15'!
createCartFor: aStore
	^self new initializeCartWith: aStore! !


!Cart class methodsFor: 'errors' stamp: 'aa 6/8/2023 12:23:26'!
errorCantAddNoItems

	^'Amount has to be greater than 0'! !

!Cart class methodsFor: 'errors' stamp: 'aa 6/8/2023 12:54:07'!
errorISBNIsNotAvailable

	^'Book ISBN is not available'! !

!Cart class methodsFor: 'errors' stamp: 'aa 6/8/2023 12:00:03'!
errorStockIsNotEnough

	^'Not enough stock of that item'! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'stock booksAvailable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'aa 6/8/2023 12:51:11'!
initialize

	booksAvailable := Set new .
	stock := Dictionary new! !


!Store methodsFor: 'manage stock' stamp: 'aa 6/8/2023 12:57:11'!
addStock: anItem amount: anAmount 
	
	(self checkISBNIsAvailable: anItem isbn) ifFalse: [ ^self error: Store errorISBNIsNotAvailable ] .
	
	stock add: anItem -> anAmount! !

!Store methodsFor: 'manage stock' stamp: 'aa 6/8/2023 12:05:56'!
checkStockIsEnough: anItem amount: anAmount

	(stock at: anItem ifAbsent: [ ^false ]) >= anAmount ifFalse: [ ^false ] .
	^true! !


!Store methodsFor: 'manage isbn' stamp: 'aa 6/8/2023 12:51:21'!
addISBN: anISBN

	booksAvailable add: anISBN ! !

!Store methodsFor: 'manage isbn' stamp: 'aa 6/8/2023 12:59:24'!
checkISBNIsAvailable: anISBN

	^booksAvailable includes: anISBN ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'as yet unclassified' stamp: 'aa 6/8/2023 12:57:33'!
errorISBNIsNotAvailable

	^'ISBN is not available'! !
