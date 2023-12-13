# Ejemplos del libro Morris Mano Capitulo 3

## Circuito Simple
Ej 3.1 pag 101
![Imagen](img/Ej_HDL_3-1_Circuito_Simple.png)

## Delay (circuitos con retardos)
Ej 3.2 pag 102
![Imagen](img/Ej_HDL_3-2.png)

## Testbench (para modulo delay.v)
Al simular un circuito con HDL, es necesario aplicar entradas al circuito para que el simulador genere una respuesta de salida.
El **tesbench** (banco de pruebas), busca generar distintos estimulos al diseño para ver como se comporta.
- Se incluyen dos modulos:
    Un modulo de estimulo y otr que genere el circuito. 

![Imagen](img/Ej_HDL_3-3.png)
Salida brindada por el libro
![Imagen](img/Ej_HDL_3-3_Salida.png)

Salida brindada según **gtkwave**
![Imagen](img/Ej_HDL_3-3_gtkwave.png)