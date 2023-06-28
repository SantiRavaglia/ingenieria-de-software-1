!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'aa 6/26/2023 16:25:49'!
test01Import
	
	| customerPepe  customerJuan maipuAddress sanMartinAddress alemAddress |
	
	self importCustomers: self importData .
	
	self assertDataBaseHasCustomers: 2 .
	
	customerPepe := (session select: [:customer | customer identificationType = 'D' and: customer identificationNumber = '22333444'] ofType: Customer) anyOne .
	self assertCustomerDataIsImportedCorrectly: customerPepe firstName: 'Pepe' lastName: 'Sanchez' identificationType: 'D' identificationNumber: '22333444' .
	
	self assertCustomerHas: 2 addresses: customerPepe  .
	
	sanMartinAddress := (customerPepe addressesThatSatisfy: [:address | address streetName = 'San Martin' and: address streetNumber = 3322]) first .
	self assertAddressDataIsImportedCorrectly: sanMartinAddress streetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs' .
	
	maipuAddress := (customerPepe addressesThatSatisfy: [:address | address streetName = 'Maipu' and: address streetNumber = 888]) first .
	self assertAddressDataIsImportedCorrectly: maipuAddress streetName: 'Maipu' streetNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires' .
	
	customerJuan := (session select: [:customer | customer identificationType = 'C' and: customer identificationNumber = '23-25666777-9'] ofType: Customer) anyOne.
	self assertCustomerDataIsImportedCorrectly: customerJuan firstName: 'Juan' lastName: 'Perez' identificationType: 'C' identificationNumber: '23-25666777-9' .
	
	self assertCustomerHas: 1 addresses: customerJuan .
	
	alemAddress := (customerJuan addressesThatSatisfy: [:address | address streetName = 'Alem' and: address streetNumber = 1122]) first .
	self assertAddressDataIsImportedCorrectly: alemAddress streetName: 'Alem' streetNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	
	! !


!ImportTest methodsFor: 'setup-and-teardown' stamp: 'aa 6/22/2023 20:34:42'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setup-and-teardown' stamp: 'aa 6/22/2023 20:35:14'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'data-import' stamp: 'aa 6/26/2023 16:27:25'!
importCustomers: aStream

	(ImportCustomers with: aStream on: session) value! !

!ImportTest methodsFor: 'data-import' stamp: 'aa 6/26/2023 16:17:39'!
importData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'asserts' stamp: 'aa 6/25/2023 20:11:56'!
assertAddressDataIsImportedCorrectly: alemAddress streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince     

	self assert: aStreetName equals: alemAddress streetName .
	self assert: aStreetNumber equals: alemAddress streetNumber .
	self assert: aTown equals: alemAddress town .
	self assert: aZipCode equals: alemAddress zipCode .
	self assert: aProvince equals: alemAddress province! !

!ImportTest methodsFor: 'asserts' stamp: 'aa 6/26/2023 15:59:24'!
assertCustomerDataIsImportedCorrectly: aCustomer firstName: firstName lastName: lastName identificationType: identificationType identificationNumber: identificationNumber 

	self assert: firstName equals: aCustomer firstName . 
	self assert: lastName equals: aCustomer lastName .
	self assert: identificationType equals: aCustomer identificationType .
	self assert: identificationNumber equals: aCustomer identificationNumber! !

!ImportTest methodsFor: 'asserts' stamp: 'aa 6/25/2023 20:23:24'!
assertCustomerHas: aNumberOfAddresses addresses: aCustomer

	^ self assert: aNumberOfAddresses equals: aCustomer amountOfAddresses! !

!ImportTest methodsFor: 'asserts' stamp: 'aa 6/26/2023 16:05:08'!
assertDataBaseHasCustomers: aNumberOfCustomers

	^ self assert: aNumberOfCustomers equals: (session selectAllOfType: Customer) size! !


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

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'aa 6/22/2023 21:45:24'!
addressesThatSatisfy: aConditionBlock

	^ addresses select: [:each | aConditionBlock value: each ]! !

!Customer methodsFor: 'addresses' stamp: 'aa 6/22/2023 21:37:43'!
amountOfAddresses

	^ addresses size! !


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


!classDefinition: #ImportCustomers category: 'CustomerImporter'!
Object subclass: #ImportCustomers
	instanceVariableNames: 'stream session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomers methodsFor: 'as yet unclassified' stamp: 'aa 6/26/2023 16:23:01'!
initializeWith: aStream on: aSession

	stream := aStream .
	session := aSession ! !

!ImportCustomers methodsFor: 'as yet unclassified' stamp: 'aa 6/26/2023 16:22:10'!
value

	| newCustomer line |
	line := stream nextLine .
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := stream nextLine. ].
	session commit.
	stream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomers class' category: 'CustomerImporter'!
ImportCustomers class
	instanceVariableNames: ''!

!ImportCustomers class methodsFor: 'as yet unclassified' stamp: 'aa 6/26/2023 16:26:30'!
with: aStream on: aSession

	^self new initializeWith: aStream on: aSession ! !
