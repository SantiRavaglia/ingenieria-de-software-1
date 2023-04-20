!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'aaa 4/19/2023 21:06:28'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:23:30'!
addInteger: anInteger toFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := (aFraction denominator * anInteger value ) + aFraction numerator .
	newDenominator := aFraction denominator  .
	
	^Fraccion with: newNumerator over: newDenominator
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:33:32'!
compareInteger: anInteger toFraction: aFraction

	^anInteger value= (aFraction numerator / aFraction denominator )! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:31:04'!
multiplyInteger: anInteger withFraction: aFraction

	^Fraccion with: (anInteger value * aFraction numerator) over: aFraction denominator ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/18/2023 17:26:25'!
* aMultiplier 
	
	^aMultiplier multiplyWithInteger: self
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/18/2023 16:53:29'!
+ anAdder 
	
	^anAdder addToInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:28:27'!
- aSubtrahend 
	
	^aSubtrahend substractsFromInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:07:10'!
/ aDivisor 
	
	^aDivisor dividesInteger: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:24:44'!
addToFraction: aFraction
	"
	| newNumerator newDenominator |

	newNumerator := (self value * aFraction denominator) + aFraction numerator .
	newDenominator :=  aFraction denominator .
	^Fraccion with: newNumerator over: newDenominator 
	"
	^self addInteger: self toFraction: aFraction ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 10:40:37'!
addToInteger: anInteger

	^self class with: value + anInteger integerValue ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:21:08'!
dividesFraction: aFraction

    | newDenominator |
    newDenominator := self value * aFraction denominator .
    ^Fraccion with: aFraction numerator over: newDenominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:07:02'!
dividesInteger: anInteger
    ^Fraccion with: anInteger value over: self value! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 19:51:11'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:31:54'!
multiplyWithFraction: aFraction
	"
	^Fraccion with: (self value * aFraction numerator) over: aFraction denominator
	"
	^self multiplyInteger: self withFraction: aFraction ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 10:40:53'!
multiplyWithInteger: anInteger

	^self class with: value * (anInteger integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:28:32'!
substractsFromFraction: aFraction

    |newNumerator|
    newNumerator := aFraction numerator - (aFraction denominator * self value).
    ^Fraccion with: newNumerator over: aFraction denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 09:11:43'!
substractsFromInteger: anInteger
    ^Entero with: anInteger integerValue - value! !


!Entero methodsFor: 'comparing' stamp: 'aaa 4/20/2023 13:34:13'!
= anObject
	
	^anObject compareToInteger: self
	
	! !

!Entero methodsFor: 'comparing' stamp: 'aaa 4/20/2023 13:34:38'!
compareToFraction: aFraction
	"
	^value= (aFraction numerator / aFraction denominator )
	"
	^self compareInteger: self toFraction: aFraction ! !

!Entero methodsFor: 'comparing' stamp: 'aaa 4/19/2023 16:32:01'!
compareToInteger: anInteger

    ^value = anInteger integerValue
! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'aaa 4/19/2023 19:47:38'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^Cero new] .
	aValue = 1 ifTrue: [^Uno new] .
	aValue < 0 ifTrue: [^Negativo new initializeWith: aValue] .
	
	^self new initalizeWith: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:48:19'!
fibonacci

	^Uno new! !

!Cero methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:45:20'!
initialize

	value := 0! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:44:55'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !

!Negativo methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:50:46'!
initializeWith: aValue

	value := aValue! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:48:07'!
fibonacci

	^Uno new! !

!Uno methodsFor: 'as yet unclassified' stamp: 'aaa 4/19/2023 19:45:30'!
initialize

	value := 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/18/2023 17:26:01'!
* aMultiplier 
	
	^aMultiplier multiplyWithFraction: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/18/2023 16:53:35'!
+ anAdder 
	
	^anAdder addToFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:28:23'!
- aSubtrahend 

    ^aSubtrahend substractsFromFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:07:27'!
/ aDivisor 

    ^aDivisor dividesFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 10:29:47'!
addToFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	
	^Fraccion with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:25:11'!
addToInteger: anInteger

	"
	| newNumerator newDenominator |
	
	newNumerator := (denominator * anInteger value ) + numerator .
	newDenominator := denominator  .
	
	^Fraccion with: newNumerator over: newDenominator
	"
	
	^self addInteger: anInteger toFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:19:00'!
dividesFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := denominator value * aFraction numerator .
	newDenominator := numerator value * aFraction denominator .
	^Fraccion with: newNumerator over: newDenominator
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:27:03'!
dividesInteger: anInteger

    |newNumerator|
    newNumerator:= anInteger value * denominator.
    ^Fraccion with: newNumerator over: numerator
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 10:29:24'!
multiplyWithFraction: aFraction

	^Fraccion with: (numerator * aFraction numerator) over: (denominator value * aFraction denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/20/2023 13:31:40'!
multiplyWithInteger: anInteger
	"
	^Fraccion with: (anInteger value * numerator) over: denominator 
	"
	^self multiplyInteger: anInteger withFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:28:16'!
substractsFromFraction: aFraction

    | newNumerator newDenominator |

    newNumerator := (denominator * aFraction numerator) - (numerator * aFraction denominator) .
    newDenominator := denominator * aFraction denominator .

    ^Fraccion with: newNumerator over: newDenominator
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'aaa 4/19/2023 16:30:27'!
substractsFromInteger: anInteger

    | newNumerator|
    newNumerator := (anInteger value * denominator) - numerator .
    ^Fraccion with: newNumerator over: denominator
! !


!Fraccion methodsFor: 'comparing' stamp: 'aaa 4/19/2023 16:33:10'!
= anObject

    ^anObject compareToFraction: self! !

!Fraccion methodsFor: 'comparing' stamp: 'aaa 4/19/2023 16:33:04'!
compareToFraction: aFraction

    ^(numerator * aFraction denominator) = (denominator * aFraction numerator)! !

!Fraccion methodsFor: 'comparing' stamp: 'aaa 4/20/2023 13:34:58'!
compareToInteger: anInteger
	"
	^(numerator / denominator)  = anInteger value
	"
	^self compareInteger: anInteger toFraction: self! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
