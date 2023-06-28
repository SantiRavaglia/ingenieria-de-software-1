!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 20:54:27'!
test01ImportCustomerDataCorrectly

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 21:59:46'!
test02EmptyFieldsRaisesError

	self should: [ CustomerImporter valueFrom: self invalidImportDataWithMissingFields into: session. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CustomerImporter invalidRecordSyntaxErrorMessage .
			self assertPepeSanchezWasImportedCorrecty ]! !

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 21:35:45'!
test03TooManyFieldsRaisesError

	self should: [ CustomerImporter valueFrom: self invalidImportDataWithTooManyFields into: session. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: [CustomerImporter invalidRecordSyntaxErrorMessage ]! !

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 21:35:16'!
test04ImportingEmptyStringRaisesError

	self should: [ CustomerImporter valueFrom: self invalidImportDataEmptyStream into: session. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: [CustomerImporter importDataIsEmptyErrorMessage ]! !

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 21:16:16'!
test05AddressHasNoCustomerToBeAddedTo

	self should: [ CustomerImporter valueFrom: self invalidImportDataEmptyStream into: session. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: [CustomerImporter importDataIsEmptyErrorMessage ]! !

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 21:58:03'!
test06RecordIsNotACustomerNorAnAddress
		
	self should: [ CustomerImporter valueFrom: self invalidImportDataWithRecordNotCustomerNorAddress into: session. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CustomerImporter recordIsNotCustomerNorAddressErrorMessage .
			self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'. ]! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'aa 6/26/2023 21:16:44'!
invalidImportDataAddressOnFirstRecord

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444,21
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'aa 6/26/2023 21:08:08'!
invalidImportDataEmptyStream

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'aa 6/26/2023 21:58:56'!
invalidImportDataWithMissingFields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'aa 6/26/2023 21:38:39'!
invalidImportDataWithRecordNotCustomerNorAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
J,Jefe de Gabinete,11287,21/03/2018
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'aa 6/26/2023 21:00:48'!
invalidImportDataWithTooManyFields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,21
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record newAddress currentCustomerData currentAddressData'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'database-load' stamp: 'aa 6/26/2023 21:43:25'!
addAddressToDatabase

	self assertAddressIsBeingAddedToExistingCustomer .
	self assertAddressHasCorrectAmountOfFields: 6 .
	
	currentAddressData := record .
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: currentAddressData second.
	newAddress streetNumber: currentAddressData third asNumber .
	newAddress town: currentAddressData fourth.
	newAddress zipCode: currentAddressData fifth asNumber .
	newAddress province: currentAddressData sixth! !

!CustomerImporter methodsFor: 'database-load' stamp: 'aa 6/26/2023 21:43:23'!
addCustomerToDatabase

	self assertAddressHasCorrectAmountOfFields: 5 .
	
	currentCustomerData := record .
	newCustomer := Customer new.
	newCustomer firstName: currentCustomerData second.
	newCustomer lastName: currentCustomerData third.
	newCustomer identificationType: currentCustomerData fourth.
	newCustomer identificationNumber: currentCustomerData fifth.
	session persist: newCustomer! !


!CustomerImporter methodsFor: 'stream-handling' stamp: 'aa 6/26/2023 20:48:04'!
findRecord

	record := line findTokens: $,! !

!CustomerImporter methodsFor: 'stream-handling' stamp: 'aa 6/26/2023 20:48:01'!
readNextLine

	line := readStream nextLine! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'aa 6/26/2023 21:33:59'!
processRecordData

	(self assertRecordIsCustomer) ifTrue: [  
		^self addCustomerToDatabase ].
	(self assertRecordIsAddress) ifTrue: [  
		^self addAddressToDatabase ] .
	self error: CustomerImporter recordIsNotCustomerNorAddressErrorMessage! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'aa 6/26/2023 21:43:57'!
value

	self assertStreamIsNotEmpty .
	self readNextLine .
	[ line notNil ] whileTrue: [  
		self findRecord.
		self processRecordData.
		self readNextLine. ].

	! !


!CustomerImporter methodsFor: 'asserts' stamp: 'aa 6/26/2023 21:42:45'!
assertAddressHasCorrectAmountOfFields: aNumberOfFields

	^ record size ~= aNumberOfFields ifTrue: [self error: CustomerImporter invalidRecordSyntaxErrorMessage]! !

!CustomerImporter methodsFor: 'asserts' stamp: 'aa 6/26/2023 21:42:07'!
assertAddressIsBeingAddedToExistingCustomer

	^ newCustomer isNil ifTrue: [self error: CustomerImporter invalidImportDataAddressHasNoCustomerToBeAddedTo]! !

!CustomerImporter methodsFor: 'asserts' stamp: 'aa 6/26/2023 20:43:31'!
assertRecordIsAddress

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'asserts' stamp: 'aa 6/26/2023 20:42:55'!
assertRecordIsCustomer

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'asserts' stamp: 'aa 6/26/2023 21:43:57'!
assertStreamIsNotEmpty

	^ readStream isEmpty ifTrue: [self error: CustomerImporter importDataIsEmptyErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'error-messages' stamp: 'aa 6/26/2023 21:12:49'!
importDataIsEmptyErrorMessage

	^'Data to import is empty'! !

!CustomerImporter class methodsFor: 'error-messages' stamp: 'aa 6/26/2023 21:22:19'!
invalidImportDataAddressHasNoCustomerToBeAddedTo

	^'An address has no customer to be added to'! !

!CustomerImporter class methodsFor: 'error-messages' stamp: 'aa 6/26/2023 20:51:59'!
invalidRecordSyntaxErrorMessage

	^'Syntax is invalid for one of the records'! !

!CustomerImporter class methodsFor: 'error-messages' stamp: 'aa 6/26/2023 21:34:26'!
recordIsNotCustomerNorAddressErrorMessage

	^'Record is not a customer nor an address'! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
