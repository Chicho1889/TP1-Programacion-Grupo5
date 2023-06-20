Proceso TP1_Grupo5	
	//Materia: Programación I
	//Profesoras: Natalia Fernandez / Sofía Errecarte
	//Integrantes del Grupo5:	Paula Molina; Gianluca Marconi Favini; Enrique Marconi Favini
	//Este proyecto tiene como objetivo desarrollar un Sistema de Reservas para administrar el uso de Canchas deportivas dentro de un establecimiento, que brinde una solución eficiente y conveniente para
	//		optimizar los tiempos libres disponibles en cada cancha y así también poder administrar las reservas realizadas por los usuarios.- 
	//El sistema permitirá verificar la disponibilidad de las canchas en tiempo real, seleccionar el horario deseado y realizar la reserva de forma instantánea. 
	//Los operadores y/o administradores del sistema  contarán con un menú de control donde podrán gestionar las reservas, supervisar la ocupación de la cancha y realizar ajustes o cancelaciones según sea
	//		necesario. 
	//Dicho sistema busca simplificar el proceso de reserva de las canchas, optimizar el uso de las mismas y evitar conflictos de horarios con los usuarios.
	
	//	Las opciones del menú deberían ser:
	// 		1. Carga de reserva de turnos para las canchas = SubProceso cargaReserva()
	// 		2. Búsqueda de reserva (por cancha, día, horario) = Función busquedaReservaDia()
	// 		3. Búsqueda de reserva (por nombre) = Función busquedaReservaNombre()
	// 		4. Listado de reservas del día = SubProceso listadoReservasDia()
	// 		5. Listado de reservas del mes = SubProceso listadoReservasMes()
	// 		6. Listado de horarios disponibles para reservar la cancha en un día determinado = SubProceso horariosLibres()
	// 		7. Cancelación de reserva = Función cancelaReserva()
	// 		8. Salir
	//	Y de acuerdo a la opción seleccionada:
	// 		1. La carga de reservas consistirá en ingresar un turno al vector reservas[dia,turno].-
	// 		2. La busqueda consistirá en buscar en el vector reservas[cancha, dia,turno] la cancha-dia-horario reservado.-
	// 		3. La búsqueda por nombre consistirá justamente en buscar ese nombre con el que se reservó la cancha en el vector reservas[cancha, dia, turno].-
	// 		4. Mostrará por pantalla todas las reservas realizadas en el día ingresado por el operador para una cancha determinada.-
	// 		5. Mostrará por pantalla todas las reservas realizadas en el mes para una cancha determinada.-
	// 		6. Mostrará por pantalla todos los horarios disponibles para reservar cualquiera de las dos canchas en un día determinado.-
	// 		7. En esta opción el administrador del sistema podrá borrar/cancelar una reserva previamente hecha.-
	// 		8. Salida del sistema de reservas.-
	
	// Especificaciones del sistema.
	// Al iniciar el programa el supervisor del establecimiento deberá ingresar la clave de acceso secreta (password) con la cual se permitirá acceder a la opción 7 del menú (cancelar turnos) como
	// 		medida de seguridad para no eliminar reservas ya otorgadas por un error involuntario del operador del sistema, como así también a la opción 8 del sistema, puesto que al no contar con 
	// 		archivos de bases de datos, si se sale del sistema se pierden todos los datos guardados.-
	// Además, solicitará se ingrese el mes en curso para generar el vector necesario para operar el sistema (al no poder acceder a bases de datos o archivos previamente cargados/almacenados).-
	// De esta forma se inicializa el sistema creando un vector de n días (de acuerdo al mes ingresado) y 12 reservas posibles dentro de un mismo día (tomando cada reserva de una hora a partir de 
	// 		las 10 am, que será el primer turno disponible, hasta las 22 pm que será el último antes del cierre del establecimiento).-
	// El sistema utilizará un vector de tres dimensiones (de tipo caracter) para las reservas, donde el primer índice se utilizará para individualizar el tipo de cancha reservar ("Techada"/"Descubierta), 
	//		el segundo índice del vector servirá para individualizar el día de dicha reserva y por último el índice final me indicará el turno/horario dentro de ese día.
	
	Definir reservas, password, nombreMes, nombreUsuarioReserva Como Caracter
	Definir i, j, mes, cantidad_diasMes, opcionDelMenu Como Entero
	Definir banderaSalir, ingresoClave_VF, confirmaCancelaReserva_VoF Como Logico
	mes=0
	cantidad_diasMes=0
	nombreMes=""
	password=""
	banderaSalir=Falso
	ingresoClave_VF=Falso
	
	claveAcceso(password)				// llamado al SubProceso claveAcceso para el ingreso de la clave de bloqueo para cancelaciones y salida del sistema (SubProceso claveAcceso en línea Nº ... )
	
	Escribir "Para inicializar el sistema, por favor ingrese número de mes donde realizará las reservas de la cancha: "
	ingresoMes(mes, nombreMes, cantidad_diasMes)	// llamado al SubProceso ingresoMes, donde solicita el número de mes y asigna por referencia el nombre de ese mes específico (SubProceso en línea Nº ... )
	
	Dimension reservas[2, cantidad_diasMes, 12]	// una vez dimensionado el vector, debo cargarlo con datos vacios porque sino al querer cancelar una reserva de una posicion que no tiene nada tira error
	inicializarVectorReservas(reservas, cantidad_diasMes)				// coloca en todas las posiciones del vector un espacio vacio
	
	Mientras !banderaSalir Hacer			// NOT banderaSalir (como banderaSalir tiene Falso, doy vuelta la condición)
		Limpiar Pantalla
		Escribir "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
		Escribir "*                  Bienvenido al sistema de reserva de canchas deportivas             *"
		Escribir "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
		Escribir ""
		Escribir "Menú de opciones del sistema"
		Escribir "----------------------------"
		Escribir "1. Carga de reserva de turnos para las canchas."
		Escribir "2. Búsqueda de reserva (por día-horario)."
		Escribir "3. Búsqueda de reserva (por nombre)."
		Escribir "4. Listado de reservas de un día determinado."
		Escribir "5. Listado de reservas del mes de ",nombreMes ,"."
		Escribir "6. Listado de horarios disponibles para reservar una cancha en un día determinado."
		Escribir "7. Cancelación de reserva."
		Escribir "8. Salir del sistema."
		Escribir ""
		Escribir "Por favor, ingrese la opción del menú que desea utilizar: "
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>8 Hacer
			Escribir "Ese número ingresado no corresponde a ninguna opción del menú, las opciones son desde el número 1 hasta el 8"
			Escribir "Por favor, vuelva a ingresar el número correspondiente a la opción del menú deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Limpiar Pantalla
		Segun opcionDelMenu Hacer
			1:
				// SubProceso cargaReserva()		// se carga cada reserva para cada cancha en el día y horario seleccionado (si se encuentra libre).-
				// Los parámetros que paso al SubProceso son: el vector reservas, la cantidad de días del mes(por valor) sobre el que definimos dicho vector y por último el nombre del mes(por valor)
				cargaReserva(reservas, cantidad_diasMes, nombreMes)
			2:
				// Función busquedaReservaDia()	// el programa solicita la cancha, el día y el horario que desea ver y se muestra por pantalla si se encuentra libre o no (si está ocupado muestra el nombre de la reserva).-
				nombreUsuarioReserva=busquedaReservaDia(reservas, cantidad_diasMes, nombreMes)
				Si nombreUsuarioReserva<>"OperadorAbandonaLaBúsqueda" Entonces
					Si nombreUsuarioReserva="" Entonces
						Escribir "Ese turno se encuentra LIBRE, puede realizar la reserva"
					SiNo
						Escribir "Ese turno ya se encuentra RESERVADO por el Sr.", nombreUsuarioReserva
					Fin Si
				SiNo
					Escribir "El operador anula la búsqueda, el sistema regresa al Menú Principal"
				Fin Si
				Escribir "Presione una tecla para continuar..."
				Esperar Tecla
			3:
				// Función busquedaReservaNombre()	// el operador ingresa el nombre de la reserva y el programa mostrará por pantalla todas las reservas con ese nombre para una cancha determinada.-
			4:
				// SubProceso listadoReservasDia()	// el operador ingresa la cancha y el día que quiere ver y se muestran por pantalla todas las reservas de ese día.-
			5:
				// SubProceso listadoReservasMes()	// el operador ingresa la cancha que desea visualizar y se muestra por pantalla las reservas del mes en curso para esa cancha solicitada.-
			6:
				// SubProceso horariosLibres()		// solicita al operador que ingrese un día y muestra los horarios libres para cualquiera de las dos canchas.-
			7:
				ingresoClave_VF=solicitaClave(password) // llamado a la función solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en línea Nº ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Autoriza cancelación de reserva.
					cancelaReserva(reservas, cantidad_diasMes, nombreMes) 		// SubProceso para cancelar una reserva (en línea Nº ....).
				SiNo
					// Clave incorrecta - No autoriza el ingreso al proceso de cancelación de reserva.-
					Limpiar Pantalla
					Escribir "************************************** ATENCIÓN ***************************************"
					Escribir "*        La clave ingresada no es la correcta, ingreso a la opción denegada           *"
					Escribir "***************************************************************************************"
					Escribir ""
					Escribir "Presione una tecla para continuar..."
					Esperar Tecla
				Fin Si
			8:
				ingresoClave_VF=solicitaClave(password)	// llamado a la función solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en línea Nº ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Permite salir del sistema de reservas.-
					banderaSalir=Verdadero
				SiNo
					// Clave incorrecta - No autoriza el ingreso al proceso de cancelación de reserva.-
					Limpiar Pantalla
					Escribir "************************************** ATENCIÓN ***************************************"
					Escribir "*        La clave ingresada no es la correcta, ingreso a la opción denegada           *"
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
	Escribir "Buenos días Sr. Supervisor."
	Escribir "Por favor ingrese la clave que utilizará para bloquear el acceso a los items restringidos del menú: " 
	Leer password
	Mientras Longitud(password)<6 Hacer
		Escribir "La clave de acceso es demasiado corta, debe tener como mínimo seis caracteres"
		Escribir "Por favor, vuelva a ingresar la clave: "
		Leer password
	Fin Mientras	
FinSubProceso

// *********************************************************************************************************************************************************************************************************************************

SubProceso ingresoMes(mes Por Referencia, nombreMes Por Referencia, cantidad_diasMes Por Referencia)	// SubProceso utilizado para solicitar al operador que ingrese el mes, validar y llamar a dos funciones
	// que asignan el nombre del mes seleccionado y la cantidad de días que le corresponden.-
	Leer mes
	Mientras mes<1 o mes>12 Hacer
		Escribir "El número ingresado no corresponde a ningún mes, por favor ingrese un número entre 1 y 12: "
		Leer mes
	Fin Mientras
	nombreMes=asignaNombreMes(mes)			// Función que devuelve el nombre del mes seleccionado por el operador (Función asignaNombreMes en línea Nº ... )
	cantidad_diasMes=asignaSegunMes(mes)	// Función que devuelve la cantidad de días que tiene el mes seleccionado por el operador (Función asignaSegunMes en línea Nº ... )
FinSubProceso

// *********************************************************************************************************************************************************************************************************************************

Funcion nombreM<-asignaNombreMes(mes)			// Función utilizada para devolver en la variable el nombre del mes sobre el cual se está trabajando
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

Funcion cant_dias<-asignaSegunMes(mes)		// esta función asigna la cantidad de días que le corresponden al mes seleccionado por el operador y lo devuelve en la variable que retorna esta función.-
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
	Definir i,j,k Como Entero																		// realizada en ese turno, por no estar "inicializado" con ningún valor el vector.-
	Para i=0 Hasta 1 Con Paso 1 Hacer											
		Para j=0 Hasta cantidad_diasMes-1 Con Paso 1 Hacer
			Para k=0 Hasta 11 Con Paso 1 Hacer
				reservas[i,j,k]=""
			Fin Para
		Fin Para
	Fin Para
FinSubProceso

// ********************************************************************************************************************************************************************************************************************************

Funcion ingresoVoF<-solicitaClave(password)			// Función utilizada para controlar el correcto ingreso de la clave. La función devuelve una variable lógica con Verdadero si fue correcta y Falso si no coincide con la clave.
	Definir claveingresada Como Caracter
	Definir ingresoVoF Como Logico
	Escribir "**********************************  A T E N C I O N  ************************************"
	Escribir "* Usted ha ingresado a una opción que compromete la integridad y seguridad de los datos *"
	Escribir "*          Para continuar deberá ingresar la clave de acceso del Supervisor             *"
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
	turno=""	// si esta variable permanece vacía al final del SubProceso significa que el operador no ingresó al bucle de selección del turno porque decidió no hacer la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opción posible del menú
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selección del DÍA hasta que seleccione un día válido
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selección del TURNO hasta que seleccione un turno(horario) válido.
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha que el usuario desea reservar (TECHADA o DESCUBIERTA), representado por el primer índice del vector reservas[cancha,dia,turno]
		Escribir "---------------------------------------------------------------------------------------" // se utiliza "-" en vez de "*" para diferenciar claramente a la vista del operador del
		Escribir "*                       Carga de Reserva de una cancha deportiva                      *" // sistema que ha ingresado a una opción del menú.- 
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el tipo de cancha que desea reservar: "
		Escribir "--------------------------------------------------------"
		Escribir "1. Cancha TECHADA"
		Escribir "2. Cancha DESCUBIERTA"
		Escribir "3. Salir (volver al menú principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese número ingresado no corresponde a ninguna opción del menú, las opciones son desde el número 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el número correspondiente a la opción del menú deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0			// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1			// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingresó la opción 3 del menú, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realizó la selección o eligió la opción 3 para salir, salgo del bucle de carga del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el día de la reserva / las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el usuario desea reservar, representado por el segundo índice del vector reservas[cancha,DIA,turno]
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el día del mes de ", nombreMes, " que desea reservar esa cancha ", cancha, ": "
		Escribir "----------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el número CERO vuelve al Menú Principal"		// la idea es que el operador pueda salir de la opción en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese número ingresado no corresponde a ningún día del mes de ", nombreMes, " , las opciones posibles son desde el número 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Menú Principal presione el número CERO."
				Escribir "Por favor, vuelva a ingresar el día que desea reservar esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realizó la selección del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// Día de la reserva seleccionada, paso a elegir el turno de la reserva (horario) / las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandonó la carga antes de esta opción, porque luego verifico en la línea 313 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el usuario desea reservar, representado por el último índice del vector reservas[cancha,dia,TURNO]
		eligeTurno("RESERVAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selección de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta función devuelve una variable con el nombre del turno según la selección del número de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la próxima intrucción del SubProceso debo preguntar si no eligió SALIR (Nº 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada.-
	
	// Si opcionDelMenu es distinto de 13 (no eligió Salir), entonces el operador ya cargó todos los datos.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligió la opción 13 de menú(Salir) y eligió un turno, por lo cual dentro del Si continúo con la carga de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posición del Vector reservas[CANCHA(en variable nro_cancha), DIA(variable en nro_dia-1), TURNO(en variable opcionDelMenu-1)]
		// Actualizo los valores del índice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del índice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1
		// Debería buscar esa posición en el vector para asegurarme que no se encuentre ocupada con una reserva! En ese caso informar al operador que ese turno se encuentra ocupado y vuelve al Menú Ppal.-
		// Si se encuentra libre la ocupo con ESTA RESERVA, preguntando antes el nombre de la persona que quiere reservar la cancha.-
		Si reservas[nro_cancha, nro_dia, nro_horario] == "" Entonces		// significa que no hay ninguna reserva realizada en ese turno para ese día y esa cancha.-
			// solicito datos de la reserva (nombre del usuario)
			Escribir "La reserva se encuentra disponible"
			Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " no se encuentra ocupada de ", turno
			Escribir "Por favor ingrese el nombre de la persona que reserva ese turno: "
			Leer nombre_usuario
			Mientras Longitud(nombre_usuario)<4 Hacer
				Escribir "El nombre ingresado tiene menos de cuatro caracteres"
				Escribir "Por favor, ingrese un nombre que pueda identificar más claramente a quien hizo la reserva"
				Leer nombre_usuario
			Fin Mientras
			reservas[nro_cancha, nro_dia, nro_horario]=Mayusculas(nombre_usuario)
			Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " de ", turno, " ha sido reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
		SiNo
			Escribir "¡ATENCION! - La reserva NO SE ENCUENTRA DISPONIBLE!"
			Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " de ", turno, " se encuentra reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Escribir "Sr.Operador, por favor, verifique los horarios disponibles, muchas gracias."
		Fin Si
		Escribir "Presione una tecla para continuar..."
		Esperar Tecla
	Fin Si
	// Fin del SubProceso de carga de reserva.-
Fin SubProceso

// **********************************************************************************************************************************************************************************************************************************

Funcion nombre_Turno<-nombreTurno(opcionDelMenu)	// esta función devuelve una variable con el nombre del turno según la selección del número de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
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
	turno=""	// si esta variable permanece vacía al final del SubProceso significa que el operador no ingresó al bucle de selección del turno porque decidió no buscar la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opción posible del menú.-
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selección del DÍA hasta que seleccione un día válido.-
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selección del TURNO hasta que seleccione un turno(horario) válido.-
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha sobre la cual el operador busca la reserva (TECHADA o DESCUBIERTA), representado por el primer índice del vector reservas[cancha,dia,turno]
		Escribir "---------------------------------------------------------------------------------------" // se utiliza "-" en vez de "*" para diferenciar claramente a la vista del operador del
		Escribir "*                  Búsqueda de una Reserva para una cancha deportiva                   *" // sistema que ha ingresado a una opción del menú.- 
		Escribir "---------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el tipo de cancha sobre la cual desea buscar una reserva: "
		Escribir "---------------------------------------------------------------------------"
		Escribir "1. Buscar una reserva en cancha TECHADA"
		Escribir "2. Buscar una reserva en cancha DESCUBIERTA"
		Escribir "3. Salir (volver al menú principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese número ingresado no corresponde a ninguna opción del menú, las opciones son desde el número 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el número correspondiente a la opción del menú deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0		// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1		// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingresó la opción 3 del menú, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realizó la selección o eligió la opción 3 para salir, salgo del bucle de bùsqueda del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el día de la reserva / las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el operador desea buscar, representado por el segundo índice del vector reservas[cancha,DIA,turno]
		Escribir "-------------------------------------------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el día del mes de ", nombreMes, " del cual desea buscar una reserva hecha para esa cancha ", cancha, ": "
		Escribir "-------------------------------------------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el número CERO vuelve al Menú Principal"		// la idea es que el operador pueda salir de la opción en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese número ingresado no corresponde a ningún día del mes de ", nombreMes, " , las opciones posibles son desde el número 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Menú Principal presione el número CERO."
				Escribir "Por favor, vuelva a ingresar el día que desea buscar la reserva en esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realizó la selección del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// Día de la reserva seleccionada, paso a elegir el turno de la reserva (horario) / las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandonó la búsqueda antes de esta opción, porque luego verifico en la línea 463 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el operador desea buscar, representado por el último índice del vector reservas[cancha,dia,TURNO]
		eligeTurno("BUSCAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selección de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta función devuelve una variable con el nombre del turno según la selección del número de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la próxima intrucción del SubProceso debo preguntar si no eligió SALIR (Nº 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada.-
	
	// Si opcionDelMenu es distinto de 13 (no eligió Salir), entonces el operador ya cargó los datos necesarios para realizar la búsqueda.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligió la opción 13 de menú(Salir) y eligió un turno, por lo cual dentro del Si continúo con la búsqueda de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posición del Vector reservas[CANCHA(en variable nro_cancha), DIA(en la variable nro_dia-1), TURNO(en la variable opcionDelMenu-1)]
		// Actualizo los valores del índice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del índice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1		// Debería buscar esa posición en el vector para pasar el dato a la variable que devuelve la Función ().-
		nomb_usuario=reservas[nro_cancha, nro_dia, nro_horario]
	Fin Si
	Si opcionDelMenu==13 o turno=="" Entonces
		nomb_usuario="OperadorAbandonaLaBúsqueda"
	Fin Si
FinFuncion

// ************************************************************************************************************************************************************************************************************************************

SubProceso cancelaReserva(reservas, cantidad_diasMes Por Valor, nombreMes Por Valor)
	Definir nomb_usuario Como Caracter
	Definir cancha, nombreDia, turno, nombre_usuario, confirmaCancelacion Como Caracter
	Definir banderaSalir, banderaSalir1, banderaSalir2 Como Logico
	Definir opcionDelMenu, nro_cancha, nro_dia, nro_horario Como Entero
	turno=""	// si esta variable permanece vacía al final del SubProceso significa que el operador no ingresó al bucle de selección del turno porque decidió no cancelar la reserva.-
	banderaSalir=Falso						// Utilizo una bandera (banderaSalir) para permanecer en el bucle de TIPO DE CANCHA hasta que seleccione una opción posible del menú.-
	banderaSalir1=Falso					// Utilizo una bandera (banderaSalir1) para permanecer en el bucle de selección del DÍA hasta que seleccione un día válido.-
	banderaSalir2=Falso					// Utilizo una bandera (banderaSalir2) para permanecer en el bucle de selección del TURNO hasta que seleccione un turno(horario) válido.-
	
	Mientras !banderaSalir Hacer			// Selecciona el tipo de cancha sobre la cual el operador busca la reserva (TECHADA o DESCUBIERTA), representado por el primer índice del vector reservas[cancha,dia,turno]
		Escribir "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\***/////////////////////////////////////////////" // se utiliza "\*/" para diferenciar claramente a la vista del operador del sistema el acceso a una 
		Escribir "*                  CANCELACION de una Reserva para una cancha deportiva                  *" 				// opción diferente del menú.- 
		Escribir "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\***/////////////////////////////////////////////"
		Escribir "Por favor, ingrese el tipo de cancha sobre la cual desea CANCELAR una reserva: "
		Escribir "------------------------------------------------------------------------------"
		Escribir "1. CANCELAR una reserva en cancha TECHADA"
		Escribir "2. CANCELAR una reserva en cancha DESCUBIERTA"
		Escribir "3. Salir (volver al menú principal)"
		Leer opcionDelMenu
		Mientras opcionDelMenu<1 o opcionDelMenu>3 Hacer
			Escribir "Ese número ingresado no corresponde a ninguna opción del menú, las opciones son desde el número 1 hasta el 3"
			Escribir "Por favor, vuelva a ingresar el número correspondiente a la opción del menú deseada: "
			Leer opcionDelMenu
		Fin Mientras
		Segun opcionDelMenu Hacer
			1:
				cancha="TECHADA"
				nro_cancha=0		// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			2:
				cancha="DESCUBIERTA"
				nro_cancha=1		// los índices del vector reservas van del 0 al 1 (son 2 canchas)
			De Otro Modo:						// el operador ingresó la opción 3 del menú, por lo cual coloco el resto de las banderas en Verdadero para no ingresar a sus bucles y salir del SubProceso.-
				banderaSalir1=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
				banderaSalir2=Verdadero		// coloco el resto de las banderas en Verdadero para volver al Menú Principal sin ingresar a los otros bucles.-
		Fin Segun
		banderaSalir=Verdadero			// Se realizó la selección o eligió la opción 3 para salir, salgo del bucle de bùsqueda del tipo de cancha (TECHADA/DESCUBIERTA)
	Fin Mientras
	// Tipo de cancha seleccionada, paso a elegir el día de la reserva / las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	Mientras !banderaSalir1 Hacer			// Selecciona el DIA del mes que el operador desea buscar, representado por el segundo índice del vector reservas[cancha,DIA,turno]
		Escribir "--------------------------------------------------------------------------------------------------------------------------"
		Escribir "Por favor, ingrese el día del mes de ", nombreMes, " del cual desea CANCELAR una reserva hecha para esa cancha ", cancha, ": "
		Escribir "--------------------------------------------------------------------------------------------------------------------------"
		Escribir "Sr. Operador, si ingresa el número CERO vuelve al Menú Principal"		// la idea es que el operador pueda salir de la opción en cualquier momento
		Leer nro_dia
		Si nro_dia==0 Entonces
			banderaSalir2=Verdadero		// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
		SiNo
			Mientras (nro_dia<0 o nro_dia>cantidad_diasMes) y !banderaSalir1 Hacer
				Escribir "Ese número ingresado no corresponde a ningún día del mes de ", nombreMes, " , las opciones posibles son desde el número 1 hasta el ", cantidad_diasMes
				Escribir "Si desea volver al Menú Principal presione el número CERO."
				Escribir "Por favor, vuelva a ingresar el día que desea CANCELAR una reserva de esa cancha ", cancha, ": "
				Leer nro_dia
				Si nro_dia==0 Entonces
					banderaSalir1=Verdadero
					banderaSalir2=Verdadero	// El operador ingresó un cero, coloco el resto de las banderas en Verdadero para no entrar en el otro bucle y volver al Menú Principal
				FinSi
			Fin Mientras
		Fin Si
		banderaSalir1=Verdadero		// Se realizó la selección del DIA o coloca cero, pongo la bandera en VERDADERO para salir del bucle.-
	Fin Mientras
	// Día de la reserva seleccionada, paso a elegir el turno de la reserva (horario) a CANCELAR/ las banderas condicionan la entrada al próximo bloque de carga o no, de acuerdo a si el operador eligio salir o no.-
	
	opcionDelMenu=0		// inicializo en cero opcionDelMenu por si el operador abandonó la CANCELACION antes de esta opción, porque luego verifico en la línea 463 "(Si opcionDelMenu<>13 y turno<>"" Entonces)"
	Mientras !banderaSalir2 Hacer			// Selecciona el TURNO (horario) que el operador desea CANCELAR, representado por el último índice del vector reservas[cancha,dia,TURNO]
		eligeTurno("CANCELAR", cancha, nro_dia, nombreMes, opcionDelMenu)	// SubProceso para la selección de un turno.-
		turno=nombreTurno(opcionDelMenu)	// esta función devuelve una variable con el nombre del turno según la selección del número de turno/horario (ej: si nro_horario=1 devuelve "10hs a 11hs")
		banderaSalir2=Verdadero		// coloco la bandera en Verdadero para salir del bucle, pero en la próxima intrucción del SubProceso debo preguntar si no eligió SALIR (Nº 13)
	Fin Mientras
	// TURNO (horario) de la reserva seleccionada que se desea CANCELAR.-
	
	// Si opcionDelMenu es distinto de 13 (no eligió Salir), entonces el operador ya cargó los datos necesarios para realizar la búsqueda de la reserva a CANCELAR.-
	Si opcionDelMenu<>13 y turno<>"" Entonces		// No eligió la opción 13 de menú(Salir) y eligió un turno, por lo cual dentro del Si continúo con la CANCELACION de la reserva.-
		// Ya tengo todos los datos necesarios para acceder a esa posición del Vector reservas[CANCHA(en variable nro_cancha), DIA(en la variable nro_dia-1), TURNO(en la variable opcionDelMenu-1)]
		// Actualizo los valores del índice nro_dia del vector (los valores del vector empiezan siempre en cero)
		nro_dia=nro_dia-1
		// Actualizo los valores del índice nro_horario del vector (los valores del vector empiezan siempre en cero y el horario lo tengo guardado en la variable opcionDelMenu-1)
		nro_horario=opcionDelMenu-1		// Debería buscar esa posición en el vector para pasar el dato a la variable que devuelve la Función ().-
		nomb_usuario=reservas[nro_cancha, nro_dia, nro_horario]
		Si reservas[nro_cancha, nro_dia, nro_horario]<>"" Entonces			// si esta pregunta devuelve Verdadero significa que la cancha está ocupada con una persona que reservó con anterioridad.-
			Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " de ", turno, " se encuentra reservada por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Escribir "Sr.Operador: ¿está seguro que desea CANCELAR esta reserva? (S=Si/N=No):"
			Leer confirmaCancelacion
			confirmaCancelacion=Mayusculas(confirmaCancelacion)
			Mientras confirmaCancelacion<>"S" Y confirmaCancelacion<>"N" Hacer
				Escribir "La letra ingresada debe ser S por SI o N por NO"
				Escribir "Por favor, confirme si realiza la cancelación de la reserva o no (S=Si/N=No): "
				Leer confirmaCancelacion
				confirmaCancelacion=Mayusculas(confirmaCancelacion)
			Fin Mientras
			Si confirmaCancelacion=="S" Entonces			// borro la reserva
				reservas[nro_cancha, nro_dia, nro_horario]=""
				Escribir "La CANCELACION del turno reservado ha sido exitosa"
			SiNo
				Escribir "La reseva no ha sido cancelada"
				Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " de ", turno, " CONTINUA ESTANDO RESERVADA por el Sr. ", reservas[nro_cancha, nro_dia, nro_horario]
			Fin Si
			Escribir "Presione una tecla para continuar..."
		SiNo
			Escribir "La cancha ", cancha, ", el día ", nro_dia+1, " de ", turno, " se encuentra LIBRE, por lo tanto no se puede cancelar ninguna reserva."
			Escribir "Por favor, verifique los datos ingresados y vuelva a ingresar, presione una tecla para continuar..."
		Fin Si
		Esperar Tecla
	Fin Si
	Si opcionDelMenu==13 o turno=="" Entonces
		Escribir "Sr.Operador, Usted ha decidido no realizar la cancelación de una reserva"
		Escribir "Presione una tecla para retornar al Menú Principal..."
		Esperar Tecla
	Fin Si
FinSubProceso

// *************************************************************************************************************************************************************************************************************************************

SubProceso eligeTurno(textoDelMsg, cancha por valor, nro_dia por valor, nombreMes por valor, opcionDelMenu Por Referencia)
	Escribir "--------------------------------------------------------------------------------------------------------------------------" 
	Escribir "Por favor, seleccione el turno correspondiente al horario que desea ", textoDelMsg, " para la cancha ", cancha, " del día ", nro_dia, " de ", nombreMes, ": "
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
	Escribir "13. Salir (volver al menú principal)"
	Leer opcionDelMenu
	Mientras opcionDelMenu<1 o opcionDelMenu>13 Hacer
		Escribir "Ese número ingresado no corresponde a ninguna opción del menú, las opciones son desde el número 1 hasta el 13"
		Escribir "Por favor, vuelva a ingresar el número correspondiente a la opción del menú deseada: "
		Leer opcionDelMenu
	Fin Mientras
FinSubProceso
