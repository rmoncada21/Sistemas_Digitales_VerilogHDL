# Modulado de flujo de datos

##  Operdores básicos de verilog

![Imagen](img/operadores_basicos.png)


## Circuito HDL 4.3 Deccode 2x4 
![Imagen](img/decode2x4.png)

~~~ verilog
// Descripción de flujo de datos del decodificador de 2 a 4

module decode2x4 (A,B,E,D);
    input A ,B, E;
    output [0:3] D;
    assign D[0] = ~(~A & ~B & ~E),
           D[1] = ~(~A & B & ~E),
           D[2] = ~(A & ~B & ~E),
           D[3] = ~(A & B & ~E);
endmodule
~~~

El modulado deflujo de datos utiliza asignaciones continusa y la palabra clave assign.

- **assign**

Es un tipo de datos *net* que se utiliza para representar un aconexión fisica entre elementos del circuito.

Una net define una salida de compuerta declarada por un enunciado output o wire.

## Circuito HDL 4.5 Comparador de magnitud de bits  

~~~ verilog
// Descripción de flujo de datos de un comparador de 4 bits

module comparador4bits (A, B, ALTB, AGTB, AEQB);
    input [3:0] A, B;
    output ALTB, AGTB, AEQB;
    
    assign ALTB = (A<B),
           AGTB = (A>B), 
           AEQB = (A==B);
endmodule
~~~

- El módulo especifica dos entradas de cuatro bits, A y B, y tres salidas.
- La salida ALTB es 1 lógico si A es menor que B
- La salida AGTB es 1 lógico si A es mayor que B 
- La salida AEQB  es 1 lógico si A es igual que B

![Imagen](img/comparador4bits.png)

Un compilador de síntesis Verilog HDL puede aceptar como entrada esta descripción de módulo y producir la lista de un circuito equivalente a la figura.

## Circuito 4.6 MUltiplexor 2x1 (Modelado por flujo de datos)

> assign OUT = select ? A : B;

Especifica que la salida OUT = A, si select=1, caso contrario OUT =  o sea select=0.

![img](img/mux2x1.png)

~~~ verilog
module multiplexor2x1(A, B, select, OUT);
    input A, B, select;
    output OUT;
    
    assign OUT = select ? A:B;
    
endmodule
~~~

## Ej 4.7 y 4.8 en la carpeta "Modelado por comportamiento"

## Circuito 4.9 TESTBENCH
Con este tesbench se prueba el circuito modulo mux2x1.v. 

~~~Verilog
module testbench_mux2x1;
    // El tesbench no tiene puertos
    
    // La entradas del mux se declaran como reg
    reg TA, TB, TS;

    // las salidas como wire
    wire TY;

    // Se crea un ejemplo del mux bajo el nombre de uut
    multiplexor2x1 uut(TA, TB, TS, TY);
    
    
    // El bloque inicial especifica una sucesión de valores binarios que se aplicarán durante la simulación
    initial
        begin   
            TS = 1; TA = 0; TB = 1;
            #10
            TA = 1; TB = 0;
            #10
            TS = 0;
            #10
            TA = 0; TB = 1;
        end 
    // la respuesta de salida se verifica con la tarea del sistema $monitor
    initial 
        $monitor("select = %b A = %b B = %b OUT = %b time = %0d", TS, TA, TB, TY, $time);
endmodule
~~~