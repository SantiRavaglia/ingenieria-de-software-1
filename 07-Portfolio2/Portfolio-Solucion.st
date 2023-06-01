!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 6/1/2023 12:45:35'!
test16GivenAPortfolioThenItCanHaveAName

	self assert: 'Portfolio de Nicolas' equals: (Portfolio named: 'Nicolas') name! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 6/1/2023 12:54:26'!
test17GivenAPortfolioWithNoNameThenCantAskForName

	| portfolio |
	
	portfolio := Portfolio new .
	self 
		should: [ portfolio name ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio errorPortfolioDoesNotHaveAName equals: anError messageText. ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 5/25/2023 18:56:02'!
test08GivenTwoAccountsWhenMakingATransferenceThenBalancesChanges

	| account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	
	Deposit register: 50 on: account1. "le doy 50 a la cuenta 1 para que le gire a la cuenta 2"
	
	Transfer register: 50 from: account1 to: account2.
	
	self assert: 0 equals: account1 balance .
	self assert: 50 equals: account2 balance .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 5/29/2023 20:03:49'!
test09GivenTwoAccountsWhenMakingATransferThenBothHaveItRegistered

	| account1 account2 transfer|
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	
	Deposit register: 50 on: account1 .
	
	transfer := Transfer register: 50 from: account1 to: account2 .
	
	self assert: (account1 hasTransferRegistered: transfer out) .
	self assert: (account2 hasTransferRegistered: transfer in) .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 5/29/2023 20:15:49'!
test10GivenTwoAccountsWhenMakingATransferThenCanNavigateFromOneEndToTheTransfer

	| account1 account2 transfer transferIn|
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	
	Deposit register: 50 on: account1 .
	
	transfer := Transfer register: 50 from: account1 to: account2 .
	
	transferIn := account2 transfers at: 1 .
	
	self assert: (transferIn transfer) equals: transfer .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 5/29/2023 20:16:24'!
test11GivenTwoAccountsWhenMakingATransferThenCanNavigateFromOneEndToTheOther

	| account1 account2 transferIn transferOut |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	
	Deposit register: 50 on: account1 .
	
	Transfer register: 50 from: account1 to: account2 .
	
	transferIn := account2 transfers at: 1 .
	transferOut := account1 transfers at: 1 .
	
	self assert: (transferOut transfer) in equals: transferIn .
	self assert: (transferIn transfer) out equals: transferOut .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 6/1/2023 13:13:21'!
test12GivenAnAccountThenItCanHaveAName

	self assert: 'Cuenta de Hernan' equals: (ReceptiveAccount named: 'Hernan') name
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'aa 6/1/2023 12:43:59'!
test13GivenAnAccountWithNoNameThenCantAskForName

	| account |
	
	account := ReceptiveAccount new .
	self 
		should: [ account name ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ReceptiveAccount errorAccountDoesNotHaveAName equals: anError messageText. ]! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:47:13'!
test01GivenAnAccountWithNoTransfersOrTransactionsWhenAskingForAnAccountSummaryThenSummaryReturnsBalance

	| account result |
	
	account := ReceptiveAccount new .
	result := OrderedCollection with: 'Balance = 0' .
	self assert: result equals: (AccountSummary for: account)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:49:30'!
test02GivenAnAccountWithAWithdrawWhenAskingForAnAccountSummaryThenSummaryHasWithdrawAndBalance

	| account result |
	
	account := ReceptiveAccount new .
	Withdraw register: 50 on: account .
	result := OrderedCollection with: 'Extracción por 50' with: 'Balance = -50' .
	self assert: result equals: (AccountSummary for: account)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:49:50'!
test03GivenAnAccountWithADepositWhenAskingForAnAccountSummaryThenSummaryHasDepositAndBalance

	| account result |
	
	account := ReceptiveAccount new .
	Deposit register: 50 on: account .
	result := OrderedCollection with: 'Depósito por 50' with: 'Balance = 50' .
	self assert: result equals: (AccountSummary for: account)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:50:22'!
test04GivenAnAccountWithATransferOutWhenAskingForAnAccountSummaryThenSummaryHasTransferOutAndBalance

	| account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Transfer register: 50 from: account1 to: account2 .	
	result := OrderedCollection with: 'Salida por transferencia de 50' with: 'Balance = -50' .
	self assert: result equals: (AccountSummary for: account1)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:51:46'!
test05GivenAnAccountWithATransferInWhenAskingForAnAccountSummaryThenSummaryHasTransferInAndBalance

	| account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Transfer register: 50 from: account1 to: account2 .	
	result := OrderedCollection with: 'Entrada por transferencia de 50' with: 'Balance = 50' .
	self assert: result equals: (AccountSummary for: account2)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:53:02'!
test06GivenAnAccountWithMultipleTransactionsWhenAskingForAnAccountSummaryThenSummaryHasAllOfThem

	| account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Deposit register: 50 on: account1 .
	Withdraw register: 50 on: account1 .
	Transfer register: 80 from: account1 to: account2 .	
	Transfer register: 20 from: account2 to: account1 .	
	result := OrderedCollection with: 'Depósito por 50' with: 'Extracción por 50' with: 'Salida por transferencia de 80' with: 'Entrada por transferencia de 20' with: 'Balance = -60' .
	self assert: result equals: (AccountSummary for: account1)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:45:06'!
test07GivenAPortfolioWithNoTransfersOrTransactionsWhenAskingForAnAccountSummaryThenSummaryReturnsBalance

	| portfolio result |
	
	portfolio := Portfolio new .
	result := OrderedCollection with: 'Balance = 0' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:45:24'!
test08GivenAPortfolioWithAWithdrawWhenAskingForAnAccountSummaryThenSummaryHasWithdrawAndBalance

	| portfolio account result |
	
	account := ReceptiveAccount new .
	portfolio := Portfolio with: account .
	Withdraw register: 50 on: account .
	result := OrderedCollection with: 'Extracción por 50' with: 'Balance = -50' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:45:33'!
test09GivenAPortfolioWithADepositWhenAskingForAnAccountSummaryThenSummaryHasDepositAndBalance

	| portfolio account result |
	
	account := ReceptiveAccount new .
	portfolio := Portfolio with: account .
	Deposit register: 50 on: account .
	result := OrderedCollection with: 'Depósito por 50' with: 'Balance = 50' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:48:38'!
test10GivenAPortfolioWithATransferOutWhenAskingForAnAccountSummaryThenSummaryHasTransferOutAndBalance

	| portfolio account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account1 .
	Transfer register: 50 from: account1 to: account2 .	
	result := OrderedCollection with: 'Salida por transferencia de 50' with: 'Balance = -50' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:49:03'!
test11GivenAPortfolioWithATransferInWhenAskingForAnAccountSummaryThenSummaryHasTransferInAndBalance

	| portfolio account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account2 .
	Transfer register: 50 from: account1 to: account2 .	
	result := OrderedCollection with: 'Entrada por transferencia de 50' with: 'Balance = 50' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:49:29'!
test12GivenAPortfolioWithMultipleTransactionsWhenAskingForAnAccountSummaryThenSummaryHasAllOfThem

	| portfolio account1 account2 result |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account1 .
	Deposit register: 50 on: account1 .
	Withdraw register: 50 on: account1 .
	Transfer register: 80 from: account1 to: account2 .	
	Transfer register: 20 from: account2 to: account1 .	
	result := OrderedCollection with: 'Depósito por 50' with: 'Extracción por 50' with: 'Salida por transferencia de 80' with: 'Entrada por transferencia de 20' with: 'Balance = -60' .
	self assert: result equals: (AccountSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:51:45'!
test13GivenAnAccountWithNoTransfersWhenAskingForATransferNetThenReturnsZero

	| account |
	
	account := ReceptiveAccount new .
	self assert: (TransferNet for: account) equals: 0! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:52:08'!
test14GivenAnAccountWithATransferOutWhenAskingForAnTransferNetThenReturnsThatTransferOutBalance

	| account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Transfer register: 50 from: account1 to: account2 .	
	self assert: (TransferNet for: account1) equals: -50! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:52:56'!
test15GivenAnAccountWithATransferInWhenAskingForAnTransferNetThenReturnsThatTransferOutBalance

	| account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Transfer register: 50 from: account1 to: account2 .	
	self assert: (TransferNet for: account2) equals: 50! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:53:10'!
test16GivenAnAccountWithMultipleTransfersWhenAskingForAnTransferNetThenReturnsTheSumOfTransferBalances

	| account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	Transfer register: 50 from: account1 to: account2 .	
	Transfer register: 70 from: account2 to: account1 .	
	self assert: (TransferNet for: account1) equals: 20! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:54:04'!
test17GivenAPortfolioWithNoTransfersWhenAskingForATransferNetThenReturnsZero

	| portfolio account |
	
	account := ReceptiveAccount new .
	portfolio := Portfolio with: account .
	self assert: (TransferNet for: portfolio) equals: 0! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:54:33'!
test18GivenAPortfolioWithATransferOutWhenAskingForAnTransferNetThenReturnsThatTransferOutBalance

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account1 .
	Transfer register: 50 from: account1 to: account2 .	
	self assert: (TransferNet for: portfolio) equals: -50! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:54:49'!
test19GivenAPortfolioWithATransferInWhenAskingForAnTransferNetThenReturnsThatTransferOutBalance

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account2 .
	Transfer register: 50 from: account1 to: account2 .	
	self assert: (TransferNet for: portfolio) equals: 50! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:55:07'!
test20GivenAPortfolioWithMultipleTransfersWhenAskingForAnTransferNetThenReturnsTheSumOfTransferBalances

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new .
	account2 := ReceptiveAccount new .
	portfolio := Portfolio with: account1 .
	Transfer register: 50 from: account1 to: account2 .	
	Transfer register: 70 from: account2 to: account1 .	
	self assert: (TransferNet for: portfolio) equals: 20! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:50:58'!
test21GivenAPortfolioWithNoAssetsWhenAskingForAPortfolioResumeeThenReturnsOnlyThePortfolioName

	| portfolio result |
	
	portfolio := Portfolio named: 'Maximiliano' .
	result := OrderedCollection with: 'Portfolio de Maximiliano' .
	self assert: result equals: (PortfolioResumee for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:51:04'!
test22GivenAPortfolioWithAssetsWhenAskingForAPortfolioResumeeThenIndentsCorrectly

	| portfolio result |
	
	portfolio := Portfolio named: 'Maximiliano' with: (ReceptiveAccount named: 'Maximiliano') with: (Portfolio named: 'Hijos') .
	result := OrderedCollection with: 'Portfolio de Maximiliano' with: '    Cuenta de Maximiliano' with: '    Portfolio de Hijos' .
	self assert: result equals: (PortfolioResumee for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:51:09'!
test23GivenAPortfolioWithAssetsInMultipleLevelsWhenAskingForAPortfolioResumeeThenIndentsCorrectly

	| portfolioMaxi portfolioHijos accountJulian accountCoca accountMaxi result |
	
	accountMaxi := ReceptiveAccount named: 'Maximiliano' .
	accountJulian := ReceptiveAccount named: 'Julian' .
	accountCoca := ReceptiveAccount named: 'Coca Sarli' .
	portfolioHijos := Portfolio named: 'Hijos' with: accountJulian with: accountCoca .
	portfolioMaxi := Portfolio named: 'Maximiliano' with: accountMaxi with: portfolioHijos .
	
	result := OrderedCollection with: 'Portfolio de Maximiliano' with: '    Cuenta de Maximiliano' with: '    Portfolio de Hijos' with: '        Cuenta de Julian' with: '        Cuenta de Coca Sarli' .
	self assert: result equals: (PortfolioResumee for: portfolioMaxi)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:59:13'!
test24GivenAPortfolioWithNoAssetsWhenAskingForAPortfolioSummaryThenReturnsOnlyThePortfolioNameAndBalance

	| portfolio result |
	
	portfolio := Portfolio named: 'Maximiliano' .
	result := OrderedCollection with: 'Portfolio de Maximiliano' with: 'Balance = 0' .
	self assert: result equals: (PortfolioSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 15:15:12'!
test25GivenAPortfolioWithAssetsButNoTransactionsWhenAskingForAPortfolioSummaryThenReturnsThePortfolioNameTheAccountNameAndBothBalances

	| portfolio account result |
	
	account := ReceptiveAccount named: 'Francisco' .
	portfolio := Portfolio named: 'More' with: account .
	result := OrderedCollection with: 'Portfolio de More' with: '    Cuenta de Francisco' with: '        Balance = 0' with: 'Balance = 0' .
	self assert: result equals: (PortfolioSummary for: portfolio)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 15:24:34'!
test26GivenAPortfolioWithAssetsAndTransactionsWhenAskingForAPortfolioSummaryThenReturnsDataWithCorrectIndentation

	| accountMaxi accountJulian accountCoca portfolioHijos portfolioMaxi accountFlor portfolioTobias result |
	
	accountMaxi := ReceptiveAccount named: 'Maximiliano' .
	accountJulian := ReceptiveAccount named: 'Julian' .
	accountCoca := ReceptiveAccount named: 'Coca Sarli' .
	accountFlor := ReceptiveAccount named: 'Flor' .
	
	portfolioTobias := Portfolio named: 'Tobias' with: accountFlor .
	portfolioHijos := Portfolio named: 'Hijos' with: accountJulian with: accountCoca .
	portfolioHijos add: portfolioTobias .
	portfolioMaxi := Portfolio named: 'Maximiliano' with: accountMaxi with: portfolioHijos .
	
	Deposit register: 1000 on: accountMaxi .
	Withdraw register: 250 on: accountMaxi .
	Withdraw register: 50 on: accountJulian .
	Withdraw register: 200 on: accountCoca .
	Withdraw register: 200 on: accountCoca .
	Withdraw register: 200 on: accountFlor .
	
	result := OrderedCollection new .
	result add: 'Portfolio de Maximiliano' .
	result add: '    Cuenta de Maximiliano' .
	result add: '        Depósito por 1000' .
	result add: '        Extracción por 250' .
	result add: '        Balance = 750' .
	result add: '    Portfolio de Hijos' .
	result add: '        Cuenta de Julian' .
	result add: '            Extracción por 50' .
	result add: '            Balance = -50' .
	result add: '        Cuenta de Coca Sarli' .
	result add: '            Extracción por 200' .
	result add: '            Extracción por 200' .
	result add: '            Balance = -400' .
	result add: '        Portfolio de Tobias' .
	result add: '            Cuenta de Flor' .
	result add: '                Extracción por 200' .
	result add: '                Balance = -200' .
	result add: 'Balance = 100' .
	self assert: result equals: (PortfolioSummary for: portfolioMaxi)
	
! !


!classDefinition: #AbstractReport category: 'Portfolio-Solucion'!
Object subclass: #AbstractReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AbstractReport methodsFor: 'as yet unclassified' stamp: 'aa 5/30/2023 20:05:39'!
operationOnAsset: anElement

	self subclassResponsibility ! !

!AbstractReport methodsFor: 'as yet unclassified' stamp: 'aa 5/30/2023 20:03:32'!
startOperationOnAsset: anElement

	^anElement reportOperation: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AbstractReport class' category: 'Portfolio-Solucion'!
AbstractReport class
	instanceVariableNames: ''!

!AbstractReport class methodsFor: 'as yet unclassified' stamp: 'aa 5/30/2023 20:01:55'!
for: anElement

	^self new startOperationOnAsset: anElement ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AbstractReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:43:01'!
addDepositToReport: aDeposit

	report add: 'Depósito por ', aDeposit value printString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:45:01'!
addTransferINToReport: aTransferIN

	report add: 'Entrada por transferencia de ', aTransferIN transfer value printString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:45:17'!
addTransferOUTToReport: aTransferOUT

	report add: 'Salida por transferencia de ', aTransferOUT transfer value printString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:45:32'!
addWithdrawToReport: aWithdraw

	report add: 'Extracción por ', aWithdraw value printString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:02:45'!
operationOnAsset: anAccount

	report := OrderedCollection new .
	anAccount addTransactionsToReport: self .
	anAccount addTransfersToReport: self .
	report add: 'Balance = ', anAccount balance printString .
	^report! !


!classDefinition: #PortfolioResumee category: 'Portfolio-Solucion'!
AbstractReport subclass: #PortfolioResumee
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioResumee methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 13:40:02'!
addAccountToReport: anAccount withIndentation: anIndentation

	report add: anIndentation, anAccount name! !

!PortfolioResumee methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 13:39:57'!
addPortfolioToReport: aPortfolio withIndentation: anIndentation

	report add: anIndentation, aPortfolio name! !

!PortfolioResumee methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:02:31'!
operationOnAsset: aPortfolio

	report := OrderedCollection new .
	aPortfolio addAssetToReport: self withIndentation: ''.
	^report ! !


!classDefinition: #PortfolioSummary category: 'Portfolio-Solucion'!
AbstractReport subclass: #PortfolioSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 15:09:44'!
addAccountToReport: anAccount withIndentation: anIndentation
	
	| summaryForAccount |
	
	report add: anIndentation, anAccount name .
	summaryForAccount := AccountSummary for: anAccount .
	summaryForAccount := summaryForAccount collect: [ :each | anIndentation, '    ', each ] .
	report addAll: summaryForAccount .! !

!PortfolioSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 13:52:11'!
addPortfolioToReport: aPortfolio withIndentation: anIndentation

	report add: anIndentation, aPortfolio name! !

!PortfolioSummary methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 15:26:25'!
operationOnAsset: aPortfolio

	report := OrderedCollection new .
	aPortfolio addAssetToReport: self withIndentation: ''.
	report add: 'Balance = ', aPortfolio balance printString .
	^report 
	
	"cuando se nos ocurrio como hacer para que cada portfolio tenga su balance al final ya nos quedaba poco tiempo y pocas neuronas asi que quedó así"! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AbstractReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:54:42'!
addTransferINToReport: aTransferIN

	report := report + aTransferIN transfer value! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:55:21'!
addTransferOUTToReport: aTransferOUT

	report := report - aTransferOUT transfer value! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:03:15'!
operationOnAsset: anAccount

	report := 0 .
	anAccount addTransfersToReport: self .
	^report! !


!classDefinition: #AbstractTransactions category: 'Portfolio-Solucion'!
Object subclass: #AbstractTransactions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AbstractTransactions methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 14:25:12'!
addToReport: aMethodObject

	self subclassResponsibility ! !


!AbstractTransactions methodsFor: 'balance' stamp: 'aa 6/1/2023 14:25:37'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
AbstractTransactions subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!AccountTransaction methodsFor: 'value' stamp: 'aa 5/27/2023 17:32:55'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'as yet unclassified' stamp: 'aa 5/27/2023 17:27:11'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'aa 5/27/2023 17:44:16'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'balance' stamp: 'aa 5/27/2023 17:24:55'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:44:29'!
addToReport: aMethodObject

	aMethodObject addDepositToReport: self! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'aa 5/29/2023 20:41:39'!
dataForSummary

	^'Depósito por ', (value printString) , '
	'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'aa 5/27/2023 17:44:16'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'balance' stamp: 'aa 5/27/2023 17:25:00'!
affectBalance: aBalance

	^aBalance - value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 11:44:04'!
addToReport: aMethodObject

	aMethodObject addWithdrawToReport: self! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'aa 5/29/2023 20:41:42'!
dataForSummary

	^'Extracción por ', (value printString) , '
	'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransfer category: 'Portfolio-Solucion'!
AbstractTransactions subclass: #AccountTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!AccountTransfer methodsFor: 'transfer' stamp: 'aa 5/27/2023 17:33:36'!
transfer

	^transfer! !


!AccountTransfer methodsFor: 'initialization' stamp: 'aa 5/27/2023 17:32:14'!
initializeFor: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransfer class' category: 'Portfolio-Solucion'!
AccountTransfer class
	instanceVariableNames: ''!

!AccountTransfer class methodsFor: 'as yet unclassified' stamp: 'aa 5/27/2023 17:55:44'!
register: aTransfer on: account

	| transfer |
	
	transfer := self new initializeFor: aTransfer.
	account registerTransfer: transfer.
		
	^ transfer! !


!classDefinition: #TransferIN category: 'Portfolio-Solucion'!
AccountTransfer subclass: #TransferIN
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferIN methodsFor: 'balance' stamp: 'aa 6/1/2023 11:43:47'!
addToReport: aMethodObject

	aMethodObject addTransferINToReport: self! !

!TransferIN methodsFor: 'balance' stamp: 'aa 5/27/2023 17:35:00'!
affectBalance: aBalance

	^aBalance + transfer value! !

!TransferIN methodsFor: 'balance' stamp: 'aa 5/30/2023 18:44:25'!
dataForSummary

	^'Entrada por transferencia de ', (transfer value printString) , '
	'! !


!classDefinition: #TransferOUT category: 'Portfolio-Solucion'!
AccountTransfer subclass: #TransferOUT
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferOUT methodsFor: 'balance' stamp: 'aa 6/1/2023 11:43:52'!
addToReport: aMethodObject

	aMethodObject addTransferOUTToReport: self! !

!TransferOUT methodsFor: 'balance' stamp: 'aa 5/27/2023 17:35:10'!
affectBalance: aBalance

	^aBalance - transfer value ! !

!TransferOUT methodsFor: 'balance' stamp: 'aa 5/30/2023 18:44:32'!
dataForSummary

	^'Salida por transferencia de ', (transfer value printString) , '
	'! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'aa 6/1/2023 12:53:19'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := '' .! !

!Portfolio methodsFor: 'initialization' stamp: 'aa 6/1/2023 12:48:09'!
named: aName 
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'Portfolio de ', aName .! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'aa 6/1/2023 14:30:04'!
addTransfersTo: aCollectionOfTransfers

	accounts do: [ :anAccount | anAccount addTransfersTo: aCollectionOfTransfers ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

!Portfolio methodsFor: 'transactions' stamp: 'aa 6/1/2023 14:39:28'!
transfers
	
	| transfers |
	
	transfers := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransfersTo: transfers ].
	
	^transfers ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'reports' stamp: 'aa 6/1/2023 13:39:18'!
addAssetToReport: aMethodObject withIndentation: anIndentation

	aMethodObject addPortfolioToReport: self withIndentation: anIndentation .
	^accounts do: [ :asset | asset addAssetToReport: aMethodObject withIndentation: anIndentation, '    ' ] ! !

!Portfolio methodsFor: 'reports' stamp: 'aa 6/1/2023 14:31:21'!
addTransactionsToReport: aMethodObject

	
	^self transactions do: [ :transaction | transaction addToReport: aMethodObject ] .! !

!Portfolio methodsFor: 'reports' stamp: 'aa 6/1/2023 14:31:06'!
addTransfersToReport: aMethodObject

	^self transfers do: [ :transfer | transfer addToReport: aMethodObject ] ! !

!Portfolio methodsFor: 'reports' stamp: 'aa 6/1/2023 13:07:57'!
reportOperation: aMethodObject

	^aMethodObject operationOnAsset: self! !


!Portfolio methodsFor: 'name' stamp: 'aa 6/1/2023 12:55:11'!
name 

	(name = '') ifTrue: [ ^self error: Portfolio errorPortfolioDoesNotHaveAName ] ifFalse: [  ^name ] .! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:52:53'!
errorPortfolioDoesNotHaveAName

	^'Este portfolio no tiene nombre'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:46:37'!
named: aName 
	
	^Portfolio new named: aName .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 13:42:45'!
named: aName with: anAccount 
	
	| portfolio |
	portfolio := Portfolio new named: aName .
	portfolio add: anAccount .
	^portfolio! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:51:15'!
named: aName with: anAccount with: anotherAccount
	
	| portfolio |
	portfolio := Portfolio new named: aName .
	portfolio add: anAccount .
	portfolio add: anotherAccount .
	^portfolio! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions transfers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'aa 6/1/2023 12:41:02'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	transfers := OrderedCollection new .
	name := '' .! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'aa 6/1/2023 13:13:10'!
initializeWithName: aName 

	name := 'Cuenta de ', aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 6/1/2023 14:29:32'!
addTransfersTo: aCollectionOfTransfers

	aCollectionOfTransfers addAll: transfers ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 5/27/2023 17:30:04'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 5/27/2023 17:29:55'!
registerTransfer: aTransfer

	transfers add: aTransfer 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 5/27/2023 17:59:12'!
transfers 

	^ transfers copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'aa 5/30/2023 19:23:44'!
balance

	| balanceSum |

	balanceSum := transactions 
					inject: 0
					into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ] .					
	^transfers 
		inject: balanceSum 
		into: [ :currentBalance :transfer | transfer affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'aa 5/27/2023 18:39:08'!
hasTransferRegistered: aTransfer 
	
	^transfers includes: aTransfer .! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'name' stamp: 'aa 6/1/2023 12:43:51'!
name

	(name = '') ifTrue: [ ^self error: ReceptiveAccount errorAccountDoesNotHaveAName ] ifFalse: [  ^name ] .! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'aa 6/1/2023 13:34:07'!
addAssetToReport: aMethodObject withIndentation: anIndentation

	^aMethodObject addAccountToReport: self withIndentation: anIndentation ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'aa 6/1/2023 12:01:12'!
addTransactionsToReport: aMethodObject

	
	^transactions do: [ :transaction | transaction addToReport: aMethodObject ] .! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'aa 6/1/2023 12:01:23'!
addTransfersToReport: aMethodObject

	
	^transfers do: [ :transfer | transfer addToReport: aMethodObject ] ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'aa 5/30/2023 19:55:03'!
reportOperation: aMethodObject

	^aMethodObject operationOnAsset: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:40:19'!
errorAccountDoesNotHaveAName

	^'Esta cuenta no tiene nombre'! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'aa 6/1/2023 12:36:45'!
named: aName 
	
	^ReceptiveAccount new initializeWithName: aName! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value transferIN transferOUT'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'transaction' stamp: 'aa 5/27/2023 17:36:43'!
in

	^transferIN! !

!Transfer methodsFor: 'transaction' stamp: 'aa 5/27/2023 18:38:02'!
initializeWith: aValue from: anOriginAccount to: aDestinationAccount

	value := aValue .
	transferIN := TransferIN register: self on: aDestinationAccount .
	transferOUT := TransferOUT register: self on: anOriginAccount .! !

!Transfer methodsFor: 'transaction' stamp: 'aa 5/27/2023 17:36:31'!
out

	^transferOUT! !

!Transfer methodsFor: 'transaction' stamp: 'aa 5/27/2023 17:46:13'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'aa 5/27/2023 18:36:47'!
register: aValue from: anOriginAccount to: aDestinationAccount 
	
	^(Transfer new) initializeWith: aValue from: anOriginAccount to: aDestinationAccount .
	! !
