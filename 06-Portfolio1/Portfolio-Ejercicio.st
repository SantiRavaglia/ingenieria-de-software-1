!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:22:36'!
test01GivenANewPortfolioThenBalanceIsZero

	self assert: 0 equals: (Portfolio new) balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:22:26'!
test02GivenANewPortfolioWhenAddingAnAccountWithoutTransactionsThenBalanceIsZero

	| account portfolio |
	account := ReceptiveAccount new .
	portfolio := Portfolio new .
	portfolio addAsset: account .
	
	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:24:11'!
test03GivenAPortfolioWithAnAccountWhenRegisteringATransactionThenBalanceIsThatTransactionValue

	| account portfolio |
	account := ReceptiveAccount new .
	Deposit register: 50 on: account .
	portfolio := Portfolio new .
	portfolio addAsset: account .

	self assert: 50 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 13:58:19'!
test04GivenAPortfolioWithAPortfolioWithAnAccountWhenRegisteringATransactionThenBalanceIsThatTransactionValue
	| account portfolio1 portfolio2 |
	
	account := ReceptiveAccount new .
	Deposit register: 50 on: account .
	portfolio1 := Portfolio new .
	portfolio1 addAsset: account .
	portfolio2 := Portfolio new .
	portfolio2 addAsset: portfolio1 .

	self assert: 50 equals: portfolio2 balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:29:02'!
test05GivenAPortfolioWithManyAccountsThenBalanceIsTheSumOfAllBalances

	| account1 account2 account3 portfolio |
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	account3 := ReceptiveAccount new .
	
	Deposit register: 100 on: account1 .
	Deposit register: 120 on: account2 .
	Withdraw register: 70 on: account2 .
	Withdraw register: 135 on: account3 .
	
	portfolio := Portfolio new .
	portfolio addAsset: account1 .
	portfolio addAsset: account2 .
	portfolio addAsset: account3 .

	self assert: 15 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 14:42:04'!
test06GivenAPortfolioWithManyPAssetsThenBalanceIsTheSumOfAllBalances

	| account1 account2 account3 account4 portfolio1 portfolio2 portfolio3 portfolio4 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	account3 := ReceptiveAccount new .
	account4 := ReceptiveAccount new .
	
	Deposit register: 100 on: account1 .
	Deposit register: 120 on: account2 .
	Withdraw register: 70 on: account2 .
	Withdraw register: 135 on: account3 .
	Deposit register: 15 on: account4 .
	Deposit register: 80 on: account4 .
	
	portfolio1 := Portfolio new .
	portfolio1 addAsset: account1 .
	portfolio1 addAsset: account2 .
	portfolio2 := Portfolio new .
	portfolio2 addAsset: account3 .
	portfolio2 addAsset: portfolio1 .
	portfolio3 := Portfolio new .
	portfolio3 addAsset: account4 .
	portfolio3 addAsset: portfolio2 .
	portfolio4 := Portfolio new . 
	portfolio4 addAsset: portfolio3 .
	
	self assert: 110 equals: portfolio4 balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 14:41:51'!
test07GivenAPortfolioWithMultipleTransactionsThenBalanceCanBeNegative

	| account portfolio |
	account := ReceptiveAccount new .
	Deposit register: 50 on: account .
	Deposit register: 25 on: account .
	portfolio := Portfolio new .
	portfolio addAsset: account .

	self assert: 75 equals: portfolio balance .
	
	Withdraw register: 100 on: account .
	
	self assert: -25 equals: portfolio balance .
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:33:45'!
test08GivenANewPortfolioThenItHasNoRegisteredTransactions

	| transaction portfolio |
	transaction := Deposit for: 50 .
	portfolio := Portfolio new .

	self deny: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:44:34'!
test09GivenAPortfolioWithAnAccountWithATransactionThenThePortfolioHasItRegistered

	| account transaction portfolio |
	
	transaction := Deposit for:50 .
	account := ReceptiveAccount new .
	account register: transaction .
	portfolio := Portfolio new .
	portfolio addAsset: account .

	self assert: (portfolio hasRegistered: transaction )! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 14:41:04'!
test10GivenAPortfolioWithAPortfolioWithAnAccountWithATransactionThenThePortfolioHasItRegistered
	
	| account transaction portfolio1 portfolio2 |
	
	account := ReceptiveAccount new .
	transaction := Deposit for:50 .
	account register: transaction .
	portfolio1 := Portfolio new .
	portfolio1 addAsset: account .
	portfolio2 := Portfolio new .
	portfolio2 addAsset: portfolio1 .

	self assert: (portfolio2 hasRegistered: transaction )! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 14:40:07'!
test11GivenAPortfolioWithMultipleAssetsWithTransactionsThenThePortfolioHasThoseTransactionsRegistered

	| account1 account2 account3 account4 portfolio1 portfolio2 portfolio3 portfolio4 transaction1 transaction2 |

	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	account3 := ReceptiveAccount new .
	account4 := ReceptiveAccount new .
	
	transaction1 := Deposit for:50 .
	transaction2 := Withdraw for: 80 .
	
	account2 register: transaction1 .
	account1 register: transaction2 .
	
	portfolio1 := Portfolio new .
	portfolio1 addAsset: account1 .
	portfolio1 addAsset: account2 .
	portfolio2 := Portfolio new .
	portfolio2 addAsset: account3 .
	portfolio2 addAsset: portfolio1 .
	portfolio3 := Portfolio new .
	portfolio3 addAsset: account4 .
	portfolio4 := Portfolio new . 
	portfolio4 addAsset: portfolio2 .
	portfolio4 addAsset: portfolio3 .
	
	self assert: (portfolio4 hasRegistered: transaction1 ) .
	self deny: (portfolio3 hasRegistered: transaction1 )! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:52:40'!
test12GivenANewPortfolioThenItHasNoTransactions

	| portfolio |
	portfolio := Portfolio new .

	self assert: Bag new equals: (portfolio transactions)! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/20/2023 20:53:05'!
test13GivenAPortfolioWithOneAccountThenItHasThatAccountTransactions

	| account transaction portfolio |
	account := ReceptiveAccount new .
	transaction := Deposit for:50 .
	account register: transaction .
	portfolio := Portfolio new .
	portfolio addAsset: account .

	self assert: (account transactions) equals: (portfolio transactions)! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 14:39:41'!
test14GivenAPortfolioWithManyAssetsThenThePortfolioHasItsAssetsTransactionsRegistered

	| account1 account2 portfolio1 portfolio2 transaction1 transaction2 |
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	transaction1 := Deposit for:50 .
	transaction2 := Deposit for: 100 .
	account1 register: transaction1 .
	account2 register: transaction2 .
	
	portfolio1 := Portfolio new .
	portfolio1 addAsset: account1 .
	portfolio2 := Portfolio new .
	portfolio2 addAsset: account2 .
	portfolio2 addAsset: portfolio1 .

	self assert: (Bag with: transaction1 with: transaction2) equals: (portfolio2 transactions )
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 16:03:40'!
test15GivenAPortfolioWithAnAssetWhenAddingTheSameAssetThenPromptAnError

	| account portfolio1 portfolio2 |
	account := ReceptiveAccount new .
	portfolio1 := Portfolio new .
	portfolio2 := Portfolio new .
	portfolio1 addAsset: account .
	portfolio1 addAsset: portfolio2 .

	self
		should: [ portfolio1 addAsset: account]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio intersectionBetweenPortfoliosIsNotEmpty ] .
		
		
	self
		should: [ portfolio1 addAsset: portfolio2]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio intersectionBetweenPortfoliosIsNotEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 16:09:59'!
test16GivenAPortfolioWhenAddingItsParentPortfolioThenPromptAnError

	| portfolio1 portfolio2 |
	portfolio1 := Portfolio new .
	portfolio2 := Portfolio new .
	portfolio1 addAsset: portfolio2 .
		
	self
		should: [ portfolio2 addAsset: portfolio1]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio intersectionBetweenPortfoliosIsNotEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 5/21/2023 16:14:32'!
test17GivenAPortfolioWhenAddingAnAssetContainedInAHigherLevelPortfolioThenPromptAnError

	| account portfolio1 portfolio2 portfolio3 portfolio4 |
	portfolio1 := Portfolio new .
	portfolio2 := Portfolio new .
	portfolio3 := Portfolio new .
	portfolio4 := Portfolio new .
	account := ReceptiveAccount new .
	portfolio1 addAsset: portfolio2 .
	portfolio2 addAsset: portfolio3 .
	portfolio1 addAsset: portfolio4 .
	portfolio1 addAsset: account .
		
	self
		should: [ portfolio3 addAsset: portfolio4 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio intersectionBetweenPortfoliosIsNotEmpty ] .
		
	self
		should: [ portfolio3 addAsset: account ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio intersectionBetweenPortfoliosIsNotEmpty ] .! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'aa 5/15/2023 20:26:06'!
howToAffectBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'aa 5/15/2023 20:26:01'!
howToAffectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'aa 5/15/2023 19:43:16'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: 'transactions parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/22/2023 14:10:40'!
allAssets 

	self subclassResponsibility ! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/21/2023 01:16:51'!
assertIntersectionIsEmpty: anAssetToAdd	

	self subclassResponsibility ! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 20:13:18'!
balance
	
	self subclassResponsibility ! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/21/2023 01:17:01'!
checkIntersection: aPortfolio
	
	self subclassResponsibility ! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 23:09:45'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 22:06:07'!
initialize

	self subclassResponsibility ! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 23:11:25'!
linkToParent: parentNode

	parents add: parentNode! !

!Asset methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 20:13:49'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Asset class' category: 'Portfolio-Ejercicio'!
Asset class
	instanceVariableNames: ''!

!Asset class methodsFor: 'as yet unclassified' stamp: 'aa 5/20/2023 20:16:19'!
createAccountWith: aTransactionsCollection! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initalization' stamp: 'aa 5/22/2023 14:11:27'!
initialize 

	transactions := Bag new .
	parents := Set new .
	assets := OrderedCollection new.! !


!Portfolio methodsFor: 'getters' stamp: 'aa 5/21/2023 14:13:19'!
allAssets: assetsCollection

	assets do: [ :asset | 
		assetsCollection add: asset .
		asset allAssets: assetsCollection 
	]! !

!Portfolio methodsFor: 'getters' stamp: 'aa 5/21/2023 01:40:48'!
assets

	^assets ! !

!Portfolio methodsFor: 'getters' stamp: 'aa 5/20/2023 20:11:36'!
balance
	
	^assets sum: [:each | each balance
		] ifEmpty: [0]! !

!Portfolio methodsFor: 'getters' stamp: 'aa 5/21/2023 01:38:17'!
combinedAccountsTransactions: assetsCollection 
	
	| combinedTransactions |
	
	combinedTransactions := Bag new .
	assetsCollection do: [:asset | combinedTransactions addAll: (asset transactions)] .
	^combinedTransactions 
	! !

!Portfolio methodsFor: 'getters' stamp: 'aa 5/20/2023 23:52:50'!
getRootPortfolios: rootPortfolios

	parents size = 0
	ifTrue: [ rootPortfolios add: self ] 
	ifFalse:  [ parents do: [ :asset | 
		asset getRootPortfolios: rootPortfolios 
		] 
	]! !

!Portfolio methodsFor: 'getters' stamp: 'aa 5/21/2023 01:38:17'!
transactions
	^self combinedAccountsTransactions: assets ! !


!Portfolio methodsFor: 'adding' stamp: 'aa 5/22/2023 14:17:27'!
addAsset: anAsset

	self assertIntersectionIsEmpty: anAsset .
	anAsset linkToParent: self .
	assets add: anAsset! !


!Portfolio methodsFor: 'asserts' stamp: 'aa 5/21/2023 01:13:49'!
assertIntersectionIsEmpty: anAssetToAdd	
	
	anAssetToAdd checkIntersection: self
	
! !

!Portfolio methodsFor: 'asserts' stamp: 'aa 5/22/2023 10:10:36'!
checkIntersection: aPortfolio

	| rootPortfolios currentIntersection allAssetsForCurrentAsset |

	rootPortfolios := OrderedCollection new .
	aPortfolio getRootPortfolios: rootPortfolios . 
		
	rootPortfolios do: [ :asset |
		allAssetsForCurrentAsset := OrderedCollection new .
		asset allAssets: allAssetsForCurrentAsset .
		currentIntersection := allAssetsForCurrentAsset intersection: (self assets) .
		currentIntersection size = 0 ifFalse: [^self error: Portfolio intersectionBetweenPortfoliosIsNotEmpty ] . "check if self assets are in aPortfolio"
		(allAssetsForCurrentAsset includes: self) ifTrue: [^self error: Portfolio intersectionBetweenPortfoliosIsNotEmpty ] . "check if self is in aPortfolio"
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'aa 5/21/2023 00:15:52'!
intersectionBetweenPortfoliosIsNotEmpty

	^'La intersección entre portfolios no es vacia!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'aa 5/21/2023 01:31:56'!
initialize

	transactions := OrderedCollection new .
	parents := Set new .! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 5/20/2023 19:51:12'!
transactions 

	^ transactions asBag! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'aa 5/22/2023 14:15:07'!
balance

	^transactions inject: 0 into: [ :balanceSum :aTransacion | aTransacion howToAffectBalance: balanceSum ] .
	! !


!ReceptiveAccount methodsFor: 'asserts' stamp: 'aa 5/21/2023 00:34:48'!
assertIntersectionIsEmpty: aPortfolio! !

!ReceptiveAccount methodsFor: 'asserts' stamp: 'aa 5/21/2023 02:16:40'!
checkIntersection: aPortfolio

	| rootPortfolios allAssetsForCurrentAsset |

	rootPortfolios := OrderedCollection new .
	aPortfolio getRootPortfolios: rootPortfolios . 
		
	rootPortfolios do: [ :asset |
		allAssetsForCurrentAsset := OrderedCollection new .
		asset allAssets: allAssetsForCurrentAsset .
		(allAssetsForCurrentAsset includes: self) ifTrue: [^self error: Portfolio intersectionBetweenPortfoliosIsNotEmpty] 
	]
	! !


!ReceptiveAccount methodsFor: 'getters' stamp: 'aa 5/21/2023 01:48:41'!
allAssets: assetsCollection

	assetsCollection add: self! !

