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
	// 		2. B�squeda de reserva (por d�a-horario) = Funci�n busquedaReservaDia()
	// 		3. B�squeda de reserva (por nombre) = Funci�n busquedaReservaNombre()
	// 		4. Listado de reservas del d�a = SubProceso listadoReservasDia()
	// 		5. Listado de reservas del mes = SubProceso listadoReservasMes()
	// 		6. Listado de horarios disponibles para reservar la cancha en un d�a determinado = SubProceso horariosLibres()
	// 		7. Cancelaci�n de reserva = Funci�n cancelaReserva()
	// 		8. Salir
	//	Y de acuerdo a la opci�n seleccionada:
	// 		1. La carga de reservas consistir� en ingresar un turno al vector reservas[dia,turno].-
	// 		2. La busqueda consistir� en buscar en el vector reservas[dia,turno] el dia-horario reservado.-
	// 		3. La b�squeda por nombre consistir� justamente en buscar ese nombre con el que se reserv� la cancha en el vector reservas[dia,turno].-
	// 		4. Mostrar� por pantalla todas las reservas del d�a solicitado.-
	// 		5. Mostrar� por pantalla todas las reservas realizadas en el mes.-
	// 		6. Mostrar� por pantalla todos los horarios disponibles para reservar la cancha en un d�a determinado.-
	// 		7. En esta opci�n el administrador del sistema podr� borrar una reserva previamente hecha.-
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
	
	Definir reservas, password, nombreMes Como Caracter
	Definir i, j, mes, cantidad_diasMes, opcionDelMenu Como Entero
	Definir banderaSalir, ingresoClave_VF Como Logico
	mes=0
	cantidad_diasMes=0
	nombreMes=""
	password=""
	banderaSalir=Falso
	ingresoClave_VF=Falso
	
	claveAcceso(password)				// llamado al SubProceso claveAcceso para el ingreso de la clave de bloqueo para cancelaciones y salida del sistema (SubProceso claveAcceso en l�nea N� ... )
	
	Escribir "Para inicializar el sistema, por favor ingrese n�mero de mes donde realizar� las reservas de la cancha: "
	ingresoMes(mes, nombreMes, cantidad_diasMes)	// llamado al SubProceso ingresoMes, donde solicita el n�mero de mes y asigna por referencia el nombre de ese mes espec�fico (SubProceso en l�nea N� ... )
	
	Dimension reservas[2, cantidad_diasMes, 12]
	
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
		Escribir "6. Listado de horarios disponibles para reservar la cancha en un d�a determinado."
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
			2:
				// Funci�n busquedaReservaDia()		// el programa solicita el d�a y horario que desea ver y se muestra por pantalla si se encuentra libre o no (si est� ocupado muestra el nombre de la reserva).-
			3:
				// Funci�n busquedaReservaNombre()	// el operador ingresa el nombre de la reserva y el programa mostrar� por pantalla todas las reservas con ese nombre.-
			4:
				// SubProceso listadoReservasDia()	// el operador ingresa el d�a que quiere ver y se muestran por pantalla todas las reservas de ese d�a.
			5:
				// SubProceso listadoReservasMes()	// muestra por pantalla las reservas del mes en curso.-
			6:
				// SubProceso horariosLibres()		// solicita al operador que ingrese un d�a y muestra los horarios libres para ese d�a ingresado.-
			7:
				ingresoClave_VF=solicitaClave(password) // llamado a la funci�n solicitaClave() que devuelve el valor Verdadero si ingreso correctamente la clave y Falso si fue incorrecta (en l�nea N� ...)
				Si ingresoClave_VF Entonces
					// Clave correcta - Autoriza cancelaci�n de reserva.
					// cancelaReserva() 								Funci�n para cancelar una reserva (en l�nea N� ....).
					Escribir "Debo hacer la funci�n cancelaReserva()"
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
Escribir "* Paula Molina."
Escribir "* Gianluca Marconi Favini"
Escribir "* Enrique Marconi Favini"
FinProceso

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

SubProceso ingresoMes(mes Por Referencia, nombreMes Por Referencia, cantidad_diasMes Por Referencia)
	Leer mes
	Mientras mes<1 o mes>12 Hacer
		Escribir "El n�mero ingresado no corresponde a ning�n mes, por favor ingrese un n�mero entre 1 y 12: "
		Leer mes
	Fin Mientras
	nombreMes=asignaNombreMes(mes)			// Funci�n que devuelve el nombre del mes seleccionado por el operador (Funci�n asignaNombreMes en l�nea N� ... )
	cantidad_diasMes=asignaSegunMes(mes)	// Funci�n que devuelve la cantidad de d�as que tiene el mes seleccionado por el operador (Funci�n asignaSegunMes en l�nea N� ... )
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


