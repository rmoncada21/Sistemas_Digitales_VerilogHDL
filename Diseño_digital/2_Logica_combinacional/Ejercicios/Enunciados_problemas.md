# Problemas pag 161

MC:  Modelado por comportamiento
MNC: Modelado nivel de compuertas
MFD: Modelado de flujo de datos

## 4.1 Considere el circuito combinacional de la figura P4-1.

- a) Deduzca las expresiones booleanas para T1 a T4. Evalúe las salidas F1 y F2 en función de las
cuatro entradas.

- b) Escriba la tabla de verdad con 16 combinaciones binarias de las cuatro variables de entrada. Luego dé en la tabla los valores binarios de T1 a T4 y las salidas F1 y F2.

- c) Grafique en mapas las funciones booleanas de salida obtenidas en la parte b) y demuestre que las expresiones booleanas simplificadas son equivalentes a las obtenidas en la parte a).

![Img](img/1.png)

## 4.2 Obtenga las expresiones booleanas simplificadas para las salidas F y G en términos de las variables de entrada del circuito de la figura P4-2.

![Img](img/2.png)

### Funciones del circuito:
- F = (A'D+A)(A'+BC)
- G = (A'+BC)(D´+A)

### Funciones simplificadas con propiedades del algebra booleana:
- F = A'D + BC + ABC
- G = A'D + BCD' +ABC


## 4.3 Para el circuito de la figura
- a) Escriba las funciones booleanas de las cuatro salidas en función de las variables de entrada.
- b) Si el circuito se presenta como tabla de verdad, ¿cuántas filas y columnas tendría la tabla?

![img](img/3.png)

## 4.4 Diseño
Diseñar un circuito combinacional con tres entradas y una salida. La salida es 1 cuando el valor binario de las entradas es menos que 3, y es 0 en los demás casos.

![img](img/4.png)

## 4.5 Diseño
Diseñe un circuito combinacional con tres entradas, x, y y z, y tres salidas, A, B y C. Cuando la entrada binaria es 0, 1, 2 o 3, la salida binaria es uno más que la entrada. Si la entrada binaria es 4, 5, 6 o 7, la salida binaria es uno menos que la entrada.

Circuito diseñado
![img](img/5.png)


Circuito diseñado CORREGIDO
![img](img/5_corregido.png)

## 4.6 Diseño Circuito Mayoria 
Un circuito de mayoría es un circuito combinacional cuya salida es 1 si las variables de entrada
tienen más unos que ceros. La salida es 0 en caso contrario. Diseñe un circuito de mayoría de tres
entradas.

![img](img/6.png)

## 4.7 COnvertir código gray en código binario
Diseñe un circuito combinacional que convierta un código Gray de cuatro bits (tabla 1-6) en un número binario de cuatro bits. Implemente el circuito con compuertas OR exclusivo.

![img](img/7_gray.png)

![img](img/7.png)

![img](img/7_corregido.png)

## 4.8 Diseño Conversor
Diseñe un convertidor de código que convierta un dígito decimal del código 8, 4, 22, 21 a BCD

![img](img/8.png)


![img](img/8_circuito.png)

- Correción en la compuerta and 5
![img](img/8_correcion.png)

## 4.9 Diseño
Un decodificador de BCD a siete segmentos es un circuito combinacional que convierte un dígito decimal BCD en un código apropiado para seleccionar segmentos de un indicador que exhibe los dígitos decimales en la forma acostumbrada. Las siete salidas del decodificador (a, b, c, d, e, f, g) seleccionan los segmentos correspondientes del indicador, como se indica en la figura P4-9a). La forma de representar los dígitos decimales con el indicador se muestra en la figura P4-9b). Diseñe un decodificador de BCD a siete segmentos empleando el mínimo de compuertas. Las seis combinaciones no válidas deberán dejar el indicador en blanco.

![img](img/9_figura.png)
![img](img/9_circuito.png)

## 4.10 Complemento a 2
Diseñe un circuito combinacional complementador a dos, de cuatro bits. (La salida genera el complemento a dos del número binario de entrada.) Demuestre que es posible construir el circuito con compuertas OR exclusivo.

![img](img/10.png)

## 4-11 Incrementador de cuatro bits
Diseñar un circuito combinacional incrementador de cuatro bits. (Un circuito que suma 1 a un número binario de cuatro bits.) El circuito puede diseñarse con cuatro semisumadores.

![img](img/11_sumador.png)
![img](img/11_sumador_4bits.png)

## 4-12 Circuito Restador
a) Diseñe un circuito semirrestador con entradas x y y, y salidas D y B. El circuito resta los bits
x-y, y coloca la diferencia en D y el préstamo (borrow) en B.
b) Diseñe un circuito restador completo con tres entradas, x, y y z, y dos salidas, D y B. El circuito resta x-y-z, donde z es el préstamo de entrada, B es el préstamo de salida y D es
la diferencia.
![img](img/12_semirestador.png)
![img](img/12_restador_completo.png)
![img](img/12_restador_4bits.png)


## 4.19 Diagrama de bloques

Construya un circuito sumador-restador BCD. Utilice el sumador BCD de la figura 4-14 y el complementador a nueve del problema 4-18. Utilice diagramas de bloque para los componentes.

- a) Circuito Sumador (Del dej ercicio 4.11)
![img](img/11_sumador.png   )
![img](img/11_sumador_4bits.png)

- b) Circuito Sumador BCD
![img](img/19_sumador_BCD_4bits.png)
![img](img/19_bloque_sumador_BCD_4bits.png)

- c) Complementor a 9 BCD 

![img](img/19_complemento_a_9.png)
![img](img/19_bloque_complemento_a_9.png)

- d) Mux 4x1 
![img](img/19_mux_4x1.png)
![img](img/19_bloque_mux_4x1.png)

- e) Sumador-restador BCD
![img](img/19_bloque_sumador_restado_completo.png)
Dividido en dos (Ver cual se ve mejor)
![img](img/19_bloque_sumador_restado_completo_1.png)
![img](img/19_bloque_sumador_restado_completo_2.png)

## 4.20 Multiplicador
Diseñe un multiplicador binario que multiplique dos números de cuatro bits. Utilice compuertas AND y sumadores binarios.

![img](img/20_multiplicador_4x1bit.png)
![img](img/20_bloque_multiplicador_4x1bit.png)

![img](img/20_multiplicador_parte1.png)
![img](img/20_multiplicador_parte2.png)
![img](img/20_bloque_multiplicador.png)