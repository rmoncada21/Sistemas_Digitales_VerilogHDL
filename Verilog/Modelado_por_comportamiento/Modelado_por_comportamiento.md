# Modelado por comportamiento

El modelado por comportamiento es una técnica que en lugar de especificar la estructura física de los circuitos, se enfoca en describir cómo debe comportarse el sistema utilizando construcciones de alto nivel como bloques **always** y declaraciones procedurales (**initial**).

## a. Procedimientos estructurales

### a.1 Declaración initial

En Verilog, los bloques initial **se utilizan para describir acciones que deben ejecutarse una vez al inicio de la simulación**. Estos bloques son esenciales para definir condiciones iniciales, realizar configuraciones iniciales o ejecutar secuencias de prueba en testbenches.

Si hay muchos bloques initial, todos se ejecutan de manera concurrente. Cada bloque initial debe contener de ser necesarrio las palabras claves **begin** y **end**. Si solo hay una instrucción en el bloque intial, estas palabras claves se pueden obviar. 

Los bloques **initial** son usados tipicamente para **inicializar, monitorear, generar formas onda (waveform)** y otros procesos que solo se requieran ejecutar una sola vez. Además de ser usados comunmente en los **testbenches** (bancos de prueba). 

Ejemplo

~~~verilog
// Inicialización de señales 
module ejemplo_initial;
    reg clk;
    reg reset;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;  // Desactiva el reset después de 10 unidades de tiempo
    end

    always #5 clk = ~clk;  // Genera un reloj de 10 unidades de tiempo
endmodule
~~~

### a.2 Declaración always

Las declaraciones **always** se utilizan para modelar el comportamiento de los sistemas digitales que dependen de eventos específicos, como cambios en las señales de reloj o de control. Estos bloques son fundamentales para describir la lógica secuencial y combinacional en un diseño de hardware.

- Se ejecutan en respuesta a eventos específicos listados en la **lista de sensibilidad** del bloque (@).

- Utilizados para modelar tanto la lógica secuencial (dependiente del reloj) como la combinacional (dependiente de señales de entrada).

- Soportan estructuras de control como if-else, case, for, while, y repeat.

**Sintáxis básicas:**
~~~verilog
always @(sensitivity_list) begin
    // Código a ejecutarse en respuesta a eventos en la lista de sensibilidad
end
~~~

#### a.2.1 Tipos de bloques always

1. **Logica Secuencial:**
Usualmente se desencadenan por el flanco de una señal de reloj (posedge o negedge).

    ~~~verilog
    always @(posedge clk) begin
        // Código secuencial que se ejecuta en el flanco positivo del reloj
    end
    ~~~

2. **Lógica combinacional:**
Usualmente se desencadenan por cambios en cualquier señal de la lista de sensibilidad.

    ~~~verilog
    always @(a or b or c) begin
    // Código combinacional que se ejecuta cuando cualquiera de las señales a, b, o c cambian
    end
    ~~~

    Alternativamente, se puede usar **`always @*`** para indicar que el bloque debe ejecutarse cuando cualquiera de las señales mencionadas dentro del bloque cambien.

    ~~~verilog
    always @* begin
    // Código combinacional
    end
    ~~~

## b. Asignaciones procedimentales 

Las asignaciones procedimentales en Verilog se utilizan dentro de bloques procedurales (always y initial) para actualizar los valores de las variables. Hay dos tipos principales de asignaciones procedimentales: bloqueantes (=) y no bloqueantes (<=). Entender la diferencia entre estos tipos de asignaciones es crucial para evitar errores en la simulación y síntesis de diseños digitales.

### b.1 Asignaciones bloqueantes "="

Las asignaciones bloqueantes se ejecutan secuencialmente dentro de un bloque procedural. Una vez que se realiza una asignación bloqueante, el siguiente paso en el bloque no se ejecuta hasta que la asignación se complete.

Características
- Se ejecutan de manera secuencial.
- **Son útiles para modelar lógica combinacional**.
- Pueden llevar a comportamientos inesperados en lógica secuencial si no se utilizan adecuadamente.

Ejemplo:

~~~verilog
always @* begin
    a = b;  // Asignación bloqueante
    c = a + 1;
end
~~~

En este ejemplo, `c` se asigna a `a + 1`, donde `a` se ha actualizado a `b` antes de la segunda asignación.

### b.2 Asignaciones NO bloqueantes "<="

Las asignaciones no bloqueantes permiten que todas las asignaciones dentro de un bloque procedural ocurran al mismo tiempo. **Son esenciales para describir correctamente la lógica secuencial.**

Características

- **Ejecutan de manera concurrente**.
- Son necesarias para modelar registros y lógica secuencial.
- Ayudan a evitar problemas de orden de ejecución en diseños secuenciales.

Ejemplo:

~~~verilog
always @(posedge clk) begin
    a <= b;  // Asignación no bloqueante
    c <= a + 1;
end
~~~

En este ejemplo, `c` se asignará a `a + 1` en el próximo ciclo de reloj, después de que `a` se haya actualizado con `b`.

## c.  Controles de tiempo

### c.1 Basado en Retardo/Delay

1. **Control de retardo regular**
    Es una forma de introducir retrasos específicos en el código de Verilog.

    ~~~verilog
    // parametros 
    parameter latency = 20;
    parameter delta = 2;
    reg x, y, z, p, q;

    initial 
    begin 
        x = 0; // sin control de delay 

        #10 y = 1; // control de delay con un numero, en este caso 10 unidades de tiempo

        #latency z = 0; // control delay usando identificadores

        #(latency + delta) p = 1; // control de delay usando expresiones. 

        #y x = x + 1; //control de delay, usando indentificadores 

        #(4:5:6) q = 0; // control de dalay usando(valor_minimo, valor_tipico, valor_maximo) 
    ~~~

2. **Control de retardo dentro assignaciones**
    ~~~verilog
    reg x, y, z;

    initial begin
        x = 0; z = 0;
        // Toma el valor de x y z en el tiempo 0, 
        // evalua x + y, espera 5 unidades de tiempo 
        // para asignar el valor a y
        y = #5 x + z;
    end

    // método equivalente

    initial begin
        x = 0; z = 0;
        temp_xz = x + z;
        #5 y = temp_xz;
        /*
            Toma el valor actual de x + z en la guarda en la variable temp_xz. Incluso cuando los valores de x y z puedan cambiar entre 0 y 5 unidades de tiempo, el valor asignado a y, en el tiempo 5, no cambia
        */
    end 
    ~~~

3. **Control de retardo zero**

    ~~~verilog
    initial begin
        x = 0;
        y = 0;
    end

    initial begin
        #0 x = 1;
        #0 y = 1;
    end
    ~~~

    Las 4 declaraciones se ejcutan en la simulación en el tiempo 0, pero como x = 0 1, y = 1, tienen #0, se ejecutará de último.

### c.2 Basado en Eventos

1. **Regular event control** 

    EL simbolo **@** se usa para especificar un control de evento. Las declaraciones/instrucciones en verilog se pueden ejecutar cuando ocurren cambios en los valores de la señal o en las transiciones negativas y positivas de la misma. La palabra clave **posedge** se usa para evaluar los cambios en transisciones positivas de la señal. La palabra clave **negedge**, para evaluar los cambios en la transición negativa.
    
    ~~~verilog
    @(clock) q = d; // se ejecutan cambios cuando la señal de reloj cambia de valor. (niveles de reloj)

    @(posedge clock) q = d; // se ejecutan cambios en las transiciones positivas del reloj
    
    @(negedge clock) q = d; // se ejecutan cambios en las transiciones 

    q = @(posedge clock) = d; // se evalúa d y se le aigna a q en el próximo flanco de reloj
    ~~~

2. **Named event control**

    Un **event** es un mecanismo que se utiliza para sincronizar procesos o partes de un diseño. Los eventos actúan como indicadores o señales que permiten a los bloques de código (como bloques initial o always) coordinarse entre sí. 

    **Trigger event** se refiere al proceso de activar un evento previamente definido

    ~~~verilog
    event recieved_data; // se define un evento llamado recieve_data;

    always @(posedge clock) begin
        if(last_data_packet)
            ->recieved_data // trigger/activar evento
    end

    always@(received_data) // se espera a que se active/triggering el evento
    ~~~

3. **Event or control**

    La palabra clave **or** se utiliza para especificar multiple **triggers/activaciones** en la lista de sensibilidad. 

    ~~~verilog
    always@(reset or clock or d) begin
        if(reset)
            q = 1'b;
        else if(clock)
            q = d;
    end
    ~~~

### c.3 Level-sensitive timing control 

El level-sensitive se refiere a la forma en que los bloques always responden a cambios en los niveles de señales. A diferencia del control de eventos basado en flancos (edge-sensitive), que reacciona a transiciones en las señales (como flancos ascendentes o descendentes), el control sensible al nivel responde a los niveles altos o bajos de las señales.

~~~verilog
always@(signal) begin
end
~~~

En siguiente bloque **always** indica que el bloque debe ejecutarse cada vez que cualquiera de las señales cambia (de nivel).

~~~verilog
always@(*) begin
    // código
end
~~~

## d. Instrucciones condicionales

Las instrucciones condicionales en Verilog permiten ejecutar diferentes bloques de código según ciertas condiciones.

~~~verilog
if (condición) begin
    // Código a ejecutar si la condición es verdadera
end else begin
    // Código a ejecutar si la condición es falsa
end
~~~

## e. Ramificación multidireccional (case)

### e.1 case

La instrucción case es ideal para seleccionar entre múltiples valores de una sola expresión. Es especialmente útil cuando se trabaja con señales que pueden tomar varios valores discretos, como en un multiplexor. 

Si la expresión y la alternativa tienen diferentes anchos, se llenan de zeros para hacer coincidir con el ancho de la expresion con la alternativa o viceversa. 

~~~verilog
case(expresion)
    alternativa1: instruccion1;
    alternativa2: instruccion2;
    alternativa3: instruccion3;
    .
    .
    .
    default: instruccion_default;
~~~


### e.2 casex, casez

- **casex:** La instrucción casex trata tanto los bits indefinidos (x) como los de alta impedancia (z) como "don't care" durante la comparación. Esto es más general que casez y puede ser útil cuando se desea ignorar tanto los bits indefinidos como los de alta impedancia.

- **casez:** La instrucción casez trata los bits de alta impedancia (z) como "don't care" durante la comparación. Esto es útil cuando se desea ignorar los bits de alta impedancia al comparar los valores. Recordar el valor **z** se puede representar con el signo **?**.

Ejemplo para el casex:
~~~verilog
always @(*) begin
    casez (sel)
        4'b10?1: y = a; // Coincide si sel es 1011 o 1001
        4'b11??: y = b; // Coincide si sel es 1100, 1101, 1110 o 1111
        default: y = c;
    endcase
end

~~~

Ejemplo para el
~~~verilog
always @(*) begin
    casez (sel)
        4'b10?1: y = a; // Coincide si sel es 1011 o 1001
        4'b11??: y = b; // Coincide si sel es 1100, 1101, 1110 o 1111
        default: y = c;
    endcase
end

~~~

## f. Loops

Los bucles (loops) se utilizan para repetir una secuencia de instrucciones múltiples veces. Aunque Verilog es un lenguaje de descripción de hardware (HDL) y no un lenguaje de programación tradicional, los bucles se pueden utilizar para describir ciertos patrones de hardware de manera compacta y eficiente.

### f.1 while 
Sintáxis:
~~~verilog
while (condición) begin
    // Código a ejecutar mientras la condición sea verdadera
end
~~~

Ejemplo:
~~~verilog
integer j;
reg [7:0] sum;

always @(*) begin
    sum = 0;
    j = 0;
    while (j < 16) begin
        sum = sum + j; // Sumar los valores de 0 a 15
        j = j + 1;
    end
end

~~~
### f.2 for
Sintáxis:
~~~verilog
for (inicialización; condición; actualización) begin
    // Código a ejecutar en cada iteración
end
~~~

Ejemplo:
~~~verilog
reg [7:0] array [0:15]; // Definir un arreglo de 16 elementos de 8 bits
integer i;

always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
        array[i] = i; // Asignar el índice del bucle al elemento del arreglo
    end
end
~~~

### f.3 repeat
Sintáxis:
~~~verilog
repeat (n) begin
    // Código a ejecutar n veces
end
~~~

Ejemplo:
~~~verilog
integer k;
reg [7:0] value;

always @(*) begin
    value = 8'b0;
    k = 0;
    repeat (8) begin
        value = value + 1; // Incrementar el valor 8 veces
        k = k + 1;
    end
end
~~~
### f.4 forever
Sintáxis:

~~~verilog
forever begin
    // Código a ejecutar infinitamente
end
~~~


Ejemplo:
~~~verilog
module testbench;
    reg clk;

    initial begin
        clk = 0; // Inicializar la señal de reloj
        forever begin
            #5 clk = ~clk; // Alternar el reloj cada 5 unidades de tiempo
        end
    end
endmodule
~~~
## g. Bloque secuenciales y paralelos 

### g.1 Tipos de bloques

1. **Bloques secuenciles**
Los bloques secuenciales (**begin ... end**) ejecutan las declaraciones dentro del bloque en orden secuencial, una después de la otra. Los bloques secuenciales se utilizan generalmente dentro de bloques **always**, **initial**, **task** y **function**.

    ~~~verilog
    begin
        // Declaraciones ejecutadas secuencialmente
        declaración1;
        declaración2;
        // ...
        declaraciónN;
    end
    ~~~
    Ejemplo:
    ~~~verilog
    always @(posedge clk) 
    begin
        a = b;       // Asignación 1
        c = a + 1;   // Asignación 2 (c toma el nuevo valor de a)
    end
    ~~~
2. **Bloques paralelos**
Los bloques paralelos (**fork ... join**) ejecutan las declaraciones dentro del bloque en paralelo, es decir, todas las declaraciones comienzan a ejecutarse simultáneamente. Los bloques paralelos se utilizan principalmente en contextos de simulación.

    ~~~verilog
    fork
        // Declaraciones ejecutadas en paralelo
        declaración1;
        declaración2;
        // ...
        declaraciónN;
    join
    ~~~
    Ejemplo:
    ~~~verilog
    initial begin
        fork
            #10 a = 1;  // Asignación 1
            #20 b = 2;  // Asignación 2
            #30 c = 3;  // Asignación 3
        join
    end
    ~~~

3. **Comparación y consideraciones en el uso de bloques secuenciales y paralelos**

**Uso en diseño de hardware:**
- Los bloques secuenciales (begin ... end) son fundamentales para la descripción del comportamiento secuencial, como el de los registros y las máquinas de estados.
    
- **Los bloques paralelos** (fork ... join) **no son sintetizables** y se utilizan únicamente en testbenches y contextos de simulación.

**Simulación y síntesis:**
- En síntesis, solo los bloques secuenciales se traducen a hardware real. Los bloques paralelos en el contexto de diseño de hardware podrían inducir a errores de lógica o interpretaciones incorrectas.
- En simulación, los bloques paralelos permiten modelar eventos que ocurren simultáneamente o de forma asincrónica.

### g.2 Caracteristicas especiales de los bloques

1. **Nested blocks**
Los bloques secuenciales y los paralelos pueden ser anidados/mezclados.

~~~verilog
initial begin
    x = 1'b0;
    fork
        #5 y = 1'b1;
        #10 z = {x, y};
    join
    #20 w = {y,x};
end
~~~
2. **Named blocks**

Los bloques pueden ser nombrados.

~~~verilog
module top;

initial begin: block1 // bloque secuencial llamada block 1
    integer i; // variables static y local a block1
    // se puede acceder a la variable con el nombre jerarquico top.block1.i
end
~~~

3. **Disabling named blocks**
La palabra clave **disable** se puede usar par terminar con la ejecución de un bloque. Disable se puede usar ademas para:
- salir de loops
- manejar condiciones de erro
- controlar ejecuciones de partes de código basados en un señal de control.

La instrucción **disable** es similar a la instrucción **break** del lenaguje C.

~~~verilog
// Illustration: Find the first bit with a value 1 in flag (vector variable)
reg [15:0] flag;
integer i; // integer to keep count

initial begin
    flag = 16'b0010_0000_0000_0000;
    i = 0;
    begin: block1 // The main block inside while is named block1
        while (i < 16) begin
            if (flag[i]) begin
                $display("Encountered a TRUE bit at element number %d", i);
                disable block1; // disable block1 because you found true bit.
            end
            i = i + 1;
        end
    end
end
~~~

## h. Ejemplos