Proceso TP1_Grupo5	
	//Materia: Programaci�n I
	//Profesoras: Natalia Fernandez / Sof�a Errecarte
	//Integrantes del Grupo5:	Paula Molina; Gianluca Marconi Favini; Enrique Marconi Favini
	//Este proyecto tiene como objetivo desarrollar un Sistema de Reservas para administrar el uso de Canchas deportivas dentro de un establecimiento, que brinde una soluci�n eficiente y conveniente para
	//		optimizar los tiempos libres disponibles en cada cancha y as� tambi�n poder administrar las reservas realizadas por los usuarios.- 
	//El sistema permitir� verificar la disponibilidad de las canchas en tiempo real, seleccionar el horario deseado y realizar la reserva de forma instant�nea. 
	//Los operadores y/o administradores del sistema  contar�n con un men� de control donde podr�n gestionar las reservas, supervisar la ocupaci�n de la cancha y realizar ajustes o cancelaciones seg�n sea
	//		necesario. 
	//Dicho sistema busca simplificar el proceso de reserva de las canchas, optimizar el uso de las mismas y evitar conflictos de horarios con los usuarios.
	
	//	Las opciones del men� deber�an ser:
	// 		1. Carga de reserva de turnos para las canchas = SubProceso cargaReserva()
	// 		2. B�squeda de reserva (por cancha, d�a, horario) = Funci�n busquedaReservaDia()
	// 		3. B�squeda de reserva (por nombre) = Funci�n busquedaReservaNombre()
	// 		4. Listado de reservas del d�a = SubProceso listadoReservasDia()
	// 		5. Listado de reservas del mes = SubProceso listadoReservasMes()
	// 		6. Listado de horarios disponibles para reservar la cancha en un d�a determinado = SubProceso horariosLibres()
	// 		7. Cancelaci�n de reserva = Funci�n cancelaReserva()
	// 		8. Salir
	//	Y de acuerdo a la opci�n seleccionada:
	// 		1. La carga de reservas consistir� en ingresar un turno al vector reservas[dia,turno].-
	// 		2. La busqueda consistir� en buscar en el vector reservas[cancha, dia,turno] la cancha-dia-horario reservado.-
	// 		3. La b�squeda por nombre consistir� justamente en buscar ese nombre con el que se reserv� la cancha en el vector reservas[cancha, dia, turno].-
	// 		4. Mostrar� por pantalla todas las reservas realizadas en el d�a ingresado por el operador para una cancha determinada.-
	// 		5. Mostrar� por pantalla todas las reservas realizadas en el mes para una cancha determinada.-
	// 		6. Mostrar� por pantalla todos los horarios disponibles para reservar cualquiera de las dos canchas en un d�a determinado.-
	// 		7. En esta opci�n el administrador del sistema podr� borrar/cancelar una reserva previamente hecha.-
	// 		8. Salida del sistema de reservas.-
	
	// Especificaciones del sistema.
	// Al iniciar el programa el supervisor del establecimiento deber� ingresar la clave de acceso secreta (password) con la cual se permitir� acceder a la opci�n 7 del men� (cancelar turnos) como
	// 		medida de seguridad para no eliminar reservas ya otorgadas por un error involuntario del operador del sistema, como as� tambi�n a la opci�n 8 del sistema, puesto que al no contar con 
	// 		archivos de bases de datos, si se sale del sistema se pierden todos los datos guardados.-
	// Adem�s, solicitar� se ingrese el mes en curso para generar el vector necesario para operar el sistema (al no poder acceder a bases de datos o archivos previamente cargados/almacenados).-
	// De esta forma se inicializa el sistema creando un vector de n d�as (de acuerdo al mes ingresado) y 12 reservas posibles dentro de un mismo d�a (tomando cada reserva de una hora a partir de 
	// 		las 10 am, que ser� el primer turno disponible, hasta las 22 pm que ser� el �ltimo antes del cierre del establecimiento).-
	// El sistema utilizar� un vector de tres dimensiones (de tipo caracter) para las reservas, donde el primer �ndice se utilizar� para individualizar el tipo de cancha reservar ("Techada"/"Descubierta), 
	//		el segundo �ndice del vector servir� para individualizar el d�a de dicha reserva y por �ltimo el �ndice final me indicar� el turno/horario dentro de ese d�a.
	
	Definir reservas, password, nombreMes, nombreUsuarioReserva Como Caracter
	Definir i, j, mes, cantidad_diasMes, opcionDelMenu Como Entero
	Definir banderaSalir, ingresoClave_VF, confirmaCancelaReserva_VoF Como Logico
	mes=0
	cantidad_diasMes=0
	nombreMes=""
	password=""
	banderaSalir=Falso
	ingresoClave_VF=Falso
	
	claveAcceso(password)				// llamado al SubProceso claveAcceso para el ingreso de la clave de bloqueo para cancelaciones y salida del sistema (SubProceso claveAcceso en l�nea N� ... )
	
	Escribir "Para inicializar el sistema, por favor ingrese n�mero de mes donde realizar� las reservas de la cancha: "
	ingresoMes(mes, nombreMes, cantidad_diasMes)	// llamado al SubProceso ingresoMes, donde solicita el n�mero de mes y asigna por referencia el nombre de ese mes espec�fico (SubProceso en l�nea N� ... )
	
	Dimension reservas[2, cantidad_diasMes, 12]	// una vez dimensionado el vector, debo cargarlo con datos vacios porque sino al querer cancelar una reserva de una posicion que no tiene nada tira error
	inicializarVectorReservas(reservas, cantidad_diasMes)				// coloca en todas las posiciones del vector un espacio vacio
	
	Mientras !banderaSalir Hacer			// NOT banderaSalir (como banderaSalir tiene Falso, doy vuelta la condici�n)
		Limpiar Pantalla
		Escribir "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
		Escribir "*                  Bienvenido al sistema de reserva de canchas deportivas             *"
		Escribir "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
		Escribir ""
		Escribir "Men� de opciones del sistema"
		Escribir "----------------------------"
		Escribir "1. Carga de reserva de turnos para las canchas."
		Escribir "2. B�squeda de reserva (por d�a-horario)."
		Escribir "3. B�squeda de reserva (por nombre)."
		Escribir "4. Listado de reservas de un d�a determinado."
		Escribir "5. Listado de reservas del mes de ",nombreMes ,"."
		Escribir "6. Listado de horarios disponibles para reservar una cancha en un d�a determinado."
		Escribir "7. Cancelaci�n de reserva."
		Escribir "8. Salir del sistema."
		Escribir ""
		Escribir "Por favor, ingrese la opci�n del men� que desea utilizar: "
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>8 Hacer
			Escribir "Ese n�mero ingresado no corresponde a ninguna opci�n del men�, las opciones son desde el n�mero 1 hasta el 8"
			Escribir "Por favor, vuelva a ingresar el n�mero correspondiente a la opci�n del men� deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Limpiar Pantalla
		Segun opcionDelMenu Hacer
			1:
				// SubProceso cargaReserva()		// se carga cada reserva para cada cancha en el d�a y horario seleccionado (si se encuentra libre).-
				// Los par�metros que paso al SubProceso son: el vector reservas, la cantidad de d�as del mes(por valor) sobre el que definimos dicho vector y por �ltimo el nombre del mes(por valor)
				cargaReserva(reservas, cantidad_diasMes, nombreMes)
			2:
				// Funci�n busquedaReservaDia()	// el programa solicita la cancha, el d�a y el horario que desea ver y se muestra por pantalla si se encuentra libre o no (si est� ocupado muestra el nombre de la reserva).-
				nombreUsuarioReserva=busquedaReservaDia(reservas, cantidad_diasMes, nombreMes)
				Si nombreUsuarioReserva<>"OperadorAbandonaLaB�squeda" Entonces
					Si nombreUsuarioReserva="" Entonces
						Escribir "Ese turno se encuentra LIBRE, puede realizar la reserva"
					SiNo
						Escribir "Ese turno ya se encuentra RESERVADO por el Sr.", nombreUsuarioReserva
					Fin Si
				SiNo
					Escribir "El operador anula la b�squeda, el sistema regresa al Men� Principal"
				Fin Si
				Escribir "Presione una tecla para continuar..."
				Esperar Tecla
			3:
				// Funci�n busquedaReservaNombre()	// el operador ingresa el nombre de la reserva y el programa mostrar� por pantalla todas las reservas con ese nombre para una cancha determinada.-
			4:
				// SubProceso listadoReservasDia()	// el operador ingresa la cancha y el d�a que quiere ver y se muestran por pantalla todas las reservas de ese d�a.-
			5:
				// SubProceso listadoReservasMes()	// el operador ingresa la cancha que desea visualizar y se muestra por pantalla las reservas del mes en curso para esa cancha solicitada.-
			6:
				// SubProceso horariosLibres()		// solicita al operador que ingrese un d�a y muestra los horarios libres para cualquiera de las dos canchas.-
			7:
				ingresoClave_VF=solicitaClave(password) // llamado a la funci�n solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en l�nea N� ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Autoriza cancelaci�n de reserva.
					cancelaReserva(reservas, cantidad_diasMes, nombreMes) 		// SubProceso para cancelar una reserva (en l�nea N� ....).
				SiNo
					// Clave incorrecta - No autoriza el ingreso al proceso de cancelaci�n de reserva.-
					Limpiar Pantalla
					Escribir "************************************** ATENCI�N ***************************************"
					Escribir "*        La clave ingresada no es la correcta, ingreso a la opci�n denegada           *"
					Escribir "***************************************************************************************"
					Escribir ""
					Escribir "Presione una tecla para continuar..."
					Esperar Tecla
				Fin Si
			8:
				ingresoClave_VF=solicitaClave(password)	// llamado a la funci�n solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en l�nea N� ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Permite salir del sistema de reservas.-
					banderaSalir=Verdadero
				SiNo
					// Clave incorrecta - No autoriza el ingreso al proceso de cancelaci�n de reserva.-
					Limpiar Pantalla
					Escribir "************************************** ATENCI�N ***************************************"
					Escribir "*        La clave ingresada no es la correcta, ingreso a la opci�n denegada           *"
					Escribir "***************************************************************************************"
					Escribir ""
					Escribir "Presione una tecla para continuar..."
					Esperar Tecla
				Fin Si
		Fin Segun
	Fin Mientras
	Escribir ""
	Escribir "* Gracias por utilizar nuestro sistema de reserva de canchas deportivas "
	Escribir "* Pensado y desarrollado por:"
	Escribir "  ---------------------------"
	Escribir "* Paula Molina"
	Escribir "* Gianluca Marconi Favini"
	Escribir "* Enrique Marconi Favini"
FinProceso

//**********************************************************************************************************************************************************************************************************************************

SubProceso claveAcceso(password Por Referencia)
	Escribir "Buenos d�as Sr. Supervisor."
	Escribir "Por favor ingrese la clave que utilizar� para bloquear el acceso a los items restringidos del men�: " 
	Leer password
	Mientras Longitud(password)<6 Hacer
		Escribir "La clave de acceso es demasiado corta, debe tener como m�nimo seis caracteres"
		Escribir "Por favor, vuelva a ingresar la clave: "
		Leer password
	Fin Mientras	
FinSubProceso

// *********************************************************************************************************************************************************************************************************************************

SubProceso ingresoMes(mes Por Referencia, nombreMes Por Referencia, cantidad_diasMes Por Referencia)	// SubProceso utilizado para solicitar al operador que ingrese el mes, validar y llamar a dos funciones
	// que asignan el nombre del mes seleccionado y la cantidad de d�as que le corresponden.-
	Leer mes
	Mientras mes<1 o mes>12 Hacer
		Escribir "El n�mero ingresado no corresponde a ning�n mes, por favor ingrese un n�mero entre 1 y 12: "
		Leer mes
	Fin Mientras
	nombreMes=asignaNombreMes(mes)			// Funci�n que devuelve el nombre del mes seleccionado por el operador (Funci�n asignaNombreMes en l�nea N� ... )
	cantidad_diasMes=asignaSegunMes(mes)	// Funci�n que devuelve la cantidad de d�as que tiene el mes seleccionado por el operador (Funci�n asignaSegunMes en l�nea N� ... )
FinSubProceso

// *********************************************************************************************************************************************************************************************************************************

Funcion nombreM<-asignaNombreMes(mes)			// Funci�n utilizada para devolver en la variable el nombre del mes sobre el cual se est� trabajando
	Definir nombreM Como Caracter
	Segun mes Hacer
		1:
			nombreM="ENERO"
		2:
			nombreM="FEBRERO"
		3:
			nombreM="MARZO"
		4:
			nombreM="ABRIL"
		5:
			nombreM="MAYO"
		6:
			nombreM="JUNIO"
		7:
			nombreM="JULIO"
		8:
			nombreM="AGOSTO"
		9:
			nombreM="SEPTIEMBRE"
		10:
			nombreM="OCTUBRE"
		11:
			nombreM="NOVIEMBRE"
		12:
			nombreM="DICIEMBRE"
	Fin Segun
FinFuncion

// **********************************************************************************************************************************************************************************************************************************

Funcion cant_dias<-asignaSegunMes(mes)		// esta funci�n asigna la cantidad de d�as que le corresponden al mes seleccionado por el operador y lo devuelve en la variable que retorna esta funci�n.-
	Definir cant_dias Como Entero
	Segun mes Hacer
		1, 3, 5, 7, 8, 10, 12:
			cant_dias=31
		4, 6, 9, 11:
			cant_dias=30
		De Otro Modo:
			cant_dias=28
	Fin Segun
FinFuncion

// *********************************************************************************************************************************************************************************************************************************

SubProceso inicializarVectorReservas(reservas, cantidad_diasMes Por Valor)	// SubProceso de carga del vector Reservas, se realiza porque al ejecutar el programa daba error al querer cancelar una reserva que no fue 
	Definir i,j,k Como Entero																		// realizada en ese turno, por no estar "inicializado" con ning�n valor el vector.-
	Para i=0 Hasta 1 Con Paso 1 Hacer											
		Para j=0 Hasta cantidad_diasMes-1 Con Paso 1 Hacer
			Para k=0 Hasta 11 Con Paso 1 Hacer
				reservas[i,j,k]=""
			Fin Para
		Fin Para
	Fin Para
FinSubProceso

// ********************************************************************************************************************************************************************************************************************************

Funcion ingresoVoF<-solicitaClave(password)			// Funci�n utilizada para controlar el correcto ingreso de la clave. La funci�n devuelve una variable l�gica con Verdadero si fue correcta y Falso si no coincide con la clave.
	Definir claveingresada Como Caracter
	Definir ingresoVoF Como Logico
	Escribir "**********************************  A T E N C I O N  ************************************"
	Escribir "* Usted ha ingresado a una opci�n que compromete la integridad y seguridad de los datos *"
	Escribir "*          Para continuar deber� ingresar la clave de acceso del Supervisor             *"
	Escribir "*****************************************************************************************"
	Escribir "Por favor ingrese la clave: "
	Leer claveingresada
	Si claveingresada == password Entonces
		ingresoVoF=Verdadero
	SiNo
		ingresoVoF=Falso
	Fin Si
FinFuncion

// *******************************************************************************************************************************************************************************************************************************

SubProceso cargaReserva(reservas, cantidad_diasMes Por Valor, nombreMes Por Valor)		// SubProceso de carga de una reserva.-
	Definir cancha, nombreDia, turno, nombre_usuario Como Caracter
	Definir banderaSalir, banderaSalir1, banderaSalir2 Como Logico
	Definir opcionDelMenu, nro_cancha, nro_dia, nro_horario Como Entero
	turno=""	// si esta variable permanece vac�a al final del SubProceso significa que el operador no ingres� al bucle de selecci�n del turno porque decidi� no hacer la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opci�n posible del men�
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selecci�n del D�A hasta que seleccione un d�a v�lido
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selecci�n del TURNO hasta que seleccione un turno(horario) v�lido.
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha que el usuario desea reservar (TECHADA o DESCUBIERTA), representado por el primer �ndice del vector reservas[cancha,dia,turno]
		Escribir "---------------------------------------------------------------------------------------" // se utiliza "-" en vez de "*" para diferenciar claramente a la vista del operador del
		Escribir "*                       Carga de Reserva de una cancha deportiva                      *" // sistema que ha ingresado a una opci�n del men�.- 
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el tipo de cancha que desea reservar: "
		Escribir "--------------------------------------------------------"
		Escribir "1. Cancha TECHADA"
		Escribir "2. Cancha DESCUBIERTA"
		Escribir "3. Salir (volver al men� principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese n�mero ingresado no corresponde a ninguna opci�n del men�, las opciones son desde el n�mero 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el n�mero correspondiente a la opci�n del men� deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0			// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1			// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingres� la opci�n 3 del men�, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realiz� la selecci�n o eligi� la opci�n 3 para salir, salgo del bucle de carga del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el d�a de la reserva / las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el usuario desea reservar, representado por el segundo �ndice del vector reservas[cancha,DIA,turno]
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el d�a del mes de ", nombreMes, " que desea reservar esa cancha ", cancha, ": "
		Escribir "----------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el n�mero CERO vuelve al Men� Principal"		// la idea es que el operador pueda salir de la opci�n en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese n�mero ingresado no corresponde a ning�n d�a del mes de ", nombreMes, " , las opciones posibles son desde el n�mero 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Men� Principal presione el n�mero CERO."
				Escribir "Por favor, vuelva a ingresar el d�a que desea reservar esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realiz� la selecci�n del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// D�a de la reserva seleccionada, paso a elegir el turno de la reserva (horario) / las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandon� la carga antes de esta opci�n, porque luego verifico en la l�nea 313 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el usuario desea reservar, representado por el �ltimo �ndice del vector reservas[cancha,dia,TURNO]
		eligeTurno("RESERVAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selecci�n de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta funci�n devuelve una variable con el nombre del turno seg�n la selecci�n del n�mero de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la pr�xima intrucci�n del SubProceso debo preguntar si no eligi� SALIR (N� 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada.-
	
	// Si opcionDelMenu es distinto de 13 (no eligi� Salir), entonces el operador ya carg� todos los datos.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligi� la opci�n 13 de men�(Salir) y eligi� un turno, por lo cual dentro del Si contin�o con la carga de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posici�n del Vector reservas[CANCHA(en variable nro_cancha), DIA(variable en nro_dia-1), TURNO(en variable opcionDelMenu-1)]
		// Actualizo los valores del �ndice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del �ndice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1
		// Deber�a buscar esa posici�n en el vector para asegurarme que no se encuentre ocupada con una reserva! En ese caso informar al operador que ese turno se encuentra ocupado y vuelve al Men� Ppal.-
		// Si se encuentra libre la ocupo con ESTA RESERVA, preguntando antes el nombre de la persona que quiere reservar la cancha.-
		Si reservas[nro_cancha, nro_dia, nro_horario] == "" Entonces		// significa que no hay ninguna reserva realizada en ese turno para ese d�a y esa cancha.-
			// solicito datos de la reserva (nombre del usuario)
			Escribir "La reserva se encuentra disponible"
			Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " no se encuentra ocupada de ", turno
			Escribir "Por favor ingrese el nombre de la persona que reserva ese turno: "
			Leer nombre_usuario
			Mientras Longitud(nombre_usuario)<4 Hacer
				Escribir "El nombre ingresado tiene menos de cuatro caracteres"
				Escribir "Por favor, ingrese un nombre que pueda identificar m�s claramente a quien hizo la reserva"
				Leer nombre_usuario
			Fin Mientras
			reservas[nro_cancha, nro_dia, nro_horario]=Mayusculas(nombre_usuario)
			Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " de ", turno, " ha sido reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
		SiNo
			Escribir "�ATENCION! - La reserva NO SE ENCUENTRA DISPONIBLE!"
			Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " de ", turno, " se encuentra reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Escribir "Sr.Operador, por favor, verifique los horarios disponibles, muchas gracias."
		Fin Si
		Escribir "Presione una tecla para continuar..."
		Esperar Tecla
	Fin Si
	// Fin del SubProceso de carga de reserva.-
Fin SubProceso

// **********************************************************************************************************************************************************************************************************************************

Funcion nombre_Turno<-nombreTurno(opcionDelMenu)	// esta funci�n devuelve una variable con el nombre del turno seg�n la selecci�n del n�mero de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
	Definir nombre_Turno Como Caracter
	Segun opcionDelMenu Hacer
		1:
			nombre_Turno="10hs a 11hs"
		2:
			nombre_Turno="11hs a 12hs"
		3:
			nombre_Turno="12hs a 13hs"
		4:
			nombre_Turno="13hs a 14hs"
		5:
			nombre_Turno="14hs a 15hs"
		6:
			nombre_Turno="15hs a 16hs"
		7:
			nombre_Turno="16hs a 17hs"
		8:
			nombre_Turno="17hs a 18hs"
		9:
			nombre_Turno="18hs a 19hs"
		10:
			nombre_Turno="19hs a 20hs"
		11:
			nombre_Turno="20hs a 21hs"
		12:
			nombre_Turno="21hs a 22hs"
	Fin Segun
FinFuncion

// **********************************************************************************************************************************************************************************************************************************

Funcion nomb_usuario<-busquedaReservaDia(reservas, cantidad_diasMes Por Valor, nombreMes Por Valor)
	Definir nomb_usuario Como Caracter
	Definir cancha, nombreDia, turno, nombre_usuario Como Caracter
	Definir banderaSalir, banderaSalir1, banderaSalir2 Como Logico
	Definir opcionDelMenu, nro_cancha, nro_dia, nro_horario Como Entero
	turno=""	// si esta variable permanece vac�a al final del SubProceso significa que el operador no ingres� al bucle de selecci�n del turno porque decidi� no buscar la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opci�n posible del men�.-
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selecci�n del D�A hasta que seleccione un d�a v�lido.-
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selecci�n del TURNO hasta que seleccione un turno(horario) v�lido.-
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha sobre la cual el operador busca la reserva (TECHADA o DESCUBIERTA), representado por el primer �ndice del vector reservas[cancha,dia,turno]
		Escribir "---------------------------------------------------------------------------------------" // se utiliza "-" en vez de "*" para diferenciar claramente a la vista del operador del
		Escribir "*                  B�squeda de una Reserva para una cancha deportiva                   *" // sistema que ha ingresado a una opci�n del men�.- 
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el tipo de cancha sobre la cual desea buscar una reserva: "
		Escribir "---------------------------------------------------------------------------"
		Escribir "1. Buscar una reserva en cancha TECHADA"
		Escribir "2. Buscar una reserva en cancha DESCUBIERTA"
		Escribir "3. Salir (volver al men� principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese n�mero ingresado no corresponde a ninguna opci�n del men�, las opciones son desde el n�mero 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el n�mero correspondiente a la opci�n del men� deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0		// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1		// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingres� la opci�n 3 del men�, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realiz� la selecci�n o eligi� la opci�n 3 para salir, salgo del bucle de b�squeda del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el d�a de la reserva / las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el operador desea buscar, representado por el segundo �ndice del vector reservas[cancha,DIA,turno]
		Escribir "-------------------------------------------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el d�a del mes de ", nombreMes, " del cual desea buscar una reserva hecha para esa cancha ", cancha, ": "
		Escribir "-------------------------------------------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el n�mero CERO vuelve al Men� Principal"		// la idea es que el operador pueda salir de la opci�n en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese n�mero ingresado no corresponde a ning�n d�a del mes de ", nombreMes, " , las opciones posibles son desde el n�mero 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Men� Principal presione el n�mero CERO."
				Escribir "Por favor, vuelva a ingresar el d�a que desea buscar la reserva en esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realiz� la selecci�n del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// D�a de la reserva seleccionada, paso a elegir el turno de la reserva (horario) / las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandon� la b�squeda antes de esta opci�n, porque luego verifico en la l�nea 463 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el operador desea buscar, representado por el �ltimo �ndice del vector reservas[cancha,dia,TURNO]
		eligeTurno("BUSCAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selecci�n de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta funci�n devuelve una variable con el nombre del turno seg�n la selecci�n del n�mero de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la pr�xima intrucci�n del SubProceso debo preguntar si no eligi� SALIR (N� 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada.-
	
	// Si opcionDelMenu es distinto de 13 (no eligi� Salir), entonces el operador ya carg� los datos necesarios para realizar la b�squeda.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligi� la opci�n 13 de men�(Salir) y eligi� un turno, por lo cual dentro del Si contin�o con la b�squeda de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posici�n del Vector reservas[CANCHA(en variable nro_cancha), DIA(en la variable nro_dia-1), TURNO(en la variable opcionDelMenu-1)]
		// Actualizo los valores del �ndice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del �ndice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1		// Deber�a buscar esa posici�n en el vector para pasar el dato a la variable que devuelve la Funci�n ().-
		nomb_usuario=reservas[nro_cancha, nro_dia, nro_horario]
	Fin Si
	Si opcionDelMenu==13 o turno=="" Entonces
		nomb_usuario="OperadorAbandonaLaB�squeda"
	Fin Si
FinFuncion

// ************************************************************************************************************************************************************************************************************************************

SubProceso cancelaReserva(reservas, cantidad_diasMes Por Valor, nombreMes Por Valor)
	Definir nomb_usuario Como Caracter
	Definir cancha, nombreDia, turno, nombre_usuario, confirmaCancelacion Como Caracter
	Definir banderaSalir, banderaSalir1, banderaSalir2 Como Logico
	Definir opcionDelMenu, nro_cancha, nro_dia, nro_horario Como Entero
	turno=""	// si esta variable permanece vac�a al final del SubProceso significa que el operador no ingres� al bucle de selecci�n del turno porque decidi� no cancelar la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opci�n posible del men�.-
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selecci�n del D�A hasta que seleccione un d�a v�lido.-
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selecci�n del TURNO hasta que seleccione un turno(horario) v�lido.-
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha sobre la cual el operador busca la reserva (TECHADA o DESCUBIERTA), representado por el primer �ndice del vector reservas[cancha,dia,turno]
		Escribir "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\***/////////////////////////////////////////////" // se utiliza "\*/" para diferenciar claramente a la vista del operador del sistema el acceso a una 
		Escribir "*                  CANCELACION de una Reserva para una cancha deportiva                  *" 				// opci�n diferente del men�.- 
		Escribir "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\***/////////////////////////////////////////////"
		Escribir "Por favor, ingrese el tipo de cancha sobre la cual desea CANCELAR una reserva: "
		Escribir "------------------------------------------------------------------------------"
		Escribir "1. CANCELAR una reserva en cancha TECHADA"
		Escribir "2. CANCELAR una reserva en cancha DESCUBIERTA"
		Escribir "3. Salir (volver al men� principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese n�mero ingresado no corresponde a ninguna opci�n del men�, las opciones son desde el n�mero 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el n�mero correspondiente a la opci�n del men� deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0		// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1		// los �ndices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingres� la opci�n 3 del men�, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Men� Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realiz� la selecci�n o eligi� la opci�n 3 para salir, salgo del bucle de b�squeda del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el d�a de la reserva / las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el operador desea buscar, representado por el segundo �ndice del vector reservas[cancha,DIA,turno]
		Escribir "--------------------------------------------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el d�a del mes de ", nombreMes, " del cual desea CANCELAR una reserva hecha para esa cancha ", cancha, ": "
		Escribir "--------------------------------------------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el n�mero CERO vuelve al Men� Principal"		// la idea es que el operador pueda salir de la opci�n en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese n�mero ingresado no corresponde a ning�n d�a del mes de ", nombreMes, " , las opciones posibles son desde el n�mero 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Men� Principal presione el n�mero CERO."
				Escribir "Por favor, vuelva a ingresar el d�a que desea CANCELAR una reserva de esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingres� un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Men� Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realiz� la selecci�n del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// D�a de la reserva seleccionada, paso a elegir el turno de la reserva (horario) a CANCELAR/ las banderas condicionan la entrada al pr�ximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandon� la CANCELACION antes de esta opci�n, porque luego verifico en la l�nea 463 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el operador desea CANCELAR, representado por el �ltimo �ndice del vector reservas[cancha,dia,TURNO]
		eligeTurno("CANCELAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selecci�n de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta funci�n devuelve una variable con el nombre del turno seg�n la selecci�n del n�mero de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la pr�xima intrucci�n del SubProceso debo preguntar si no eligi� SALIR (N� 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada que se desea CANCELAR.-
	
	// Si opcionDelMenu es distinto de 13 (no eligi� Salir), entonces el operador ya carg� los datos necesarios para realizar la b�squeda de la reserva a CANCELAR.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligi� la opci�n 13 de men�(Salir) y eligi� un turno, por lo cual dentro del Si contin�o con la CANCELACION de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posici�n del Vector reservas[CANCHA(en variable nro_cancha), DIA(en la variable nro_dia-1), TURNO(en la variable opcionDelMenu-1)]
		// Actualizo los valores del �ndice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del �ndice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1		// Deber�a buscar esa posici�n en el vector para pasar el dato a la variable que devuelve la Funci�n ().-
		nomb_usuario=reservas[nro_cancha, nro_dia, nro_horario]
		Si reservas[nro_cancha, nro_dia, nro_horario]<>"" Entonces			// si esta pregunta devuelve Verdadero significa que la cancha est� ocupada con una persona que reserv� con anterioridad.-
			Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " de ", turno, " se encuentra reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Escribir "Sr.Operador: �est� seguro que desea CANCELAR esta reserva? (S=Si/N=No):"
			Leer confirmaCancelacion
			confirmaCancelacion=Mayusculas(confirmaCancelacion)
			Mientras confirmaCancelacion<>"S" Y confirmaCancelacion<>"N" Hacer
				Escribir "La letra ingresada debe ser S por SI o N por NO"
				Escribir "Por favor, confirme si realiza la cancelaci�n de la reserva o no (S=Si/N=No): "
				Leer confirmaCancelacion
				confirmaCancelacion=Mayusculas(confirmaCancelacion)
			Fin Mientras
			Si confirmaCancelacion=="S" Entonces			// borro la reserva
				reservas[nro_cancha, nro_dia, nro_horario]=""
				Escribir "La CANCELACION del turno reservado ha sido exitosa"
			SiNo
				Escribir "La reseva no ha sido cancelada"
				Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " de ", turno, " CONTINUA ESTANDO RESERVADA por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Fin Si
			Escribir "Presione una tecla para continuar..."
		SiNo
			Escribir "La cancha ", cancha, ", el d�a ", nro_dia+1, " de ", turno, " se encuentra LIBRE, por lo tanto no se puede cancelar ninguna reserva."
			Escribir "Por favor, verifique los datos ingresados y vuelva a ingresar, presione una tecla para continuar..."
		Fin Si
		Esperar Tecla
	Fin Si
	Si opcionDelMenu==13 o turno=="" Entonces
		Escribir "Sr.Operador, Usted ha decidido no realizar la cancelaci�n de una reserva"
		Escribir "Presione una tecla para retornar al Men� Principal..."
		Esperar Tecla
	Fin Si
FinSubProceso

// *************************************************************************************************************************************************************************************************************************************

SubProceso eligeTurno(textoDelMsg, cancha por valor, nro_dia por valor, nombreMes por valor, opcionDelMenu Por Referencia)
	Escribir "--------------------------------------------------------------------------------------------------------------------------" 
	Escribir "Por favor, seleccione el turno correspondiente al horario que desea ", textoDelMsg, " para la cancha ", cancha, " del d�a ", nro_dia, " de ", nombreMes, ": "
	Escribir "--------------------------------------------------------------------------------------------------------------------------"
	Escribir "1. Horario de 10hs a 11hs"
	Escribir "2. Horario de 11hs a 12hs"
	Escribir "3. Horario de 12hs a 13hs"
	Escribir "4. Horario de 13hs a 14hs"
	Escribir "5. Horario de 14hs a 15hs"
	Escribir "6. Horario de 15hs a 16hs"
	Escribir "7. Horario de 16hs a 17hs"
	Escribir "8. Horario de 17hs a 18hs"
	Escribir "9. Horario de 18hs a 19hs"
	Escribir "10. Horario de 19hs a 20hs"
	Escribir "11. Horario de 20hs a 21hs"
	Escribir "12. Horario de 21hs a 22hs"
	Escribir "13. Salir (volver al men� principal)"
	Leer opcionDelMenu
	Mientras opcionDelMenu<1 o opcionDelMenu>13 Hacer
		Escribir "Ese n�mero ingresado no corresponde a ninguna opci�n del men�, las opciones son desde el n�mero 1 hasta el 13"
		Escribir "Por favor, vuelva a ingresar el n�mero correspondiente a la opci�n del men� deseada: "
		Leer opcionDelMenu
	Fin Mientras
FinSubProceso
