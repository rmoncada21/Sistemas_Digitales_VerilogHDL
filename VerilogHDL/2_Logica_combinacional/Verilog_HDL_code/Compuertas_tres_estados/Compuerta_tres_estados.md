# Compuertas de 3 estados

## Compuerta bufif1 
- Se comporta como un búfer normal, si control=1
- La salida pasa a un estado de alta impedancia z cuando control=0

>    bufif1 (OUT, A, control);

La entrada A se tranfiere a OUT cuando control=1
y OUT pasa a Z cuando control=0

## Compuerta bufif0
- Se comporta normal cuando el control=0
- Se comporta como alta impedancia cuando control =1


![Imagen](img/3_estados.png)

>    notif0 (Y, B, enable);

La salida Y = z cuando enable=1 y Y = B cuando enable = 0.

## Mux 2x1 con compuertas tres estados

![Imagen](img/tri_mux2x1.png)


## Tipos de datos net

La palabra net no es una palabra clave, pero representa una clase de tipos de datos como: 
- wire: cableado 
- wor: modela la implementacion en hardware de la configuracion OR alambrada
- wand: modela la configuracion AND alambrada
- tri: tercer estado
- supply1: representa fuentes de poder 
- supply0: representa la tierra