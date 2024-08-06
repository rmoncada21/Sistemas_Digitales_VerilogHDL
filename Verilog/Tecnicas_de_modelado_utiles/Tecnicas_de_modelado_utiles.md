# Técnicas de modelado útiles

## a. Asignaciones procedimentales continuas 

En la sección 7.2 (behavioral modeling) se vió las **asignaciones procedimentales**. Las **asignaciones procedimentales continuas** trabaja de forma diferente. 

En Verilog, las asignaciones procedimentales continuas son mecanismos utilizados para controlar los valores de las señales dentro de un bloque procedural. Hay dos tipos principales de asignaciones procedimentales continuas: assign-deassign y force-release. 

La parte izquierda de la declaración de una asignación procedimental continua **tiene que ser un registro o una concatenación de registros**. No pueden ser parte o una selección de bit de una net, ni tampoco un arreglos de registros. 

Las asignaciones procedimentales continuas:

- Sobrecargan el efcto de una asignación procedimental regular.

- Se usan normalmente para controlar periodos de tiempo.

### a.1 assign and deassign

Las palabras claves **assign** y **deassign** se usan para expresar el primer tipo de asignaciones procedimentales continuas. 

- **`assign:`** La declaración assign se utiliza para asignar un valor a una variable reg de manera continua. Esto significa que la variable mantendrá este valor asignado hasta que se use una declaración deassign para liberarla.

- **`deassign:`** La declaración deassign se utiliza para liberar la asignación continua previamente establecida por assign.

Ejemplo:

~~~verilog
reg [7:0] data;

initial begin
    assign data = 8'b10101010; // Asignación continua
    #10 deassign data; // Liberar asignación continua después de 10 unidades de tiempo
end
~~~

### a.2 force and release

Las declaraciones force y release se usan para expresar el segundo ttipo de asignaciones procedimentales continuas.

Las declaraciones force y release se utilizan para anular y luego restaurar el valor de una señal (tanto **reg** como **wire**). Este mecanismo **es útil para pruebas y depuración**, donde puede ser necesario forzar una señal a un valor específico y luego restaurar su comportamiento normal.

Es recomendable el uso de **force and release** en **testbenches y debugs** mas no en diseño.

- **`Force:`** La declaración force se utiliza para forzar una señal a un valor específico. Este valor forzado permanecerá hasta que se use una declaración release.

- **`Release:`** La declaración release se utiliza para liberar una señal que ha sido forzada previamente por una declaración force.

Ejemplo:
~~~verilog
reg clk;
reg reset;
reg [7:0] data;

initial begin
    force clk = 1'b0; // Forzar clk a 0
    #5 release clk; // Liberar clk después de 5 unidades de tiempo

    force data = 8'b11110000; // Forzar data a un valor específico
    #10 release data; // Liberar data después de 10 unidades de tiempo
end
~~~

## b. Sobrecarga de parámetros

La **sobrecarga de parámetros** (overrifing parameter) es una técnica que permite cambiar los valores predeterminados de los parámetros de un módulo cuando se instancia. Esto **permite reutilizar** módulos con diferentes configuraciones sin necesidad de modificar el código del módulo original. Los parámetros en Verilog son constantes definidas dentro de un módulo que pueden ser utilizadas para definir tamaños de buses, establecer constantes u otras configuraciones ajustables.

Ejemplo con un solo parámetro para el uso de parámetros
~~~verilog
module my_module #(parameter WIDTH = 8) (
    input [WIDTH-1:0] data_in,
    output [WIDTH-1:0] data_out
);
    // Lógica del módulo
endmodule
~~~

Ejemplo con varios parámetros
~~~verilog
module my_module #(parameter WIDTH = 8, parameter DEPTH = 16) (
    input [WIDTH-1:0] data_in,
    output [WIDTH-1:0] data_out,
    input clk
);
    // Lógica del módulo
endmodule
~~~

### b.1 defparam 

La declaración defparam se utiliza para sobrecargar los parámetros de un módulo desde fuera del módulo. A diferencia de la sobrecarga de parámetros en la instancia, defparam se utiliza fuera del contexto de la lista de parámetros de la instancia.

Sintáxis:
~~~verilog
defparam instancia.parametro = valor;
~~~

Basados en el ejemplo de un solo parámetro:

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out
);
    // Instancia del módulo
    my_module instance_name (
        .data_in(data_in[7:0]),
        .data_out(data_out[7:0])
    );

    // Sobrecarga del parámetro WIDTH usando defparam
    defparam instance_name.WIDTH = 32;
endmodule
~~~

Basados en el ejemplo de un varios parámetros:

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out,
    input clk
);
    // Instancia del módulo
    my_module instance_name (
        .data_in(data_in[7:0]),
        .data_out(data_out[7:0]),
        .clk(clk)
    );

    // Sobrecarga de los parámetros WIDTH y DEPTH usando defparam
    defparam instance_name.WIDTH = 32;
    defparam instance_name.DEPTH = 64;

endmodule
~~~

### b.2 Valores de parámetros en instancias de módulos

La sobrecarga de parámetros (overriding parameters) se puede realizar durante la instancia del módulo, lo que permite modificar los valores predeterminados de los parámetros directamente en el momento de instanciar el módulo. Este método es más intuitivo y preferido en la práctica moderna de diseño de hardware.

1. **Asignación Posicional:** Los parámetros se listan en el orden en que se definen en el módulo original.

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out
);
    // Sobrecarga del parámetro WIDTH usando asignación posicional
    my_module #(16) instance_name (
        .data_in(data_in[15:0]),
        .data_out(data_out[15:0])
    );
endmodule
~~~

Basados en el ejemplo de un varios parámetros:

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out,
    input clk
);
    // Instancia con parámetros sobrecargados usando asignación posicional
    my_module #(32, 64) instance_name (
        .data_in(data_in[31:0]),
        .data_out(data_out[31:0]),
        .clk(clk)
    );
endmodule
~~~

2. **Asignación Nominal:** Los parámetros se especifican por nombre, lo que es más claro y menos propenso a errores, especialmente cuando hay múltiples parámetros.

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out
);
    // Sobrecarga del parámetro WIDTH usando asignación nominal
    my_module #(.WIDTH(32)) instance_name (
        .data_in(data_in[31:0]),
        .data_out(data_out[31:0])
    );
endmodule
~~~

Basados en el ejemplo de un varios parámetros:

~~~verilog
module top_module (
    input [31:0] data_in,
    output [31:0] data_out,
    input clk
);
    // Instancia con parámetros sobrecargados
    my_module #(.WIDTH(32), .DEPTH(64)) instance_name (
        .data_in(data_in),
        .data_out(data_out),
        .clk(clk)
    );
endmodule
~~~

## c. Compilación condicional y ejecución

La compilación condicional y la ejecución condicional son técnicas utilizadas para controlar qué partes del código se incluyen en la compilación y qué partes del código se ejecutan durante la simulación. Estas técnicas son especialmente útiles para manejar configuraciones diferentes, depuración, y pruebas sin cambiar el código fuente principal.

### c.1 Compilación condicional 

La compilación condicional en Verilog se logra utilizando directivas de preprocesador como **ifdef**, **ifndef**, **else**, **elsif**, y **endif**. Estas directivas permiten incluir o excluir bloques de código basado en si una macro está definida o no.

**Directivas de Compilación Condicional:**

- **`ifdef`**: Compila el bloque de código si la macro está definida.
- **`ifndef`**: Compila el bloque de código si la macro no está definida.
- **`else`**: Compila el bloque de código alternativo si la condición previa no se cumple.
- **`endif`**: Marca el final de un bloque de compilación condicional.
- **`define`**: Define una macro.

La instrucción \`ifdef puede ir en cualquier parte del código y siempre debe ir acompañada con la instrucción \`endif. La instrucción \`else es opcional y solo puede haber un máximo de esta instrucción puede acompañar a \`ìfdef. 

Ejempo:

~~~verilog
`define DEBUG  // Definir la macro/flag DEBUG

module conditional_compile_example();
    initial begin
        `ifdef DEBUG
            $display("Debug mode is enabled");
        `else
            $display("Debug mode is disabled");
        `endif
    end
endmodule
~~~
### c.2 Ejecución condicional

La ejecución condicional en Verilog se maneja mediante declaraciones condicionales (if, else) dentro del código RTL o de simulación. Esto permite que diferentes partes del código se ejecuten en función de ciertas condiciones durante la simulación.

~~~verilog
module conditional_execution_example(input logic a, b, output logic y);
    always_comb begin
        if (a == 1) begin
            y = b;
        end else begin
            y = ~b;
        end
    end
endmodule
~~~

## d. Time scales

La directiva **timescale** se utiliza para definir la unidad de tiempo y la precisión de la simulación. Esta directiva es fundamental para especificar cómo se interpretan las unidades de tiempo en un módulo, lo que afecta la simulación de retardos, tiempos de configuración y retención, y otros aspectos temporales del diseño.

Sintáxis:
~~~verilog
`timescale time_unit / time_precision
~~~

- **time_unit:** Especifica la unidad de medida para el tiempo y para los retrasos.

- **time_precision:** Especifíca la presición con la que los retrasos se redondean durante la simulación. 

Ambos valores se expresan en las unidades de tiempo de Verilog: **`s`** (segundos), **`ms`** (milisegundos), **`us`** (microsegundos), **`ns`** (nanosegundos), **`ps`** (picosegundos), y **`fs`** (femtosegundos)`

**`Nota:`** Solo los valores de 1, 10, 100 son números enteros válidos para especificar las unidades de tiempo y de presición. 

Claro, aquí tienes la sección completa en Markdown:

## e. Tareas útiles del sistema

### e.1 File output
Verilog proporciona varias tareas del sistema para la salida de archivos, permitiendo a los diseñadores escribir datos a archivos durante la simulación. Algunas de las tareas comunes son:
- `$fopen(filename)`: Abre un archivo para escribir y devuelve un descriptor de archivo. La $fopen taks devuelve un ***descriptor de multicanal*** que es una variable de 32 bits. Cada llamada exitosa a $fopen devuelve un descriptor de 32 bits con el bit menos significativo activado.
- `$fclose(fd)`: Cierra el archivo asociado con el descriptor de archivo `fd`.
- `$fdisplay(fd, format, ...)`: Escribe en el archivo con el descriptor `fd` usando una cadena de formato similar a `$display`.
- `$fwrite(fd, format, ...)`: Escribe en el archivo con el descriptor `fd` sin un salto de línea al final.
- `$fscanf(fd, format, variable)`: Lee datos desde un archivo al simulador.

Ejemplo:
```verilog
integer fd;
initial begin
    fd = $fopen("output.txt");
    if (fd) begin
        $fdisplay(fd, "Hello, World!");
        $fclose(fd);
    end
end
```

### e.2 Displaying Hierarchy
Para mostrar la jerarquía del diseño durante la simulación, se pueden usar las siguientes tareas del sistema:
- `$showvars`: Muestra las variables y sus valores actuales.
- `$showtasks`: Muestra las tareas actualmente activas.
- `$list`: Muestra una lista de todos los módulos y su jerarquía en el diseño.

Ejemplo:
```verilog
initial begin
    $display("Hierarchical structure of the design:");
    $list;
end
```

### e.3 Strobe

Esta tarea del sistema imprime los valores de las variables en un formato similar a $display, pero al final del ciclo de simulación actual.

~~~verilog
module strobe_example;
    reg a, b, c;

    initial begin
        a = 0; b = 0; c = 0;
        #5 a = 1; b = 1;
        #5 c = 1;
    end

    initial begin
        $monitor("Time=%0d a=%b b=%b c=%b", $time, a, b, c);
    end

    initial begin
        #10 $display("Using $display: Time=%0d a=%b b=%b c=%b", $time, a, b, c);
        #10 $strobe("Using $strobe: Time=%0d a=%b b=%b c=%b", $time, a, b, c);
    end
endmodule
~~~

### e.4 Generador de números random
Verilog proporciona varias funciones para generar números aleatorios, lo que es útil para pruebas y simulaciones. Las funciones incluyen:
- `$random`: Genera un número entero aleatorio.
- `$urandom`: Genera un número entero sin signo aleatorio.
- `$urandom_range(min, max)`: Genera un número entero sin signo aleatorio dentro de un rango especificado.

Ejemplo:
```verilog
integer rand_num;
initial begin
    rand_num = $random;
    $display("Random number: %0d", rand_num);
end
```

### e.5 Inicializar memoria desde un archivo
Para inicializar la memoria desde un archivo, Verilog proporciona tareas del sistema que leen datos de un archivo y los cargan en una matriz de memoria. Las tareas comunes incluyen:
- `$readmemh(filename, memory)`: Lee datos en formato hexadecimal desde un archivo y los carga en la memoria.
- `$readmemb(filename, memory)`: Lee datos en formato binario desde un archivo y los carga en la memoria.

Ejemplo:
```verilog
reg [7:0] memory [0:255]; // 256 bytes de memoria

initial begin
    $readmemh("memory_init.hex", memory);
end
```

### e.6 Archivo VCD (value changes dump file)
Un archivo VCD registra cambios en las señales durante la simulación, lo que es útil para la depuración y el análisis de la simulación. Para crear un archivo VCD, se usan las siguientes tareas del sistema:
- `$dumpfile(filename)`: Especifica el nombre del archivo VCD.
- `$dumpvars(level, list_of_variables)`: Especifica qué variables se deben registrar en el archivo VCD.
- `$dumpon` y `$dumpoff`: Controlan el inicio y la detención del registro de cambios.

Ejemplo:
```verilog
initial begin
    $dumpfile("simulation.vcd");
    $dumpvars(0, testbench);
end
```