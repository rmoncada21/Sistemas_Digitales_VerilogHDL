# Bloques procedurales - task - functions

El lenguaje **Verilog** proporiona un bloque procedimental de proposito general, llamado **always**, que se utiliza para modelar una varieda de tipos de hardware, asi como rutinas de verificación. 

**SystemVerilog** extiende Verilog al añadir bloques procedimentales específicos para tipos de hardware que indican claramente la intención del diseñador. Tales bloques son: 
- **`always_comb`** (combinacional)
- **`always_latch`** (latch-retención)
- **`always_ff`** (flips flops)

## a. Verilog - always: bloque procedimental de proposito general

El bloque procedimental always de Verilog es un bucle infinito que ejecuta repetidamente las instrucciones dentro del bucle. Para que el tiempo de simulación avance, el bucle debe contener algún tipo de control de tiempo o control de eventos. 

El ejemplo es sintácticamente correcto, pero no sigue las directrices adecuadas de modelado para la síntesis.

~~~verilog
always begin
    wait (resetN == 0) // level-sensitive delay
    @(negedge clock) // edge-sensitive delay
        #2 t <= d;  // time-based delay
    @(posedge clock)
        #1.5 q <= t;
end
~~~

**1. Lista de sensibilidad**

Una lista de sensibilidad especifica las señales que activan la evaluación de un bloque always. Esto es crucial para la síntesis y simulación de circuitos digitales,
ya que define cuándo se debe reevaluar la lógica dentro del bloque always

- **Lista de Sensibilidad Combinacional**: Se utiliza para describir lógica combinacional, donde el bloque `always` se activa cada vez que cambia cualquiera de las señales en la lista de sensibilidad.

   ```verilog
   always @(a or b or c) begin
       y = a & b | c;
   end
   ```

   Aquí, `y` se recalcula cada vez que `a`, `b`, o `c` cambian.

- **Lista de Sensibilidad Secuencial**: Se utiliza para describir lógica secuencial, activándose típicamente en los bordes de una señal de reloj o de un reset.

   ```verilog
   always @(posedge clock or posedge reset) begin
       if (reset)
           q <= 0;
       else
           q <= d;
   end
   ```

   En este caso, el bloque se activa en el flanco de subida (`posedge`) de `clock` o de `reset`.

- **Lista de Sensibilidad Implícita (`@*`)**: En versiones modernas de Verilog (como SystemVerilog), la lista de sensibilidad implícita se puede usar para bloques combinacionales. El compilador deduce automáticamente la lista de sensibilidad basada en las señales utilizadas dentro del bloque `always`.

   ```verilog
   always @* begin
       y = a & b | c;
   end
   ```
   Este es equivalente a `@(a or b or c)` en el ejemplo anterior.


**2. Uso general del bloque always**

**Para representar lógica combinacional con bloque procedimental always:**

- La palabra clave always debe ser seguida por un control de eventos sensible a flancos (el token @).
- La lista de sensibilidad del control de eventos no puede contener calificadores posedge o negedge. 
- La lista de sensibilidad debe incluir todas las entradas al bloque procedimental. 
- El bloque procedimental no puede contener otros controles de eventos.
- **Todas las variables escritas por el bloque procedimental deben ser actualizadas para todas las condiciones de entrada posibles.**
- Ningun otro bloque procedimental puede escribir en las variables escritas por este bloque procedimental.

**Para representar lógica lached/retención con bloque procedimental always:**

- La palabra clave always debe ser seguida por un control de eventos sensible a flancos (el token @).
- La lista de sensibilidad del control de eventos no puede contener calificadores posedge o negedge.
- La lista de sensibilidad debe incluir todas las entradas al bloque procedimental. 
- El bloque procedimental no puede contener otros controles de eventos.
- **Al menos una variable escrita por el bloque procedimental no debe actualizarse para algunas condiciones de entrada.**
- Ninguna otra bloque procedimental puede escribir en las variables escritas por este bloque procedimental.

**Para representar lógica secuencial con bloque procedimental always:**

- La palabra clave always debe ser seguida por un control de eventos sensible a flancos (el token @).
- **Todas las señales en la lista de sensibilidad del control de eventos deben estar calificadas con los calificadores posedge o negedge.**
- El bloque procedimental no puede contener otros controles de eventos.
- Ninguna otra bloque procedimental puede escribir en las variables escritas por este bloque procedimental.

## b. SystemVerilog - always_comb - always_lacthed - always_ff: bloques procedimentales especializados

En SystemVerilog, los bloques procedimentales always_comb, always_latch y always_ff son mejoras sobre el tradicional bloque always de Verilog. Estos bloques están diseñados para describir tipos específicos de lógica digital de manera más clara y prevenir errores comunes en el diseño de hardware. Con estas mejoras Las herramientas de software no necesitan inferir a partir del contexto lo que el diseñador pretendía realizar, como debe hacerse con el bloque always procedural general.

### b.1 always_comb

Este bloque se utiliza para describir lógica combinacional pura. Es similar al uso de `always @(*)` en Verilog, pero con mejoras. 

- **Características**:
  - **Inferencia automática de sensibilidad**: No se necesita especificar manualmente la lista de sensibilidad. El simulador infiere automáticamente las señales que deben estar en la lista de sensibilidad basándose en las variables leídas en el bloque.
  
  - **Chequeo de síntesis**: Si introduces una asignación que podría implicar la creación de un almacenamiento de estado (como olvidarte de asignar una señal en alguna rama de un `if-else`), el compilador o las herramientas de verificación pueden generar advertencias o errores, ayudándo a asegurar que realmente se está describiendo lógica combinacional.

- **Ejemplo**:
  ```verilog
  always_comb begin
    if (a > b)
      y = a;
    else
      y = b;
  end
  ```
**`NOTA:`** De no especificarse la instrucción else, el compilador podría inferir que se quiere almacenar un valor, por tanto se podría interpretar como un latch. Lo que llevaría a un error.

### b.2 `always_latch`
Este bloque se usa para describir lógica que implica el uso de **latches**. Un latch es un tipo de almacenamiento de estado que retiene su valor cuando una señal de control está inactiva. 

- **Características**:
  - **Semántica clara**: Indica explícitamente que el bloque está destinado a crear un latch. Si no se está describiendo un latch y el bloque resulta en lógica combinacional, la herramienta de síntesis o simulación puede emitir una advertencia.
  - **Chequeo de síntesis**: Si olvidas asignar alguna señal dentro del bloque, esto es normal para un latch, pero es mejor tener explícita la intención del diseñador usando `always_latch`.
- **Ejemplo**:
  ```verilog
  always_latch begin
    if (enable)
      q = d;
  end
  ```
  Aquí, `q` retendrá su valor anterior si `enable` no está activo.

### b.3 `always_ff`

Este bloque se utiliza para describir lógica secuencial basada en **flip-flops**. Es  similar a `always @(posedge clk)` o `always @(negedge clk)` en Verilog. El bloque procedural always_ff requiere que cada señal en la lista de sensibilidad esté calificada con posedge o negedge. 

- **Características**:
  - **Chequeo de uso correcto**: Este bloque está diseñado para que solo se permita la creación de flip-flops, es decir, no se pueden hacer asignaciones de tipo combinacional o crear latches dentro de un `always_ff`. Esto ayuda a prevenir errores y asegura que el bloque describe claramente un registro secuencial.
  - **Mejora de legibilidad**: Hace explícita la intención de describir lógica secuencial, mejorando la legibilidad del código.
- **Ejemplo**:
  ```verilog
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      q <= 0;
    else
      q <= d;
  end
  ```

## c. Mejores en task y functions

### c.1 Agrupación implícita de declaraciones de funciones y tareas

SystemVerilog simplifica las definiciones de tareas y funciones al no requerir el agrupamiento begin...end para múltiples declaraciones. Si se omite el agrupamiento, las múltiples declaraciones dentro de una tarea o función se ejecutan secuencialmente, como si estuvieran dentro de un bloque **begin...end**.

~~~verilog
function states_t NextState(states_t State);
    NextState = State; // default next state
    case (State)
        WAITE: if (start)   NextState = LOAD;
        LOAD:  if (done)    NextState = STORE;
        STORE:              NextState = WAITE;
    endcase
endfunction
~~~

### c.2 Funciones con valores de retorno

SystemVerilog añade una declaración return, que permite a las funciones devolver un valor usando return, similar a C.

~~~verilog
function int add_and_inc (input int a, b);
    return a + b + 1;
endfunction
~~~

Para mantener la compatibilidad con versiones anteriores de Verilog, el valor de retorno de una función puede especificarse tanto usando la declaración return como asignando al nombre de la función. La declaración return tiene prioridad. 

~~~verilog
function int add_and_inc (input int a, b);
    add_and_inc = a + b;
    return ++add_and_inc;
endfunction
~~~


### c.3 Retorno antes de endtask y endfunctions

La declaración return de SystemVerilog se puede usar para salir de una tarea o función en cualquier momento del flujo de ejecución, sin necesidad de llegar al final de la tarea o función. 

~~~verilog
function automatic int log2 (input int n);
    if (n <=1) return 1; // abort function
    log2 = 0;
    
    while (n > 1) begin
        n = n/2;
        log2++;
    end
endfunction
~~~


### c.4 Void functions

En SystemVerilog, las void functions son funciones que no retornan ningún valor. Esto es similar al concepto de funciones void en lenguajes de programación como C o C++. Estas funciones se utilizan cuando quieres realizar alguna operación dentro de la función, pero no necesitas devolver un valor a la llamada de la función.

Otra mejora de SystemVerilog es que **las funciones pueden tener argumentos formales de salida (output) e inout**. Esto permite que una función de tipo void que no tiene un valor de retorno, aún así propague cambios al ámbito que llamó a la función.

~~~verilog
typedef struct {
    logic valid;
    logic [ 7:0] check;
    logic [63:0] data;
} packet_t;

function void fill_packet ( 
    input logic [63:0] data_in, 
    output packet_t data_out );
    data_out.data = data_in;
    
    for (int i=0; i<=7; i++)
        data_out.check[i] = ^data_in[(8*i)+:8];
    data_out.valid = 1;
endfunction
~~~

**`NOTA:`** Para sintésis, es preferible usar, void function en lugar de task.

### c.5 Paso de argumentos por nombre a las taks y functions.

SystemVerilog añade la capacidad de pasar valores de argumentos a una tarea o función utilizando los nombres de los argumentos formales, en lugar del orden de los argumentos formales. 

~~~verilog
function int divide (input int numerator, denominator);
    .
    .
    .
endfunction 
// SystemVerilog style function call
always @(posedge clock)
    result <= divide(.denominator(b), .numerator(a) );
~~~

### c.6 Mejoras en los argumentos formales de una función

SystemVerilog permite que los argumentos formales de las funciones sean declarados como **input, output o inout**, al igual que las tareas. 

~~~verilog
function [63:0] add (
    input [63:0] a, b
    output overflow
);
        {overflow,add} = a + b;
endfunction
~~~

**1. Restricciones a la hora de llamar funciones con salidas**

Para prevenir efectos secundarios indeseables e in-sintetizables, SystemVerilog restringe desde dónde pueden ser llamadas las funciones con argumentos de salida o inout. 

- Una expresión de evento.
- Una expresión dentro de una asignación continua procedural.
- Una expresión que no esté dentro de una declaración procedural.

### c.7 Funciones sin argumentos formales

SystemVerilog permite funciones sin argumentos formales, al igual que las tareas en Verilog.

~~~verilog
function int get_constant_value();
  // La función retorna un valor constante
  return 42;
endfunction
~~~

### c.8 Dirección y tipo (input-output) default para argumentos formales

SystemVerilog simplifica la sintaxis de declaración de tareas y funciones al hacer que la dirección predeterminada sea de entrada. Hasta que se declare una dirección de argumento formal, se asume que todos los argumentos son de entrada. 

~~~verilog
function int compare (int a, b);
...
endfunction

// a and b are inputs, y1 and y2 are outputs
task mytask (a, b, output y1, y2);
...
endtask
~~~

### c.9 Valores default de argumentos formales

SystemVerilog permite definir un valor predeterminado opcional para cada argumento formal de una tarea o función. El valor predeterminado se especifica utilizando una sintaxis similar a la inicialización de una variable. 

~~~verilog
function int incrementer(int count=0, step=1);
    incrementer = count + step;
endfunction
~~~

Cuando se pasa solo un valor a la función, este se pasará al primer argumento formal de la función. El segundo argumento formal, step, utilizará su valor predeterminado de 1. 

~~~verilog
always @(posedge clock)
    result = incrementer( data_bus );
~~~

**`NOTA:`** SystemVerilog permite que la llamada a tarea o función tenga menos expresiones de argumento que el número de argumentos formales. Si una llamada a tarea o función no pasa un valor a un argumento de la tarea o función, entonces la definición formal del argumento debe tener un valor predeterminado. 

### c.10 Arrays, structs, unions como argumentos formales

SystemVerilog permite que los arrays empaquetados o desempaquetados, estructuras
empaquetadas o desempaquetadas y uniones empaquetadas, desempaquetadas
o etiquetadas se pasen dentro o fuera de tareas y funciones. 

- **Para estructuras o uniones**, el argumento formal debe estar definido como un tipo de estructura o unión (donde se usa typedef para definir el tipo). 

- Los **arrays empaquetados** se tratan como un vector cuando se pasan a una tarea o función. Si el tamaño de un argumento de array empaquetado de la llamada no coincide con el tamaño del argumento formal, el vector se truncará o expandirá, siguiendo las reglas de asignación de vectores de Verilog. 

- Para **arrays desempaquetados**, el argumento de array de la llamada a tarea o función que se pasa debe coincidir exactamente

~~~verilog
typedef struct {
    logic valid;
    logic [ 7:0] check;
    logic [63:0] data;
} packet_t;

function void fill_packet (
    input logic [7:0] data_in [0:7], // array arg
    output packet_t data_out ); // structure arg
    
    for (int i=0; i<=7; i++) begin
        data_out.data[(8*i)+:8] = data_in[i];
        data_out.check[i] = ^data_in[i];
    end
    
    data_out.valid = 1;
endfunction
~~~

### c.11 Pasar valores por argumentos, por referencia en vez de copias 

En SystemVerilog, al igual que en muchos otros lenguajes de programación, los argumentos de funciones y tareas se pasan por defecto "por valor". Esto significa que cuando se pasa una variable como argumento, lo que realmente se pasa es una copia del valor de esa variable. Cualquier modificación que se haga a ese argumento dentro de la función o tarea no afectará a la variable original en el contexto donde se llamó la función o tarea. 

Para modificar el valor original de un argumento dentro de una tarea o función, se puede pasar el argumento por referencia usando la **palabra clave ref**. Cuando se pasa por referencia, cualquier cambio en el argumento dentro de la tarea o función afectará al valor original fuera de esta.

**Para tener argumentos ref, una tarea o función debe ser automática.** La tarea o función puede ser declarada explícitamente como automática, o puede ser inferida como automática al ser declarada en un módulo, interfaz o programa que está definido como automático.

~~~verilog
module chip (...);
    typedef struct {
        logic valid;
        logic [ 7:0] check;
        logic [63:0] data;
    } packet_t;

    packet_t data_packet;
    logic [7:0] raw_data [0:7];

    always @(posedge clock)
        if (data_ready)
            fill_packet (.data_in(raw_data), .data_out(data_packet) );
    
    function automatic void fill_packet (
        ref logic [7:0] data_in [0:7], // ref arg
        ref packet_t data_out );        // ref arg
    
    for (int i=0; i<=7; i++) begin
        data_out.data[(8*i)+:8] = data_in[i];
        data_out.check[i] = ^data_in[i];
    end

    data_out.valid = 1;
endfunction
...
endmodule
~~~

**1. Referencias por agumentos solo de lectura**

Un argumento formal de referencia puede declararse como **const ref** para permitir únicamente la lectura del objeto al que se hace referencia. Esto puede usarse para permitir que la tarea o función acceda a la información en el ámbito de llamada, pero prohibir que modifique esa información dentro del ámbito de llamada.

~~~verilog
function automatic void fill_packet (
    const ref logic [7:0] data_in [0:7],
    ref packet_t data_out );
    ...
endfunction
~~~

**2. Las referencias en las tareas son sensibles a cambios**

Una característica importante de los argumentos ref es que la lógica de una tarea puede ser sensible a los cambios en la señal en el ámbito de llamada. Esta sensibilidad a los cambios no se aplica a los argumentos ref de funciones. 

**3. Los argumentos referenciados pueden leer valores actuales**

Al pasar un argumento como ref, la tarea o función opera directamente sobre la variable original, permitiendo tanto la lectura como la modificación de su valor actual.

**4. Los argumetnos referenciados pueden propagar cambios inmediatamente.**

Cuando una salida de tarea se pasa por referencia, la tarea realiza su asignación directamente a la variable en el ámbito de llamada. Cualquier control de eventos en el ámbito de llamada que sea sensible a los cambios en la variable verá el cambio de inmediato, en lugar de esperar hasta que la tarea complete su ejecución y las salidas se copien de vuelta al ámbito de llamada.

**5. Restricciones en llamadas de funciones con argumentos referenciados**

Una función con argumentos formales ref puede modificar valores fuera del ámbito de la función, por lo tanto, tiene las mismas restricciones que las funciones con argumentos de salida. Una función con argumentos de salida/output, inout o ref no puede ser llamada desde una expresión:

- de evento
- dentro de una asignación continua
- dentro de una asignación continua procedural
- que no esté dentro de una declaración procedural

## c.12 Etiquetas para endtask y endfunction

SytemVerilog permite especificar un nombre con la palabra clave endtask o endfunction. La sintaxis es:

~~~verilog
endtask : task_name
endfunction : function_name
~~~

Especificar un nombre con la palabra clave endtask o endfunction puede ayudar a que bloques grandes de código sean más fáciles de leer, lo que hace que el modelo sea más mantenible.