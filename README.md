# Robot_EPSON

# Grupo 2

- Julian Leonardo Villalobos Jiménez - jlvillalovbosj@unal.edu.co
- Jhonathann Alexander Gómez Velásquez - jhagomezve@unal.edu.co

El presente repositorio tiene por objetivo dar a conocer el funcionamiento del brazo robótico Robot VT6L de la marca EPSON, en donde por medio de funciones y comandos que nos permitiran otorgarle movimientos deseados y precisos al robot se realicen actividades de un entorno industrial.

<p align="center">
  <img src="/Imágenes/BrazoRobotico.PNG" width="400" />
 <img src="/Imágenes/BrazoRoboticoUNAL.PNG" style="float:left;" />
</p>

## Solucion planteada

Para abordar el problema, se implementó la siguiente estrategia:

- <b>Diseño y fabricación del efector final:</b> Se diseñó y fabricó a medida un efector final que se acopla al robot para realizar los trazos deseados.
- <b>Planificación de las trayectorias:</b> Se definieron el logo y las iniciales como elementos para los cuales se generarían las trayectorias de movimiento.
- <b>Programación de movimientos:</b> Se utilizó RobotStudio para generar las trayectorias precisas que permitieran al robot escribir el logo y las iniciales.
- <b>Control del robot:</b> Mediante programación en RAPID, se implementaron las entradas y salidas digitales para controlar el robot durante la escritura.
- <b>Pruebas y validación final:</b> Se realizaron pruebas exhaustivas en el laboratorio con el robot real para garantizar que siguiera las trayectorias programadas con precisión y que la calidad de la escritura cumpliera los requisitos.

## Diagrama de flujo

El diagrama de flujo presentado se basa en las acciones seriales del brazo robótico con las respectivas restricciones o condiciones que se consideran necesarias para el propósito del robot

<p align="center">
  <img src="/Imágenes/Diagrama BrzoRobotico.drawio.png" width="400" />
</p>

## Plano de planta

Para controlar la distancias y los movimientos específicos de la herramienta en la base se diseñó una guía basada en una simulación en inventor en donde se dibujo las letras y el simbolo de tesla como referencia para crear los targets del brazo robótico, por otro lado se hizo un esquema de la hoja como referencia para establecer el tamaño de las letras y del logo.

<p align="center">
  <img src="/Imágenes/Base.PNG" style="width: 45%; height: auto;" />
 <img src="/Imágenes/VistaGeneralPlanta.PNG" style="width: 45%; height: auto;" />
</p>

Al ingresar la base de trabajo a Robot Studio se estqablecio una distancia desde la base del robot a la del workspace de 50 centímetros, con el fin de no forzar los movimientos del brazo robótico, igualmente se adapto la base a la misma distancia del piso establecido por el simulador con un ángulo de inclinación de 45° con respecto a este.

<p align="center">
  <img src="/Imágenes/CuadroPosicion.PNG"/>
 <img src="/Imágenes/VistaLateralPlanta.PNG" style="width: 45%; height: auto;" />
</p>

## Funciones utilizadas

Para realizar el código se hizo uso de algunas funciones internas de robotStudio las cuales nos permitian posicionar los diferentes estados de la herramienta, los movimientos entre las posiciones, y los comandos lógicos para establecer acciones controladas por el usuario, entre estas funciones encontramos:

- **CONST robtarget NOMBRE_DEL_TARGET:=[[x,y,z],[q1,q2,q3,q4],[cf1,cf4,cf6,cf7],[v1,v2,v3,v4,v5,v6]];**

  El robottarget nos ayuda a establecer los puntos en el espacio donde se va a posicionar el TCP y la orientacion que esta va a tener en ese punto

  - x, y, z Representan las coordenadas del punto de destino en el espacio cartesiano con referencia al punto origen donde esta posicionado el brazo robótico.
  - q1, q2, q3, q4 son los valores de orientación en cuaternión (representación de la orientación en el espacio 3D).
  - cf1, cf4, cf6, cf7 son los valores de configuración de herramienta para especificar los cuadrantes en los que se va a trabajar, es importante que las diferentes posiciones trabajen en los mismos cuadrantes para no presentar errores en la translacion y rotacion de puntos.
  - v1, v2, v3, v4, v5, v6 son las velocidades máximas permitidas para cada eje.

- **PERS tooldata NombreHerramienta:=[<UsarHerramienta>,[[X,Y,Z],[Q1,Q2,Q3,Q4]],[TamañoHerramienta,[Xt,Yt,Zt],[Q1t,Q2t,Q3t,Q4t],CargaUtil,PesoHerramienta,GravedadX,GravedadY,GravedadZ]];**

  Este nos ayuda a especificar el objeto que se interpreta como la herramiena en donde se va a establecer el TCP, como vemos algunos parámetros coinciden con la función del _robtarget_ por lo que se interpretan con las mismas propiedades.

  - _UsarHerramienta_ nos indica que este objeto se va a usar como herramienta
  - TamañoHerramienta es un número que representa el tamaño de la herramienta.
  - Xt, Yt, Zt son las coordenadas del punto de herramienta con respecto al centro de gravedad de la herramienta.
  - Q1t, Q2t, Q3t, Q4t son los componentes del cuaternión que representa la orientación de la herramienta con respecto al centro de gravedad.
  - CargaUtil es la carga útil de la herramienta.
  -

- **MoveL Destino, Velocidad, Acceleración, z0, Tool, WObj;**

  La función _MoveL_ nos permite deplazar el TCP en una linea recta del efector final hasta un punto específico

- **MoveJ Destino, Velocidad, Acceleración, z0, Tool, WObj;**

  La función _MoveJ_ nos permite deplazar el TCP hasta un punto específico de tal forma que el sistema no comprometa las articulaciones, por lo que el efector final puede hacer una curva en el espacio hasta llegar a la posición requerida

  - Destino: Punto de destino al que se desea que el robot se mueva.
  - Velocidad: Velocidad de movimiento del robot en mm/s.
  - z0: Nos indica el porcentaje de error en un radio alrededor del punto que la herramienta va a tener cuando pase por este,
    entre mas pequeño el valor mas cerca va a estar del punto
  - Tool: Herramienta aque se va a usar para ejercer la acción
  - WObj: Sistema de coordenadas de trabajo (normalmente el sistema de coordenadas de la estación base o una pieza de trabajo).

- **Reset Nombre_Salida;**

  Nos ayuda a poner en una posición inicial "0" el valor de la salida, en este caso se usa para apagar un led del tablero de control.

- **Set Nombre_Salida;**

  Nos ayuda a poner en una posición "1" el valor de la salida, en este caso se usa para prender un led del tablero de control.

- **WaitDI Nombre_Entrada;**

  Nos ayuda a pausar el codigo en esta linea hasta presentar una señal de entrada, en este caso procedentes en un botón del tablero de control.

  En el presente [enlace](RobotStudio_Guias/Rapid_instructions.pdf), puede encontrar algunas guías de las funciones internas de RAPID y de robotStudio

## Herramienta

La herramienta se diseñó siguiendo las especificaciones del fabricante del robot para la base. Se le asignó un ángulo de inclinación de 45 grados para reducir la probabilidad de que se generaran singularidades en las trayectorias del robot. Su longitud se determinó para sujetar a presión el marcador utilizado. Asimismo, se dejó espacio en la base del marcador para la ubicación de un resorte que protege la herramienta y optimiza el resultado al momento de realizar la escritura. Por último se realizó la manufactura aditiva de la pieza considerando las tolerancias dimensionales de este tipo de manufactura.

<p align="center">
  <img src="/Imágenes/Tool1.PNG" width="400" />
  <img src="/Imágenes/Herramienta.PNG" width="400" />
</p>

<p align="center">
  <img src="/Imágenes/PenToolPlano.PNG" width="800" />
</p>

## [Código en RAPID](/LogoTesla/ControllerData/IRB140_6_81/RAPID/TASK1/PROGMOD/Module1.mod)

Para el diseño del código se inició crando una herramienta la cual me ayudaba como referencia para modificar el TCP en donde se establece como punto de referencia la punta del marcador ubicado sobre esta misma, esta se ajustó de modo que el eje Z se muestre en paralelo a la dirección del largo de la herramienta con el fin de asegurar que al ubicar de forma perpendicular el eje Z al plano, del mismo modo el marcador se iba a comportar

<p align="center">
  <img src="/Imágenes/CreacionHerramienta.PNG" />
 <img src="/Imágenes/TCP.PNG" style="width: 45%; height: auto;" />
</p>

Se procedio a establecer los diferentes _Targets_ por donde se espera pasar el marcador, entre estos inicialmente se ubicaron el punto de mantenimiento _Target_Operator_ en donde se hace el ajuste de la herramienta, la posicion de origen o inicial _Posicion_Inicial_ en donde se ubica la esquina superior derecha de la hoja como su work object y finalmente el punto home del proyecto _HOME_, en el cual se posiciona el robot cada que va a hacer un cambio de esquema y en donde va a terminar cuando culmine el programa.
Por otro lado se diseñaron los _Targets_ para los puntos sobre la superfuicie en cada una de las letras y del logo, estas se representaron como _Target(Letra que se va a dibujar)\_(Numero de punto en la letra)_.

<p align="center">
  <img src="/Imágenes/EncabezadoCódigo.PNG" />
</p>

A continuación se diseñaron diferentes funciones para el path de cada una de las letras y del logo de tesla con el fin de facilitar detectar errores en el recorrido del código y especificar condiciones detalladas en cada una de las letras y símbolos, tales como velocidad de recorridos en paths específicos, niveles de precisión en algunos targets y tiempos de espera, es importante aclarar que al final de cada función el marcador pasa nuevamente por el target inicial de la letra para finalmente ir al _HOME_ del proyecto.

<p align="center">
  <img src="/Imágenes/Paths.PNG" />
</p>

Finalmente para el diseño de la función principal _main()_ se inició apagando todas las salidas del sistema con el objetico que el dispositivo se encontrara en un estado conocido cuando se empezara a manipular, se procedio a pausar el código hasta presentar una señal de entrada para iniciar el recorrido al estado de mantenimiento y a activar la salida del led1. Una vez hecho el ajuste de mantenimiento el codigo se pausa nuevamente hasta presentar otra señal de entrada la cual le permite llegar a la posición origen de la hoja apagando el led1 y dadole salida al led 2, finalmente al ingresar una tercera señal de entrada el sistema apaga el led 2 y activa el led 3 el cual nos indica que se esta realiazndo el dibujo, en este caso se pasa por cada una de las funciones (letras) para finalmente ubicar el marcador en la posición _HOME_ del proyecto.

<p align="center">
  <img src="/Imágenes/Main.PNG" />
</p>

Para acceder al código puede seleccionar el subtítuo de esta sección "Código RAPID" o darle clic [aquí](/LogoTesla/ControllerData/IRB140_6_81/RAPID/TASK1/PROGMOD/Module1.mod)

## Videos de pruebas de funcionamiento

Simulación
https://github.com/jlvillalobosj/RobotABB-Logo/assets/57506705/320bad9b-4126-4240-a565-06e80536f104

Prueba Real
https://github.com/jlvillalobosj/RobotABB-Logo/assets/57506705/acefa244-26ae-4086-ad4b-36ae096dd5aa
