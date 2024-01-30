# Circuitos Secuenciales/ Registros y Contadores

## Registros

### Ejemplos 6.1 Registro de desplazamiento Universal
![img](img/registro_desp_universal.png)
![img](img/registro_desp_universal_tabla.png)

## Contadores

###


## Extras (Ejemplos de otras secciones)

### Registro Simple de 4 bits (con FFD)
![img](img/register_simple_FFD_4bits.png)

### Registro simple con carga paralela de 4 bits
~~~verilog
// An(t+1) =  Sum(3,4,5,7) = Carga*In + A*~Carga
// ----------------------------------------------
// An(t) Carga  In | An(t+1)
// --------------- |--------
//   0    0     0  |   0
//   0    0     1  |   0
//   0    1     0  |   0
//   0    1     1  |   1
//   1    0     0  |   1
//   1    0     1  |   1
//   1    1     0  |   0
//   1    1     1  |   1 
~~~
![img](img/register_parallel_load_4bits_bloque_1.png)

![img](img/register_parallel_load_4bits.png)s


### Registro de desplamaiento en serie de 4 bits
![img](img/register_serie.png)