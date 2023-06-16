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
	// 		2. Búsqueda de reserva (por día-horario) = Función busquedaReservaDia()
	// 		3. Búsqueda de reserva (por nombre) = Función busquedaReservaNombre()
	// 		4. Listado de reservas del día = SubProceso listadoReservasDia()
	// 		5. Listado de reservas del mes = SubProceso listadoReservasMes()
	// 		6. Listado de horarios disponibles para reservar la cancha en un día determinado = SubProceso horariosLibres()
	// 		7. Cancelación de reserva = Función cancelaReserva()
	// 		8. Salir
	//	Y de acuerdo a la opción seleccionada:
	// 		1. La carga de reservas consistirá en ingresar un turno al vector reservas[dia,turno].-
	// 		2. La busqueda consistirá en buscar en el vector reservas[dia,turno] el dia-horario reservado.-
	// 		3. La búsqueda por nombre consistirá justamente en buscar ese nombre con el que se reservó la cancha en el vector reservas[dia,turno].-
	// 		4. Mostrará por pantalla todas las reservas del día solicitado.-
	// 		5. Mostrará por pantalla todas las reservas realizadas en el mes.-
	// 		6. Mostrará por pantalla todos los horarios disponibles para reservar la cancha en un día determinado.-
	// 		7. En esta opción el administrador del sistema podrá borrar una reserva previamente hecha.-
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
	
	Definir reservas, password, nombreMes Como Caracter
	Definir i, j, mes, cantidad_diasMes, opcionDelMenu Como Entero
	Definir banderaSalir, ingresoClave_VF Como Logico
	mes=0
	cantidad_diasMes=0
	nombreMes=""
	password=""
	banderaSalir=Falso
	ingresoClave_VF=Falso
	
	claveAcceso(password)				// llamado al SubProceso claveAcceso para el ingreso de la clave de bloqueo para cancelaciones y salida del sistema (SubProceso claveAcceso en línea Nº ... )
	
	Escribir "Para inicializar el sistema, por favor ingrese número de mes donde realizará las reservas de la cancha: "
	ingresoMes(mes, nombreMes, cantidad_diasMes)	// llamado al SubProceso ingresoMes, donde solicita el número de mes y asigna por referencia el nombre de ese mes específico (SubProceso en línea Nº ... )
	
	Dimension reservas[2, cantidad_diasMes, 12]
	
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
		Escribir "6. Listado de horarios disponibles para reservar la cancha en un día determinado."
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
			2:
				// Función busquedaReservaDia()		// el programa solicita el día y horario que desea ver y se muestra por pantalla si se encuentra libre o no (si está ocupado muestra el nombre de la reserva).-
			3:
				// Función busquedaReservaNombre()	// el operador ingresa el nombre de la reserva y el programa mostrará por pantalla todas las reservas con ese nombre.-
			4:
				// SubProceso listadoReservasDia()	// el operador ingresa el día que quiere ver y se muestran por pantalla todas las reservas de ese día.
			5:
				// SubProceso listadoReservasMes()	// muestra por pantalla las reservas del mes en curso.-
			6:
				// SubProceso horariosLibres()		// solicita al operador que ingrese un día y muestra los horarios libres para ese día ingresado.-
			7:
				ingresoClave_VF=solicitaClave(password) // llamado a la función solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en línea Nº ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Autoriza cancelación de reserva.
					// cancelaReserva() 								Función para cancelar una reserva (en línea Nº ....).
					Escribir "Debo hacer la función cancelaReserva()"
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
Escribir "* Paula Molina."
Escribir "* Gianluca Marconi Favini"
Escribir "* Enrique Marconi Favini"
FinProceso

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

SubProceso ingresoMes(mes Por Referencia, nombreMes Por Referencia, cantidad_diasMes Por Referencia)
	Leer mes
	Mientras mes<1 o mes>12 Hacer
		Escribir "El número ingresado no corresponde a ningún mes, por favor ingrese un número entre 1 y 12: "
		Leer mes
	Fin Mientras
	nombreMes=asignaNombreMes(mes)			// Función que devuelve el nombre del mes seleccionado por el operador (Función asignaNombreMes en línea Nº ... )
	cantidad_diasMes=asignaSegunMes(mes)	// Función que devuelve la cantidad de días que tiene el mes seleccionado por el operador (Función asignaSegunMes en línea Nº ... )
FinSubProceso

Funcion nombreM<-asignaNombreMes(mes)
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

Funcion cant_dias<-asignaSegunMes(mes)
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

Funcion ingresoVoF<-solicitaClave(password)
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


