# Declaración de espacios/ package

En SystemVerilog, los "espacios" se refieren a la declaración y uso de áreas de memoria o recursos lógicos para la simulación y síntesis de diseños digitales

## a. Packages

En SystemVerilog, un **package** es una construcción que se utiliza para agrupar y encapsular elementos como tipos de datos, constantes, funciones, tareas, parámetros, interfaces y módulos que pueden ser compartidos y reutilizados en diferentes partes de un diseño o entorno de verificación.

### a.1 Definiciones de package

Los paquetes/packages permiten el uso compartido de la definición de tipos de datos definidos por el usuario en múltiples módulos. Los paquetes definen con las palabras claves **package** y **endpackage**.

**Los constructos sintetizables que un package puede tener son:**

- **parameters** y **localparam** 
- variables **const**
- **typedef**
- **tasks** y **functions**
- **import**
- **sobrecarga de operadores**

Ejemplo de sintáxis de un package:
~~~verilog
package definitions;
    parameter VERSION = "1.1";
    
    typedef enum {ADD, SUB, MUL} opcodes_t;
    
    typedef struct {
        logic [31:0] a, b;
        opcodes_t
        opcode;
    } instruction_t;
    
    function automatic [31:0] multiplier (input [31:0] a, b);
        // code for a custom 32-bit multiplier goes here
        return a * b; // abstract multiplier (no error detection)
    endfunction

endpackage
~~~

#**`NOTA:`** en un package, **parameter** y **localparameter** son **sinónimos**. 

### a.2 Referencias packages

1. Referenciar a paquetes usando el operador de resolución de ámbito **`::`**

Este operador de resolución  permite hacer referencia directa a un paquete por su nombre de paquete, y luego seleccionar una definición o declaración específica dentro del paquete.
~~~verilog
module ALU(
    input definitions::instruction_t IW,
    input logic clock,
    output logic [31:0] result
);
    always_ff@(posedge clock) begin
        case(IW.opcode)
            definitions::ADD : result = IW.a + IW.b; 
            definitions::SUB : result = IW.a - IW.b;
            definitions::MUL : result = multiplier(IW.a, IW.b);
        endcase
    end
endmodule
~~~
2. Importando items específicos del paquete

~~~verilog
module Alu(
    input definitions::instruction_t IW, 
    input logic clock, 
    output logic [31:0] result
    );
    // Importación de item especificos del paquete definitions
    import definitions::ADD;
    import definitions::SUB;
    import definitions::multiplier;

    always_comb begin
        case (IW.opcode)
            ADD: result = IW.a + IW.b;
            SUB: result = IW.a - IW.b;
            MUL: result = multiplier(IW.a, IW.b);
        endcase
    end
~~~

3. wildcard import 

En ocasiones puede ser práctico importar todos los elementos de un paquete con la instrcucción siguiente:

> import definitions::*; //wildcard (comodin) import

Cuando se importan elementos de un paquete utilizando un comodín,
**solo se importan los elementos que realmente se utilizan en el módulo interfaz**. Las definiciones y declaraciones en el paquete que no se utilizan
no se importan.

~~~verilog
module Alu(
    input definitions::instruction_t IW, 
    input logic clock, 
    output logic [31:0] result
    );
    // Importación de item especificos del paquete definitions
    import definitions::*; // wildcard import

    always_comb begin
        case (IW.opcode)
            ADD: result = IW.a + IW.b;
            SUB: result = IW.a - IW.b;
            MUL: result = multiplier(IW.a, IW.b);
        endcase
    end
~~~

### a.3 Synthesis guide

- **Para ser sintetizables**, las tareas y funciones definidas en un paquete deben ser **declaradas como automáticas** (automatics) y **no pueden contener variables estáticas**. 

- La sintésis no soporta declaraciones de variables en paquetes.

## b. $unit compilation ( unidad de declaración) - unit declaration

En los ejemplos anteriores, para el puerto del módulo IW, el nombre del paquete aún debe ser referenciado explícitamente. No es posible añadir una declaración de importación (import) entre la palabra clave module y el nombre del módulo las definiciones de puertos.

Sin embargo, hay una manera de evitar tener que hacer referencia explícita al nombre del paquete en una lista de puertos utilizando el espacio de declaración $unit.

**\$unit** se refiere al ámbito (scope) global de un archivo o un grupo de archivos que se compilan juntos. En otras palabras, **cualquier elemento definido fuera de un módulo, interfaz, programa, o cualquier otra declaración de bloque, reside en el ámbito $unit.**

**Las unidades de compilación** **proporcionan un medio para que las herramientas de software compilen por separado sub-bloques de un diseño global**. Un sub-bloque podría comprender un solo módulo o varios módulos. Estos módulos pueden estar contenidos en un solo archivo o en múltiples archivos.

~~~verilog
/******************* External declarations *******************/
parameter VERSION = "1.2a";
 // external constant
reg resetN = 1;
 // external variable (active low)
typedef struct packed {
    reg [31:0] address;
    reg [31:0] data;
    reg [ 7:0] opcode;
} instruction_word_t;

// external user-defined type
function automatic int log2 (input int n);
    if (n <=1) return(1);
        log2 = 0;
    while (n > 1) begin
        n = n/2;
        log2++;
    end
    return(log2);
endfunction

// ********************* module definition *********************/
// external declaration is used to define port types
module register (output instruction_word_t q,
    input instruction_word_t d,
    input wire clock 
    );
always @(posedge clock, negedge resetN)
    if (!resetN) 
        q <= 0;
    // use external reset
    else q <= d;
endmodule
~~~

En otras palabras \$unit es el ambito global de una unidad de compilación. Permite definir elementos que son accesibles en todo el archivo de código que se compilan juntos.

**1. Guía de codificación**

Declarar objetos directamente en el espacio de unidad de compilación \$unit puede llevar a errores de diseo cuando los archivos se compilan por separado.

**2. Guía de codificación para importar paquetes dentro de \$unit**

SystemVerilog permite que los puertos de los módulos se declaren como tipos definidos por el usuario.

~~~verilog
module ALU(
    input definitions::instruction_t IW, 
    input logic clock, 
    output logic [31:0] result
);
~~~

Referenciar de este modo puedo ser tedioso y redundante cuando muchos puertos del módulo son de tipos definidos por el usuario. Por lo que un método alternativo sería importar un paquete en el ámbito \$unit, antes de la declaración del modulo.

~~~verilog
import definitions::instruction_t;
module ALU(
    input instruction_t IW, 
    input logic clock, 
    output logic [31:0] result
);
~~~

**3. Importar paquetes dentro de \$unit con compilación separada.**

Al usar **\$unit**, las dependencias del orden de los archivos pueden ser un problema, y múltiples $units pueden ser un problema. 

Cuando se importan elementos de un paquete en SystemVerilog, se debe hacer antes de referenciarlos en el código. Si la importación se realiza en un archivo diferente al que se utiliza en esos elementos, ese archivo de importación debe ser compilado primero. De lo contrario, la compilación fallará o los elementos del paquete no serán reconocidos correctamente.

Cuando se compilan varios archivos juntos, todos comparten el mismo espacio `$unit`, lo que hace que las importaciones sean visibles para todos los módulos e interfaces. Sin embargo, si se compilan archivos por separado, cada uno tiene su propio espacio `$unit`, y las importaciones no se comparten entre ellos.

Para evitar problemas de visibilidad, una solución es incluir las importaciones en cada archivo, antes de las definiciones de módulos o interfaces. Si se compilan múltiples archivos juntos, se debe asegurar el no importar el mismo paquete más de una vez en el mismo `$unit`, ya que esto es ilegal.

Un truco para manejar esto es usar **compilación condicional (similar a C)** para asegurarse de que las importaciones solo se incluyan la primera vez que se encuentra el paquete en el espacio `$unit`. Esto se logra estableciendo una bandera **(`define`)** cuando el paquete se importa por primera vez. Si la bandera ya está establecida, las importaciones se omiten en compilaciones posteriores, evitando duplicaciones.

Este método asegura que las definiciones dentro del paquete sean visibles en el espacio `$unit` actual, sin importar si los archivos se compilan juntos o por separado..

En el siguiente ejemplo, el paquete definitions se encuentra en un arhivo separado, llamado **package**.

~~~verilog
`ifndef DEFS_DONE // 
`define DEFS_DONE // set the flag

package definitions;
    parameter  VERSION = "1.1";
    typedef enum {ADD, SUB, MUL} opcodes_t;

    typedef struct{
        logic [31:0] a, b;
        opcodes_t opcode;
    }instruction_t;

    function automatic [31:0] multiplier (input [31:0] a, b);
        return a*b;
    endfunction

endpackage

`endif
~~~

Dentro del archivo package.sv, se establece una bandera para indicar cuándo se ha compilado este archivo. La compilación condicional rodea todo el contenido del archivo. Si la bandera no se ha establecido, entonces el paquete se compilará y se importará en \$unit. Si la bandera ya está establecida (indicando que el paquete ya se ha compilado e importado en el espacio $unit actual), entonces el contenido del archivo se ignora.

Por tanto para usar los datos del archivo anterior se debe importat el archivo de la siguiente manera:

~~~verilog
`include "package.sv"

module ALU(
    input instruction_t IW, 
    input logic clock, 
    output logic [31:0] result;
);

    always_comb begin
        case(IW.opcode)
            ADD: result = IW.a + IW.b;
            SUB: result = IW.a - IW.b;
            MUL: result = multiplier(IW.a, IW.b);
        endcase
    end
endmodule
~~~

**4. Guía de sintésis**

**Los constructos sintetizabla que se puden declarar dentro del ámbito de \$unit son:**

- **`typedef`**
- **`automatic functions`**
- **`automatic task`**
- **`parameter, localparam`**
- **`import packages`**

Aunque no es un estilo recomendado, los tipos definidos por el usuario en el ámbito de la unidad de compilación son sintetizables. Un estilo mejor es colocar las definiciones de tipos definidos por el usuario en paquetes nombrados. s

## c. Declaraciones en bloques sin nombre (begin ... end, fork ... join)

Las "declarations in unnamed statement blocks" en SystemVerilog se refieren a las declaraciones de variables, funciones, tareas, y otros elementos dentro de un bloque de código que no tiene un nombre asignado. Un "unnamed statement block" es simplemente un bloque de código delimitado por **begin** y **end** o **fork** y **join** sin que se le asigne un nombre o etiqueta.

~~~verilog
module chip (input clock);
    integer i; // declaraciones a nivel de modulo

    always @(posedge clock)
    begin: loop // named block
        integer i; // local variable
        
        for (i=0; i<=127; i=i+1) begin // unamed block
            integer f = 1;
        end

    end
~~~

Una variable declarada en un bloque nombrado puede ser referenciada con un  nombre de ruta jerárquica que incluye el nombre del bloque. Las referencias jerárquicas no son sintetizables y no representan el comportamiento del hardware. 

La ruta jerárquica a la variable dentro del bloque nombrado también puede ser utilizada por archivos VCD (Value Change Dump), visualizadores de formas de onda  u otras herramientas de depuración para referenciar la variable declarada localmente.

El siguiente fragmento de banco de pruebas utiliza rutas jerárquicas para imprimir el valor de ambas variable llamadas i en el ejemplo anterior:

~~~verilog
module test;
    reg clock;
    chip chip_test(.clock(clock));

    always #5 clock=~clock;

    initial begin
        clock = 0;
        
        repeat (5) @(negedge clock);
        $display("chip_test.i = 0%d", chip_test.i);
        $display("chip_test.loop.i = 0%d", chip_test.loop.i);
        $finish;
    end
endmodule
~~~

Un testbench o un archivo VCD no pueden referenciar la variable local porque no hay camino jerárquico hacia la variable.

**`Nota:`** Declarar variables en bloques sin nombre puede servir como un medio para proteger las variables locales de referencias cruzadas externas entre módulos. 

## d. Unidades de tiempo de simulación y declaraciones de unit

### d.1 Directiva timescale

La directiva tiene dos componentes: **las unidades de tiempo**
y la **precisión de tiempo** que se debe utilizar. El componente de
precisión indica a la herramienta de software cuántos lugares decimales
de precisión utilizar.

Ejemplo:

> `timescale 1ns/10ps

La instrucción anterior instruye a la herramienta de software que utilice unidades de tiempo de 1 nanosegundo y una precisión de 10 picosegundos, lo que equivale a 2 lugares decimales, en relación con 1 nanosegundo.

Se pueden especificar directivas con diferentes valores para diferentes regiones de un diseño o archivos. Cuando esto ocurre, la herramienta de software debe resolver las diferencias encontrando un denominador común en todas las unidades de tiempo especificadas, y luego escalando todos los retardos en cada región del diseño al denominador común.

Un problema que se encuentra con la directiva **timescale** tiene que ver con el hecho de que la directiva timescale no está asociada a un módulo o archivo específico. En su lugar, es un comando global para la herramienta de software, y permanece activo hasta que se encuentre otro timescale.

**Situación 1:** Si los archivos se leen en el orden A, B, C, y el archivo A tiene un timescale definido como 1ns/1ns y el archivo B no tiene su propia directiva timescale, entonces el módulo en el archivo B heredará el timescale del archivo A. Esto significa que los retrasos en el archivo B se interpretarán con la escala de tiempo del archivo A (5 unidades de retardo representarán 5 nanosegundos).

![alt text](img/image.png)


**Situación 2:** Si los archivos se leen en un orden diferente, por ejemplo, A, C, B, donde el archivo C tiene una directiva timescale diferente, digamos 1ps/1ps, entonces el módulo en el archivo B (que sigue al archivo C) usará esta nueva escala de tiempo. En este caso, los mismos 5 unidades de retardo en B ahora se interpretarían como 5 picosegundos, no nanosegundos.

![alt text](img/image2.png)

**Solución:** Para evitar estos problemas, **se recomienda siempre incluir una directiva timescale al principio de cada archivo o módulo Verilog**. De esta manera, se asegura que cada módulo o archivo tiene sus propias definiciones claras y no depende de directivas timescale de otros archivos, lo que elimina la dependencia del orden de lectura de archivos.

### 4.2 Valores de tiempo con unidades de tiempo

Especificar las unidades de tiempo como parte del valor de tiempo elimina toda ambigüedad sobre lo que representa el retraso. 
El siguiente ejemplo es un oscilador de 10 nanosegundos (5 ns alto, 5 ns bajo).

> forever #5ns clock = ~clock;

| **Unidad** | **Descripción** |
|------------|-----------------|
| s          | seconds         |
| ms         | milliseconds    |
| us         | microseconds    |
| ns         | nanoseconds     |
| ps         | picoseconds     |
| fs         | femtoseconds    |
| step       | the smallest unit of time being used by the software tool (used in SystemVerilog testbench clocking blocks) |

### 4.3 Scope-level time unit and precision

El concepto de Scope-level time unit and precision se refiere a la capacidad de definir unidades de tiempo (time unit) y precisión (time precision) a diferentes niveles de alcance o scope en el código, tales como módulos, funciones, tareas, etc. Esto es crucial en simulaciones y síntesis para controlar cómo se miden y redondean los tiempos.

Las palabras claves **timeunit** y **timeprecision** **permiten vincular la información de unidad y precisión directamente a un módulo, interfaz o bloque de programa**, en lugar de ser comandos para la herramienta de software. Esto resuelve la ambigüedad y la dependencia del orden de los archivos que existen con la directiva `timescale de Verilog.

La especificación de timeunit y timeprecision en un módulo, interfaz o programa debe ser la primera declaración dentro del módulo, apareciendo inmediatamente después de la lista de puertos y antes de cualquier otra declaración o sentencia. Cabe destacar que en cuestiones de prioridad, las directivas timeunit y timprecision están por encima de timescale ya que se podrian considerar como "variables locales" . 

~~~verilog
// Definiciones globales para precisión y unidad de tiempo
timeunit 1ns;
timeprecision 1ns;

module my_chip (
    // Define tus puertos aquí
    input logic data_request,
    ...
);
    // Precisión local
    timeprecision 1ps;

    always @(posedge data_request) begin
        #2.5 send_packet; // Usa las unidades externas y la precisión local
        #3.75ns check_crc; // Unidades específicas tienen prioridad
    end

    task send_packet();
        // Implementación de la tarea send_packet
    endtask

    task check_crc();
        // Implementación de la tarea check_crc
    endtask
endmodule

// Directiva timescale para el módulo FSM
`timescale 1ps/1ps

module FSM (
    // Define tus puertos aquí
    input logic [N:0] State,
    ...
);
    // Definiciones locales de unidad y precisión de tiempo
    timeunit 1ns;

    always @(State) begin
        #1.2 case (State) // Usa las unidades locales y la precisión de timescale
            WAITE: #20ps ...; // Unidades específicas tienen prioridad
            ...
        endcase
    end
endmodule
~~~

### Explicación:
1. **Definiciones Globales:** Las definiciones de `timeunit` y `timeprecision` se colocan al inicio del archivo para establecer valores predeterminados para todos los módulos que no tienen configuraciones locales diferentes.

2. **Módulo `my_chip`:** Dentro del módulo, se especifica una precisión local de `1ps`, que se aplica a las declaraciones de tiempo dentro del bloque `always`. Los comentarios indican cómo se aplican las unidades y la precisión local.

3. **Módulo `FSM`:** Usa la directiva `timescale` para establecer la precisión por defecto del módulo. Dentro del módulo, se pueden usar unidades y precisiones específicas. En este caso, `1ps` para la unidad de tiempo y `1ps` para la precisión, con unidades específicas (`20ps`) cuando sea necesario.

En general, asegúrate de adaptar los detalles de tu implementación específica a tus necesidades, incluyendo los puertos del módulo y las definiciones del estado.