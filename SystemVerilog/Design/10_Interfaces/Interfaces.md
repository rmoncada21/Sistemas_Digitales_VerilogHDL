# Interfaces

Las interfaces en SystemVerilog son una característica poderosa y flexible que permite agrupar señales relacionadas en una única entidad, lo que facilita la conectividad y el manejo de estas señales en módulos complejos. Además, las interfaces pueden incluir lógica y modports, lo que las hace mucho más versátiles que simplemente agrupar señales con wire o logic.

## a. Conceptos

**1. Desventajas de modulos de Verilog**

- Las declaraciones deben duplicarse en múltiples módulos.
- Los protocolos de comunicación deben duplicarse en varios módulos.
- Existe el riesgo de declaraciones incompatibles en diferesntes módulos.
- Un cambio en la especificación del diseño puede requerir modificaciones en múltiples módulos.

**2. Ventajas de interfaces de systemverilog**

Una interfaz:
- Permite agrupar un número de señales juntas y representarlas como un único puerto. Las declaraciones de las señales que componen la interfaz están contenidas en un solo lugar. 
- Cada módulo que utiliza estas señales tiene entonces un solo puerto del tipo interfaz, en lugar de muchos puertos con señales discretas.

**3. Contenidos de interfaces**

Las interfaces pueden encapsular todos los detalles de la comunicación entre los bloques de un diseño. Usando interfaces:

- Las señales discretas y los puertos para la comunicación pueden definirse en una ubicación, la interfaz.
- Los protocolos de comunicación pueden ser definidos en la interfaz.
- La verificación de protocolos y otras rutinas de verificación pueden ser integradas directamente en la interfaz.

Con Verilog, los detalles de comunicación deben ser duplicados en cada módulo que comparte un bus u otra arquitectura de comunicación. **SystemVerilog permite que toda la información sobre una arquitectura de comunicación y el uso de la misma sea definida en una única ubicación común.** Una interfaz puede contener declaraciones de tipos, tareas, funciones, bloques procedurales, bloques de programas y aserciones.

**4. Diferencias entre modulos e interfaces**

- una interfaz no puede contener jerarquía de diseño. A  diferencia de un módulo, una interfaz no puede contener instancias de módulos o primitivas que crearían un nuevo nivel de jerarquía de implementación. 
- una interfaz puede ser utilizada como un puerto de módulo, lo cual permite que las interfaces representen canales de comunicación entre módulos. Es ilegal usar un módulo en una lista de puertos. 
- una interfaz puede contener modports, los cuales permiten que cada módulo conectado a la interfaz vea la interfaz de manera diferente. 


## b. Declaraciones de interface

Sintácticamente, la definición de una interfaz es muy similar a la definición de un módulo. Una interfaz puede tener puertos, al igual que un módulo. Esto permite que señales externas a la interfaz, como un reloj o una línea de reset, sean llevadas a la interfaz y se conviertan en parte del conjunto de señales representadas por la interfaz. Las interfaces también pueden contener declaraciones de cualquier tipo de Verilog o SystemVerilog, incluyendo todos los tipos de variables, todos los tipos de red y tipos definidos por el usuario.


~~~verilog
interface main_bus (input logic clock, resetN, test_mode);
    wire [15:0] data;
    wire [15:0] address; 
    logic [ 7:0] slave_instruction;
    logic slave_request;
    logic bus_grant;
    logic bus_request;
    logic slave_ready;
    logic data_ready;
    logic mem_read;
    logic mem_write;
endinterface


/********************** Top-level Netlist ********************/
module top (input logic clock, resetN, test_mode);
    logic [15:0] program_address, jump_address;
    logic [ 7:0] instruction, next_instruction;
    main_bus bus ( // instance of an interface
        .clock(clock), // discrete signals are connected to the interce
        .resetN(resetN),
        .test_mode(test_mode)
    );

    processor proc1(
        // main_bus ports
        .bus(bus), // interface connection
        .jump_address(jump_address),  // other ports
        .instruction(instruction)
    );
endmodule
~~~

Los estilos simplificados de conexión de puertos de SystemVerilog, **.name** y **.\*** también pueden ser utilizados con conexiones de puertos de interfaz.

~~~verilog
/********************** Top-level Netlist ********************/
module top (input logic clock, resetN, test_mode);
            logic [15:0] program_address, jump_address;
            logic [ 7:0] instruction, next_instruction, data_b;

    main_bus bus            ( .* ); // .* port connections can significantly
    processor proc1         ( .* ); // reduce a netlist (compare to netlist in
    slave slave1            ( .* ); // example 10-2 on page 270).
    instruction_reg ir      ( .* );
    test_generator test_gen ( .* );
    dual_port_ram ram       ( .*, .data_b(next_instruction) );
endmodule
~~~

## c. Usando interfaces como puertos de modulos

En SystemVerilog, las interfaces no solo agrupan señales relacionadas, sino que también pueden ser utilizadas como puertos en módulos. Esto permite conectar fácilmente los módulos entre sí a través de una interfaz, simplificando el manejo de señales y mejorando la claridad del diseño. 

### c.1 Puertos de interfaz con nombres explícitos

Un puerto de interfaz explícitamente nombrado solo puede ser conectado a una interfaz del mismo nombre. 

Sintáxis:

> module module_name (interface_name port_name);

Ejemplo:
~~~verilog
interface chip_bus;
...
endinterface

module CACHE(
    chip_bus pins, // interface port
    input CLOCK
);
...
endmodule
~~~

### c.2 Puertos genéricos de interface

Un puerto de interfaz genérico define el tipo de puerto utilizando la palabra clave interface, en lugar de usar el nombre de un tipo específico de interface. Cuando el módulo es instanciado, cualquier interfaz puede ser conectada al puerto de interfaz genérico. 

Sintáxis:

> module module_name (interface port_name);

Ejemplo:

~~~verilog
module RAM(
    interface pins;
    input clock
);
~~~

## d. Instanciación y conexión de interfaces

Una instancia de una interfaz se conecta a un puerto de una instancia de módulo utilizando una conexión de puerto, de la misma manera que una red discreta se conectaría a un puerto de una instancia de módulo. Esto requiere que tanto la interfaz como los módulos a los que está conectada sean instanciados. 

Un puerto que se declara como interfaz, debe estar conectado a una instancia de interfaz o a otro puerto de interfaz. 

## e. Señales de referencia dentro de una interfaz

Dentro de un módulo que tiene un puerto de interfaz, las señales dentro de la interfaz deben ser accedidas utilizando el nombre del puerto, utilizando la siguiente sintaxis:

> port_name.internal_interface_signal_name

## f. Interface modports

Un modport se define dentro de una interfaz y especifica qué direcciones de acceso (lectura, escritura, etc.) tienen las señales y funciones para los módulos que usan esa interfaz. 

~~~verilog
interface bus_if;
    logic clk;
    logic reset;
    logic [7:0] addr;
    logic [7:0] data;

    // Definición de modports
    modport master (
        input clk, reset,
        output addr, data
    );

    modport slave (
        input clk, reset, addr,
        inout data
    );
endinterface
~~~

**`NOTA:`** Las definiciones de modport no contienen tamaños de vectores o tipos.

### f.1 Modport en la instancia de modulo

Cuando un módulo es instanciado y una instancia de una interfaz se conecta a un puerto de instancia de módulo, se puede especificar el modport específico de la interfaz. La conexión al modport se especifica como:

> instancia_interface_name.modport_name

~~~verilog
chip_bus bus; // instancia de la interface
primary i1 (bus.master); // uso del modport master
~~~

### f.2 Modport en la declaración de puerto del modulo

El modport específico de una interfaz que se va a utilizar puede especificarse directamente como parte de la declaración del puerto del módulo. El modport a ser conectado a la interfaz se especifica como:

> interface_name.modport_name

~~~verilog
module secondary(chip_bus.slave pins)
~~~

### f.3 Conectar sin especificar los modport a las interfaces

Cuando no se especifica un modport como parte de la conexión a la interfaz, se asume que todas las redes en la interfaz tienen una dirección bidireccional (inout), y que todas las variables en la interfaz son de tipo ref. 

### f.4 Restricción del acceso del módulo a las señales de la interfaz

Un módulo solo puede acceder directamente a las señales listadas en su definición de modport. Esto hace posible que algunas señales dentro de la interfaz estén completamente ocultas de ciertos módulos. 

## g. Task y functions dentro de interfaces

En SystemVerilog, las interfaces no solo agrupan señales, sino que también pueden contener tasks y functions. Estas tasks y functions pueden ser utilizadas por los módulos que acceden a la interfaz, proporcionando una forma organizada y modular de realizar operaciones complejas relacionadas con las señales de la interfaz.

### g.2 Métodos de interface

SystemVerilog permite declarar tareas y funciones dentro de una interfaz. Estas tareas y funciones se conocen como métodos de interfaz. 

~~~verilog
interface bus_if;
    logic clk;
    logic reset;
    logic [7:0] addr;
    logic [7:0] data;

    // Task para inicializar el bus
    task init();
        addr = 8'h00;
        data = 8'h00;
    endtask

    // Function para verificar si el bus está en un estado de reposo
    function logic is_idle();
        is_idle = (addr == 8'h00 && data == 8'h00);
    endfunction
endinterface
~~~

### g.3 Importar métodos de interface

Si la interfaz está conectada a través de un modport, el método debe especificarse utilizando la palabra clave import. 

**1. Importación usando el nombre task o function.**

> modport (import task_or_function_name);

~~~verilog
modport in(
    import Read,
    import parity_gen,
    input clock, resetN );
~~~

**2. Importación usando el prototipo de task o function.**

El segundo estilo de declaración de importación/import es especificar un prototipo completo de los argumentos de la tarea o función. 

> modport (import task task_name(task_formal_arguments));
> modport (import function function_name(function_formal_arguments));

~~~verilog
modport in (
    import task Read(input [63:0] data, output [31:0] address),
    import function parity_gen(input [63:0] data),input clock, resetN);
~~~

Un prototipo completo puede servir para documentar directamente los argumentos de la tarea o función como parte de la declaración de modport. 

### g.4 Exportat task y functions

Exportar tareas o funciones a través de interfaces en SystemVerilog **no es sintetizable.**

La declaración de exportación/**export** permite que un módulo exporte una tarea o función a una interfaz a través de un modport específico de la interfaz. También es posible exportar una tarea o función a una interfaz sin usar un modport, esto se realiza declarando un prototipo externo/**extern** de la tarea o función dentro de la interfaz. 

**`NOTA:`** Es ilegal exportar el mismo nombre de función desde dos módulos diferentes, o dos instancias del mismo módulo, hacia la misma interfaz. Es ilegal exportar el mismo nombre de tarea desde dos módulos diferentes, o dos instancias del mismo módulo, hacia la misma interfaz, a menos que se utilice una declaración externa fork ... join. 

## h. Usando bloques procedurales dentro de interface

Además de los métodos (tareas y funciones), las interfaces pueden contener bloques procedurales Verilog y asignaciones continuas. Esto permite que una interfaz contenga funcionalidades que pueden ser descritas usando bloques procedurales como always, always_comb, always_ff, always_latch, initial o final, y declaraciones assign. Una interfaz también puede contener bloques de programas de verificación. **Uno de los usos de los bloques procedurales dentro de interfaces es facilitar la verificación de un diseño.**

## i. Interfaces reconfigurables

Las interfaces pueden utilizar la redefinición de parámetros y declaraciones generate, de la misma manera que los módulos. Esto permite definir modelos de interfaz que pueden ser reconfigurados cada vez que se instancia una interfaz.

**1. Interfaces parametrizables**
Los parámetros se pueden utilizar en interfaces para hacer que los tamaños de vectores y otras declaraciones dentro de la interfaz sean reconfigurables. 

~~~verilog
interface bus_if #(parameter int DATA_WIDTH = 8);
    logic clk;
    logic reset;
    logic [DATA_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data;

    // Task para inicializar la interfaz
    task init();
        addr = '0;
        data = '0;
    endtask

endinterface

// Uso de la interface parametrizable
module master_device #(parameter int DATA_WIDTH = 16) (
    bus_if #(DATA_WIDTH) bus  // Instanciando la interfaz con un ancho de datos de 16 bits
);
    initial begin
        bus.init();  // Inicializa la interfaz
    end
endmodule
~~~

## j. Verificación con interfaces

Las interfaces permiten un paradigma diferente para la verificación. Con interfaces, los canales de comunicación pueden desarrollarse como interfaces de forma independiente de otros módulos. **Dado que una interfaz puede contener métodos para los protocolos de comunicación, la interfaz se puede probar y verificar de forma independiente del resto del diseño.** Los módulos que utilizan la interfaz pueden escribirse sabiendo que la comunicación entre módulos ya ha sido verificada.
