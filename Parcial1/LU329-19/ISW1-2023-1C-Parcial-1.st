!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'assertions' stamp: 'aa 5/8/2023 21:44:50'!
debeFallaTrasEjecutar: unClosureInvalido exception: unClosureDeException

self should: unClosureInvalido
		raise: Error
		withExceptionDo: unClosureDeException .! !


!TestDePerforación methodsFor: 'set-ups' stamp: 'aa 5/8/2023 21:21:42'!
excavadoraParaConteoDeCapas

	| sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	^Perforadora sobreSuelo: sueloAExcavar.! !


!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:45:03'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
		
	self debeFallaTrasEjecutar: [excavadora darGolpeDeTaladro] 
		exception: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.
		]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:45:08'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
		
	self debeFallaTrasEjecutar: [excavadora darGolpeDeTaladro] 
		exception: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.
		]
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 4/27/2023 21:54:59'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/3/2023 22:34:18'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:45:12'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self debeFallaTrasEjecutar: [excavadora darGolpeDeTaladro] 
		exception: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata.
		]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 16:46:32'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:20'!
test14PuedeContarLasCapasDeTipoArenoso
	
	self assert: 2 equals: (self excavadoraParaConteoDeCapas contarCapas: #Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:26'!
test15PuedeContarLasCapasDeTipoTierra

	self assert: 1 equals: (self excavadoraParaConteoDeCapas contarCapas: #Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:33'!
test16PuedeContarLasCapasDeTipoConcreto

	self assert: 1 equals: (self excavadoraParaConteoDeCapas contarCapas: #Concreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:38'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	self assert: 0 equals: (self excavadoraParaConteoDeCapas calcularProfundidadDelSueloHasta: #Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:42'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	self assert: 2 equals: (self excavadoraParaConteoDeCapas calcularProfundidadDelSueloHasta: #Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:22:47'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	self assert: 42 equals: (self excavadoraParaConteoDeCapas calcularProfundidadDelSueloHasta: #Concreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:45:57'!
test20NoPuedeTenerDosCapasArenosasContiguas

	| sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso setAltura: 2 . CapaDeSuelo arenoso setAltura: 2}.
	
	self debeFallaTrasEjecutar: [Perforadora sobreSuelo: sueloAExcavar] 
	exception: [:unError |
		self assert: 'No se pueden tener dos capas contiguas del mismo tipo!!' equals: unError messageText.
	]! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:46:03'!
test21NoPuedeTenerDosCapasTierraContiguas

	| sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo tierra setAltura: 2 . CapaDeSuelo arenoso setAltura: 2}.
	
	self debeFallaTrasEjecutar: [Perforadora sobreSuelo: sueloAExcavar] 
	exception: [:unError |
		self assert: 'No se pueden tener dos capas contiguas del mismo tipo!!' equals: unError messageText.
	]

	! !

!TestDePerforación methodsFor: 'test' stamp: 'aa 5/8/2023 21:46:06'!
test22NoPuedeTenerDosCapasConcretoContiguas

	| sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo concretoConResistencia: 5  . CapaDeSuelo concretoConResistencia: 5  . CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40 }.
	
	self debeFallaTrasEjecutar: [Perforadora sobreSuelo: sueloAExcavar] 
	exception: [:unError |
		self assert: 'No se pueden tener dos capas contiguas del mismo tipo!!' equals: unError messageText.
	]

	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'tipo resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:58:12'!
bajaUnDecimoDeResistencia
	
	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:58:04'!
sinResistencia
	
	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:18'!
altura

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:23'!
resistencia

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:20'!
tipo

	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'aa 5/8/2023 17:42:40'!
scan

	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'aa 5/8/2023 17:51:10'!
setAltura: unaAltura

	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:50:57'!
esArenoso

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:50:49'!
esConcreto

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:50:44'!
esTierra

	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:41:00'!
= unaCapaDeSuelo

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:58:31'!
hash

	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 20:44:10'!
arenoso

	^SueloArenoso new! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 20:45:05'!
concretoConResistencia: resistencia 

	^SueloConcreto with: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 20:45:02'!
tierra

	^SueloTierra new! !


!classDefinition: #SueloArenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #SueloArenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloArenoso methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:36:03'!
esArenoso
	^true! !

!SueloArenoso methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:36:06'!
esConcreto
	^false! !

!SueloArenoso methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:36:09'!
esTierra
	^false! !


!SueloArenoso methodsFor: 'initialization' stamp: 'aa 5/8/2023 19:29:04'!
initialize

	altura := 0! !


!SueloArenoso methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:40:28'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!SueloArenoso methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:41:29'!
hash

	^tipo hash + resistencia hash! !


!SueloArenoso methodsFor: 'scan' stamp: 'aa 5/8/2023 17:43:07'!
scan 

	^7! !


!SueloArenoso methodsFor: 'setters' stamp: 'aa 5/8/2023 18:02:49'!
setAltura: unaAltura

	altura := unaAltura ! !


!SueloArenoso methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:55:38'!
altura

	^ altura.! !

!SueloArenoso methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:55:57'!
resistencia

	^ resistencia.! !

!SueloArenoso methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:07'!
tipo

	^tipo! !


!SueloArenoso methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:29'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!SueloArenoso methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:36'!
sinResistencia
	^resistencia = 0! !


!SueloArenoso methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:39:53'!
comportamientoConMechaDiamante: mechaDiamante

	mechaDiamante taladrarSobreSueloArenoso ! !

!SueloArenoso methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:39:43'!
comportamientoConMechaSoft: mechaSoft

	mechaSoft taladrarSobreSueloArenoso ! !

!SueloArenoso methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:44:27'!
comportamientoConMechaWidia: mechaWidia

	mechaWidia taladrarSobreSueloArenoso ! !


!classDefinition: #SueloConcreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #SueloConcreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloConcreto methodsFor: 'initialization' stamp: 'aa 5/8/2023 19:29:07'!
initializeWith: resistenciaConcreto

	resistencia := resistenciaConcreto .
	altura := 0! !


!SueloConcreto methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:27'!
esArenoso
	^false! !

!SueloConcreto methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:33'!
esConcreto
	^true! !

!SueloConcreto methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:36'!
esTierra
	^false! !


!SueloConcreto methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:40:28'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!SueloConcreto methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:41:29'!
hash

	^tipo hash + resistencia hash! !


!SueloConcreto methodsFor: 'setters' stamp: 'aa 5/8/2023 18:02:52'!
setAltura: unaAltura

	altura := unaAltura ! !


!SueloConcreto methodsFor: 'scan' stamp: 'aa 5/8/2023 17:43:25'!
scan 

	^ 50. ! !


!SueloConcreto methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:55:42'!
altura

	^ altura.! !

!SueloConcreto methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:00'!
resistencia

	^ resistencia.! !

!SueloConcreto methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:09'!
tipo

	^tipo! !


!SueloConcreto methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:29'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!SueloConcreto methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:36'!
sinResistencia
	^resistencia = 0! !


!SueloConcreto methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:41:44'!
comportamientoConMechaDiamante: mechaDiamante

	mechaDiamante taladrarSobreSueloConcreto ! !

!SueloConcreto methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:41:46'!
comportamientoConMechaSoft: mechaSoft

	mechaSoft taladrarSobreSueloConcreto  ! !

!SueloConcreto methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:44:42'!
comportamientoConMechaWidia: mechaWidia

	mechaWidia taladrarSobreSueloConcreto  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SueloConcreto class' category: 'ISW1-2023-1C-Parcial-1'!
SueloConcreto class
	instanceVariableNames: ''!

!SueloConcreto class methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 17:37:39'!
with: resistenciaConcreto

	^SueloConcreto new initializeWith: resistenciaConcreto ! !


!classDefinition: #SueloTierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #SueloTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SueloTierra methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:59'!
esArenoso
	^false! !

!SueloTierra methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:49'!
esConcreto
	^false! !

!SueloTierra methodsFor: 'tipo' stamp: 'aa 5/8/2023 17:35:57'!
esTierra
	^true! !


!SueloTierra methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:40:28'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!SueloTierra methodsFor: 'comparing' stamp: 'aa 5/8/2023 17:41:29'!
hash

	^tipo hash + resistencia hash! !


!SueloTierra methodsFor: 'initialization' stamp: 'aa 5/8/2023 19:29:10'!
initialize

	altura := 0! !


!SueloTierra methodsFor: 'scan' stamp: 'aa 5/8/2023 17:43:41'!
scan

	^10! !


!SueloTierra methodsFor: 'setters' stamp: 'aa 5/8/2023 18:02:56'!
setAltura: unaAltura

	altura := unaAltura ! !


!SueloTierra methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:55:47'!
altura

	^ altura.! !

!SueloTierra methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:02'!
resistencia

	^ resistencia.! !

!SueloTierra methodsFor: 'accessing' stamp: 'aa 5/8/2023 17:56:11'!
tipo

	^tipo! !


!SueloTierra methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:29'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!SueloTierra methodsFor: 'bajar resistencia' stamp: 'aa 5/8/2023 17:57:36'!
sinResistencia
	^resistencia = 0! !


!SueloTierra methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:41:35'!
comportamientoConMechaDiamante: mechaDiamante

	mechaDiamante taladrarSobreSueloTierra ! !

!SueloTierra methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:41:26'!
comportamientoConMechaSoft: mechaSoft

	mechaSoft taladrarSobreSueloTierra ! !

!SueloTierra methodsFor: 'comportamiento' stamp: 'aa 5/8/2023 18:44:55'!
comportamientoConMechaWidia: mechaWidia

	mechaWidia taladrarSobreSueloTierra! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'aa 5/8/2023 20:15:08'!
darGolpeDeTaladro

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	mechaPuesta golpeDeTaladro: self conMechaSobreSuelo: (capasDeSueloDebajo first) vecesGolpeadas: vecesQueGolpeoCapaActual .
	! !

!Perforadora methodsFor: 'excavation' stamp: 'aa 5/8/2023 18:15:56'!
seRompioMecha

	mechaPuesta := Rota new! !


!Perforadora methodsFor: 'initialization' stamp: 'aa 5/8/2023 18:06:36'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'aa 5/8/2023 19:14:19'!
conMechaRota

	^mechaPuesta isKindOf: Rota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'aa 5/8/2023 18:53:57'!
golpesACapaActual

	^vecesQueGolpeoCapaActual ! !

!Perforadora methodsFor: 'accessing' stamp: 'aa 5/8/2023 18:27:51'!
sinMecha

	^mechaPuesta = SinMecha new! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'aa 5/8/2023 19:07:24'!
ponerMechaDiamante
	mechaPuesta := Diamante with: self! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'aa 5/8/2023 19:07:29'!
ponerMechaSoft
	mechaPuesta := Soft with: self! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'aa 5/8/2023 19:07:35'!
ponerMechaWidia
	mechaPuesta := Widia with: self! !


!Perforadora methodsFor: 'scan' stamp: 'aa 5/8/2023 20:08:32'!
calcularProfundidadDelSuelo
	
	^capasDeSueloDebajo inject: 0 into: [ :alturaAcumulada :capa | 
		alturaAcumulada + (capa altura)
	]
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'aa 5/8/2023 20:08:22'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valor |

	tipoDeCapa = #Arenoso ifTrue: [ valor := 7 ].
	tipoDeCapa = #Tierra ifTrue: [ valor := 10 ].
	tipoDeCapa = #Concreto ifTrue: [ valor := 50].	

	^capasDeSueloDebajo inject: 0 into: [ :capasAcumuladas :capaActual |
		valor = capaActual scan ifTrue: [ ^capasAcumuladas ] ifFalse:[		capasAcumuladas + (capaActual altura)]
	]
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'aa 5/8/2023 20:08:14'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valor |
	
	valor := 0.
	tipoDeCapa = #Arenoso ifTrue: [ valor := 7 ].
	tipoDeCapa = #Tierra ifTrue: [ valor := 10 ].
	tipoDeCapa = #Concreto ifTrue: [ valor := 50].	

	^capasDeSueloDebajo inject: 0 into: [ :capasAcumuladas :capaActual |
		valor = capaActual scan ifTrue: [ capasAcumuladas + 1 ] ifFalse: [capasAcumuladas ].
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 20:46:45'!
errorNoSePuedenTenerDosCapasContiguasIguales

	self error: 'No se pueden tener dos capas contiguas del mismo tipo!!'! !

!Perforadora class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 21:42:47'!
extraerCapasDeSuelo: capasDeSueloAExcavar

	^capasDeSueloAExcavar select: [:elemento | elemento isKindOf: CapaDeSuelo ]! !

!Perforadora class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 21:43:29'!
noHayDosCapasDeSueloContiguas: capasDeSueloAExcavar 

	" Se que esta implementacion es bastante horrible pero fue lo que llegue a pensar a ultimo momento jeje"
	
	| capaAnterior capaActual coleccionDeCapas |
	
	coleccionDeCapas := self extraerCapasDeSuelo: capasDeSueloAExcavar .

	coleccionDeCapas size > 1 ifTrue: [
		(2 to: coleccionDeCapas size) do: [ :index |
			capaAnterior := coleccionDeCapas at: index-1 .
			capaActual := coleccionDeCapas at: index .
			(capaAnterior isKindOf: capaActual class) ifTrue: [Perforadora errorNoSePuedenTenerDosCapasContiguasIguales ]
		]
	]

	! !

!Perforadora class methodsFor: 'instance creation' stamp: 'aa 5/8/2023 21:07:45'!
sobreSuelo: capasDeSueloAExcavar 
	
	self noHayDosCapasDeSueloContiguas: capasDeSueloAExcavar .

	^self new initializeSobreSuelo: capasDeSueloAExcavar 
	! !


!classDefinition: #TiposDeMechas category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #TiposDeMechas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
TiposDeMechas subclass: #Diamante
	instanceVariableNames: 'excavadoraALaQueEstaAcoplada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:06:40'!
acoplarAExcavadora: excavadora

	excavadoraALaQueEstaAcoplada := excavadora ! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:12:25'!
golpeDeTaladro: excavadora conMechaSobreSuelo: tipoDeSuelo vecesGolpeadas: vecesQueGolpeoCapaActual
		
	^tipoDeSuelo comportamientoConMechaDiamante: self! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 18:50:18'!
taladrarSobreSueloArenoso

	excavadoraALaQueEstaAcoplada seRompioMecha . self error: 'Se rompió'! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:01:02'!
taladrarSobreSueloConcreto

	excavadoraALaQueEstaAcoplada golpesACapaActual even ifTrue: [ excavadoraALaQueEstaAcoplada capaDeSueloInmediata bajaUnDecimoDeResistencia ].
	excavadoraALaQueEstaAcoplada capaDeSueloInmediata sinResistencia ifTrue: [ ^excavadoraALaQueEstaAcoplada transformarCapaEnArenoso].
	^excavadoraALaQueEstaAcoplada golpesACapaActual ! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 18:51:31'!
taladrarSobreSueloTierra

	^excavadoraALaQueEstaAcoplada pasarAProximaCapa ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Diamante class' category: 'ISW1-2023-1C-Parcial-1'!
Diamante class
	instanceVariableNames: ''!

!Diamante class methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:10:48'!
with: excavadora

	^Diamante new acoplarAExcavadora: excavadora ! !


!classDefinition: #Rota category: 'ISW1-2023-1C-Parcial-1'!
TiposDeMechas subclass: #Rota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Rota methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 18:31:51'!
golpeDeTaladro: excavadora conMechaSobreSuelo: tipoDeSuelo vecesGolpeadas: vecesQueGolpeoCapaActual

	self error: 'error'! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
TiposDeMechas subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:15:51'!
golpeDeTaladro: excavadora conMechaSobreSuelo: tipoDeSuelo vecesGolpeadas: vecesQueGolpeoCapaActual

	self error: 'No puede perforar'! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
TiposDeMechas subclass: #Soft
	instanceVariableNames: 'excavadoraALaQueEstaAcoplada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:06:42'!
acoplarAExcavadora: excavadora

	excavadoraALaQueEstaAcoplada := excavadora ! !

!Soft methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:12:29'!
golpeDeTaladro: excavadora conMechaSobreSuelo: tipoDeSuelo vecesGolpeadas: vecesQueGolpeoCapaActual

	^tipoDeSuelo comportamientoConMechaSoft: self! !

!Soft methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:02:39'!
taladrarSobreSueloArenoso

	excavadoraALaQueEstaAcoplada pasarAProximaCapa! !

!Soft methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:03:08'!
taladrarSobreSueloConcreto

	excavadoraALaQueEstaAcoplada seRompioMecha . self error: 'Se rompió' ! !

!Soft methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:02:52'!
taladrarSobreSueloTierra

	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Soft class' category: 'ISW1-2023-1C-Parcial-1'!
Soft class
	instanceVariableNames: ''!

!Soft class methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:10:43'!
with: excavadora

	^Soft new acoplarAExcavadora: excavadora ! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
TiposDeMechas subclass: #Widia
	instanceVariableNames: 'excavadoraALaQueEstaAcoplada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:06:44'!
acoplarAExcavadora: excavadora

	excavadoraALaQueEstaAcoplada := excavadora ! !

!Widia methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:12:34'!
golpeDeTaladro: excavadora conMechaSobreSuelo: tipoDeSuelo vecesGolpeadas: vecesQueGolpeoCapaActual	
	
	^tipoDeSuelo comportamientoConMechaWidia: self! !

!Widia methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:03:43'!
taladrarSobreSueloArenoso

	^excavadoraALaQueEstaAcoplada pasarAProximaCapa! !

!Widia methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:04:52'!
taladrarSobreSueloConcreto

	excavadoraALaQueEstaAcoplada golpesACapaActual = 3 ifTrue: [ excavadoraALaQueEstaAcoplada seRompioMecha . self error: 'Se rompió' ].
	^self! !

!Widia methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:04:27'!
taladrarSobreSueloTierra

	excavadoraALaQueEstaAcoplada golpesACapaActual = 2 ifTrue: [ ^excavadoraALaQueEstaAcoplada transformarCapaEnArenoso ].
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Widia class' category: 'ISW1-2023-1C-Parcial-1'!
Widia class
	instanceVariableNames: ''!

!Widia class methodsFor: 'as yet unclassified' stamp: 'aa 5/8/2023 19:10:52'!
with: excavadora

	^Widia new acoplarAExcavadora: excavadora ! !
