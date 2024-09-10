# Valores literales y tipos de datos incorporados en 

## a. Mejoras en las asignaciones de valores literales

En el lenguaje Verilog, un vector se puede llenar fácilmente con todos ceros, todos Xs (desconocido) o todos Zs (alta impedancia).

~~~verilog
parameter SIZE = 64;
reg [SIZE-1:0] data;

data = 0; // llena todos los bits de data con ceros
data = 'bz // llena todos los bits de data con Z
data = 'bx // llena todos los bits de data con X
~~~

SystemVerilog mejora las asignaciones de un valor literal de dos maneras:

- Se añade una sintáxis mas censilla que permite especificar el valor de llenado sin necesidad de especificar una base binario, octal o hexadecimal. 
- EL valor de llenado también puede ser un 1 lógico (en verilog no se podía).

~~~verilog
data = '0; // llena todos los bits hacia la izquierda con 0
data = '1; // llena todos los bits hacia la izquierda con 1 
data = 'z; // llena todos los bits hacia la izquierda con z
data = 'x; // llena todos los bits hacia la izquierda con x
~~~

Usando SystemVerilog, un vector de cualquier ancho puede llenarse con todos unos sin codificar el ancho del valor a asignar o usar operaciones.

## b. Mejoras en la MACRO `define

SystemVerilog extiende la capacidad del macro de sustitución de texto definido por `define de Verilog **permitiendo que el texto del macro incluya ciertos caracteres especiales.**

La sustitución de argumentos macro dentro de cadenas en SystemVerilog se refiere a la capacidad de insertar argumentos de una macro dentro de una cadena de texto cuando se expande esa macro. Esto es útil para generar mensajes de depuración, nombres de señales, o cualquier otro texto donde necesites combinar una cadena con valores o identificadores específicos.

### b.1 Sustitución de argumentos macro dentro de cadenas

En SystemVerilog, cuando defines una macro con argumentos, puedes incluir esos argumentos dentro de una cadena de texto. Cuando la macro es invocada, los argumentos pasados a la macro se sustituyen directamente en la cadena.

**Ejemplo básico**

Supongamos que tienes la siguiente macro definida:

```verilog
`define PRINT_MSG(msg) $display("Mensaje: %s", msg)
```

En este ejemplo:
- \``define PRINT_MSG(msg)` define una macro llamada `PRINT_MSG` que toma un argumento `msg`.
- Dentro de la macro, la cadena `"Mensaje: %s"` se combina con el argumento `msg` cuando la macro es invocada.

**Uso de la macro:**

```verilog
initial begin
    `PRINT_MSG("Inicio del sistema")
end
```

Cuando se invoca esta macro, el preprocesador sustituye la macro con el código expandido:

```verilog
$display("Mensaje: %s", "Inicio del sistema");
```

**Ejemplo más avanzado**

Puedes incluir más argumentos o usarlos de maneras más complejas dentro de la macro. Aquí un ejemplo más avanzado:

```verilog
`define ASSERT_EQ(sig, exp) \
    if (sig !== exp) \
        $display("ERROR: La señal %s no es igual al valor esperado %0d, valor actual: %0d", `"sig`", exp, sig)
```

En este caso:
- La macro `ASSERT_EQ` toma dos argumentos: `sig` (la señal) y `exp` (el valor esperado).
- Dentro de la cadena de texto de la macro, `sig` se inserta entre comillas como parte de una cadena para mostrar el nombre de la señal.
- Es necesario incluir la barra invertida **\\** al final de cada línea de la macro **si la macro se extiende a múltiples líneas** en SystemVerilog. Esto se hace para indicar al preprocesador que la macro continúa en la línea siguiente.

**Uso de la macro:**

```verilog
logic [3:0] data;
initial begin
    data = 4'b1010;
    `ASSERT_EQ(data, 4'b1111)
end
```

Esto se expandirá a:

```verilog
if (data !== 4'b1111) 
    $display("ERROR: La señal data no es igual al valor esperado 15, valor actual: 10");
```

**Notas importantes:**
- **Escapado de comillas**: Si se necesita insertar un argumento dentro de una cadena con comillas, debes usar el escape de comillas **\`** para que el preprocesador lo entienda correctamente.
- **Concatenación**: SystemVerilog también permite concatenar cadenas y argumentos dentro de las macros, proporcionando gran flexibilidad al definir mensajes dinámicos.

### b.2 Construcción nombres de identificadores a partir de MACROS

En SystemVerilog, puedes construir nombres de identificadores a partir de macros utilizando la funcionalidad de concatenación y generación de identificadores dinámicos. Esto es útil cuando necesitas crear identificadores o nombres de señales en función de ciertas condiciones o parámetros, como en el caso de generar nombres para señales o módulos que se adaptan a diferentes configuraciones.

En el siguiente ejemplo, se necesita definir una variable bit de 2 estados y una red wand con nombres similares, y una asignación continua de la variable a la red:

En el código fuente sin sustitución de texto, estas declaraciones podrían:
~~~verilog
bit d00_bit; wand d00_net = d00_bit;
bit d01_bit; wand d01_net = d01_bit;

... // repeat 60 more times, for each bit

bit d62_bit; wand d62_net = d62_bit;
bit d63_bit; wand d63_net = d63_bit;
~~~
Utilizando las mejoras de SystemVerilog en define, estas declaraciones pueden simplificarse así:

~~~verilog
`define TWO_STATE_NET(name) bit name``_bit; \
    wand name``_net = name``_bit;

`TWO_STATE_NET(d00)
`TWO_STATE_NET(d01)

...

`TWO_STATE_NET(d62)
`TWO_STATE_NET(d63)
~~~

## c. SystemVerilog Variables

### c.1 Tipos de Objetos y Datos

#### 1. Tipos de Datos en Verilog

Verilog ofrece tipos de datos orientados al hardware, divididos en variables y redes, cada uno con comportamientos específicos en simulación y síntesis para representar el comportamiento de conexiones físicas en un chip o sistema.

- **Variables en Verilog**: Las variables como `reg`, `integer`, y `time` pueden representar cuatro valores lógicos por bit: `0`, `1`, `Z` (alta impedancia) y `X` (indefinido).
- **Tipos de Redes en Verilog**: Las redes como `wire`, `wor`, `wand`, y otras pueden representar 120 valores diferentes por bit (que incluyen los cuatro estados lógicos y múltiples niveles de fuerza), junto con funciones especiales para la resolución lógica.

#### 2. Tipos de Datos en SystemVerilog

En Verilog, no existe una distinción clara entre los tipos de señales y los valores que pueden tener; todas las señales utilizan valores de 4 estados (`0`, `1`, `Z`, `X`). SystemVerilog introduce una diferenciación más clara:

- **Type**: Define si una señal es una red (e.g., `wire`, `wand`) o una variable (e.g., `reg`, `integer`). SystemVerilog introduce nuevos tipos de variables como `byte` e `int`, pero no añade nuevos tipos de redes.
- **Data Type**: Especifica el sistema de valores que una señal puede adoptar:
  - **2 estados**: Representado por el tipo `bit` (valores `0` y `1`).
  - **4 estados**: Representado por el tipo `logic` (valores `0`, `1`, `Z`, `X`).

En SystemVerilog-2005, las variables pueden ser de 2 o 4 estados, pero las redes solo pueden ser de 4 estados.

### c.2 Variables de 4-Estados en SystemVerilog

En Verilog, el tipo `reg` se utiliza como una variable de propósito general para modelar el comportamiento del hardware en bloques procedurales como `initial` y `always`. Aunque el término "reg" podría sugerir la implicación de un registro de hardware, en realidad no hay una correlación directa entre una variable `reg` y el hardware que se inferirá.

SystemVerilog introduce la palabra clave `logic`, que es más intuitiva, para representar un tipo de datos centrado en hardware de propósito general. Algunos ejemplos de declaraciones utilizando `logic`:

~~~verilog
logic resetN;         // Variable de 1 bit
logic [63:0] data;    // Bus de 64 bits
logic [0:7] array [0:255]; // Array de 8 bits con 256 elementos
~~~

La palabra clave **logic** indica que la señal puede tener valores de 4 estados. También es posible declarar variables explícitamente utilizando `var logic`, aunque la funcionalidad es la misma que con `logic` a secas:

~~~verilog
var logic resetN; // Funciona igual que 'logic resetN', pero explicita que es una variable.
~~~

### c.3 Variables de 2-Estados en SystemVerilog

SystemVerilog introduce nuevos tipos de datos de 2 estados, adecuados para modelar a niveles más abstractos que RTL (Register-Transfer Level).

- **`bit`** — Entero de 1 bit con 2 estados (`0` y `1`).
- **`byte`** — Entero de 8 bits con 2 estados, similar al `char` en C.
- **`shortint`** — Entero de 16 bits con 2 estados, similar al `short` en C.
- **`int`** — Entero de 32 bits con 2 estados, similar al `int` en C.
- **`longint`** — Entero de 64 bits con 2 estados, similar al `long long` en C.

#### 1. Uso de Tipos de Datos Similares a C

Estos tipos de datos de 2 estados son ideales para modelar buses y otros componentes en niveles más abstractos, así como para la interacción entre modelos Verilog y modelos en C o C++ a través de la Interfaz de Programación Directa (DPI). También son útiles en la implementación de bucles `for` y otros constructos de control.

#### 2. Semántica de Simulación para Variables de 2 y 4-Estados

Las variables de 4 estados como `reg`, `logic`, e `integer` comienzan la simulación con todos los bits en `X`. Por otro lado, las variables de 2 estados inician la simulación con un valor lógico de `0`, ya que no pueden almacenar valores `X`. Por esta razón, los tipos de 4 estados son preferibles para representar modelos RTL sintetizables.

#### 3. Otros Tipos de Datos Abstractos

SystemVerilog también añade el tipo `void` para indicar ausencia de almacenamiento, y `shortreal` que representa un punto flotante de precisión simple de 32 bits, equivalente a `float` en C. Sin embargo, los tipos `real` y `shortreal` no son sintetizables.

### c.4 Variables Explícitas e Implícitas y Tipos Net

En SystemVerilog, un tipo de datos de 4 estados se representa con la palabra clave `logic`, mientras que un tipo de datos de 2 estados se representa con `bit`. Si estos tipos se utilizan sin especificar explícitamente si son una variable o una red, se infiere que son variables implícitas.

~~~verilog
logic [7:0] busA;  // Infiere una variable de 4 estados
bit [31:0] busB;   // Infiere una variable de 2 estados
~~~

La palabra clave `var` no altera el comportamiento de una variable en simulación o síntesis, pero ayuda a que el código sea más auto-documentado, mejorando su legibilidad y mantenibilidad, especialmente al usar tipos definidos por el usuario:

~~~verilog
typedef enum bit {FALSE, TRUE} bool_t;
var bool_t c; // Variable definida por el usuario
~~~

También es posible declarar una variable utilizando `var` sin especificar un tipo de dato explícito. En este caso, se infiere que la variable es de tipo `logic`.

~~~verilog
var [7:0] d; // Se infiere una variable de tipo 'logic' de 8 bits
~~~

### c.5 Directrices de Síntesis

Tanto los tipos de datos de 4 estados como `logic`, como los tipos de 2 estados como `bit`, `byte`, `shortint`, `int`, y `longint` son sintetizables. Los compiladores de síntesis tratan los tipos de 2 estados y 4 estados de manera similar, pero el uso de tipos de 2 estados impacta principalmente en la simulación.

## d. Uso de tipos de datos de 2 estados en modelos RTL

Los tipos de 2 estados permiten modelar diseños a un nivel abstracto, donde los valores de tres estados rara vez son necesarios, y donde las condiciones del circuito que pueden llevar a valores desconocidos o impredecibles, representados por una lógica X, no pueden ocurrir.

### d.1 2-state type characteristics

Verilog es un lenguaje de tipado laxo, y esta característica también es válida para los tipos de 2 estados de SystemVerilog. Por lo tanto, **es posible asignar un valor de 4 estados a un tipo de 2 estados**. Cuando esto ocurre, el valor de 4 estados se mapea a un valor de 2 estados como se muestra en la siguiente tabla:

| **4-state** | **2-state** |
|-------------|-------------|
| 0           |      0      |
| 1           |      1      |
| Z           |      0      |
| x           |      0      |


### d.2 Modos de Simulación de 2 Estados vs. Tipos de Datos de 2 Estados en SystemVerilog

#### Optimización y Rendimiento

- **Modos de Simulación de 2 Estados**: Algunos simuladores permiten un modo de simulación de 2 estados (sin `Z` ni `X`) para optimizar el rendimiento. Esto puede acelerar las simulaciones al reducir la complejidad de las estructuras de datos y los algoritmos de simulación. Sin embargo, esto suele aplicarse globalmente a todos los archivos y puede ser complicado mezclar lógicas de 2 y 4 estados dentro del mismo entorno de simulación.
  
- **Tipos de Datos de 2 Estados en SystemVerilog**: SystemVerilog introduce tipos de datos como `bit` que son inherentemente de 2 estados (`0` y `1`). Estos tipos permiten una optimización similar en simulación, pero ofrecen ventajas adicionales al ser parte del estándar, proporcionando una forma consistente y estandarizada de especificar qué partes del diseño usan lógica de 2 estados y cuáles usan lógica de 4 estados.

#### Consistencia y Estándares

- **Mapeo de Valores de 4 Estados a 2 Estados**: En simuladores que utilizan modos de 2 estados, la conversión de valores de 4 estados (`Z` o `X`) a 2 estados (`0` o `1`) no está estandarizada y puede variar entre herramientas. Por ejemplo, algunos simuladores pueden mapear `X` a `0`, mientras que otros lo pueden mapear a `1`. Esto puede llevar a resultados inconsistentes en simulaciones entre diferentes herramientas.
  
- **Tipos de 2 Estados de SystemVerilog**: Ofrecen un algoritmo de mapeo estandarizado que asegura resultados consistentes en diferentes herramientas de simulación. Esto ayuda a evitar discrepancias en los resultados de simulación.

#### Inicialización de Variables

- **Modos de 2 Estados Propietarios**: En simuladores que utilizan modos de 2 estados, el valor inicial de las variables puede ser `0` en lugar de `X`. Esto puede causar diferencias en los eventos de simulación, ya que algunos simuladores pueden generar eventos al inicializar variables de 4 estados a `0` en lugar de `X`, mientras que otros no. Esto puede afectar la propagación de eventos en el diseño.
  
- **Variables de 2 Estados en SystemVerilog**: Están diseñadas para comenzar con un valor de `0` sin generar un evento de simulación, proporcionando un comportamiento consistente y predecible en todas las herramientas de software.

#### Declaraciones `casez` y `casex`

- **Modos de 2 Estados**: La forma en que se manejan las declaraciones `casez` y `casex` puede variar en simuladores con modos de 2 estados, ya que el tratamiento de `Z` y `X` no está estandarizado. Esto puede llevar a comportamientos diferentes dependiendo de la herramienta utilizada.
  
- **SystemVerilog**: Los tipos de 2 estados (`bit` y `logic`) tienen semánticas bien definidas para las declaraciones `casez` y `casex`, asegurando un comportamiento determinista y consistente entre diferentes herramientas de simulación.

### d.3 Usando tipos de 2-states en instrucciones case.

En el nivel abstracto de modelado RTL, a menudo se utiliza la lógica X como una bandera dentro de un modelo para mostrar una condición inesperada.

~~~verilog
case (State)
    RESET:      Next = WAITE;
    WAITE:      Next = LOAD;
    LOAD:       Next = DONE;
    DONE:       Next = WAITE;
    default:    Next = 4’bx; // unknown state
endcase
~~~

En síntesis, la asignación predeterminada de lógica X se interpreta como una bandera especial que indica que, para cualquier condición no cubierta por los otros elementos de selección de casos, el valor de salida es "don't care" (no importa). 

En simulación, la asignación predeterminada de lógica X sirve como un error evidente en tiempo de ejecución, en caso de que ocurra un valor de expresión de caso inesperado

## e. Flexibilidad en las reglas de tipo (terminar depues)

En Verilog, los tipos de datos como `reg` y `wire` tienen reglas estrictas sobre dónde y cómo pueden usarse. Esta distinción puede complicar la evolución de un diseño a medida que pasa de un nivel de abstracción alto a uno más detallado, porque es posible que debas cambiar el tipo de dato dependiendo del contexto.

### e.1 Reglas en Verilog:
- **`reg`**: Se utiliza para almacenar valores dentro de bloques procedurales (`initial`, `always`), como una variable que mantiene su valor hasta que se le asigna otro.
- **`wire`**: Se usa para interconectar elementos, similar a una conexión física. Es ideal para asignaciones continuas y conexiones entre módulos.

### e.2 Relajación de las Reglas en SystemVerilog:
SystemVerilog suaviza estas reglas, permitiendo que una variable se use en una gama más amplia de contextos, facilitando el diseño y la evolución de modelos sin necesidad de cambiar constantemente el tipo de dato. Sin embargo, aún existen algunas restricciones para mantener la coherencia y evitar errores de diseño.

**Reglas en SystemVerilog:**
- **Variables**: Pueden ser asignadas en un solo bloque procedural (`initial`, `always`, `always_comb`, `always_ff`, `always_latch`), mediante una única asignación continua, o desde la salida de un módulo o primitiva.
  - **Asignaciones múltiples**: SystemVerilog no permite que una variable reciba valores de múltiples fuentes simultáneamente, excepto si se trata de múltiples bloques `always`. Esto se hace para evitar conflictos y errores, ya que las variables no tienen una forma incorporada de resolver conflictos de valores (como lo haría un tipo de red).
  - **Compatibilidad**: SystemVerilog permite asignaciones desde múltiples bloques `always` por compatibilidad con Verilog, pero introduce bloques procedurales más específicos (`always_comb`, `always_ff`, `always_latch`) que restringen una variable a tener solo una fuente.
  
- **Redes (Nets)**: A diferencia de las variables, las redes (como `wire`) sí pueden tener múltiples fuentes, lo que es útil para buses de datos y señales que deben ser impulsadas por varios dispositivos.

**Importancia de las Restricciones:**
Las restricciones en SystemVerilog están diseñadas para prevenir errores de diseño, asegurando que una señal tiene una fuente clara y única, a menos que esté declarada como una red, en cuyo caso las múltiples fuentes están permitidas y resueltas de manera específica por el tipo de red.

Esto hace que SystemVerilog sea más flexible que Verilog en términos de modelado, pero sin perder el control necesario para asegurar que los diseños sean correctos y predecibles.

Aquí tienes algunos ejemplos que ilustran cómo se aplican las reglas de relajación de tipos en SystemVerilog comparado con Verilog. 

**Ejemplo 1: Uso de Variables en Bloques Procedurales**

**En Verilog:**
```verilog
module ejemplo_verilog;
    reg a;
    wire b;

    initial begin
        a = 1'b1; // Correcto: 'a' es de tipo reg
    end

    assign b = a; // Correcto: 'b' es de tipo wire
endmodule
```
En este ejemplo de Verilog, `a` debe ser de tipo `reg` porque es asignado dentro de un bloque `initial`, y `b` debe ser de tipo `wire` porque se usa en una asignación continua.

**En SystemVerilog:**
```verilog
module ejemplo_systemverilog;
    logic a;

    initial begin
        a = 1'b1; // Correcto: 'a' es de tipo logic
    end

    assign a = 1'b0; // Error: 'a' ya es asignado en el bloque initial
endmodule
```
En SystemVerilog, la variable `a` puede ser declarada como `logic` (un tipo de dato más general que puede usarse en ambos contextos). Sin embargo, no se puede asignar `a` tanto dentro del bloque `initial` como en una asignación continua al mismo tiempo; esto generaría un error.

**Ejemplo 2: Uso de `always_comb` para Restringir Asignaciones**

**En Verilog:**
```verilog
module ejemplo_verilog;
    reg [3:0] sum;
    reg [3:0] a, b;

    always @(*) begin
        sum = a + b; // Correcto: 'sum' es de tipo reg
    end
endmodule
```
En este caso, `sum` debe ser de tipo `reg` porque se asigna dentro de un bloque procedural `always`.

**En SystemVerilog:**
```verilog
module ejemplo_systemverilog;
    logic [3:0] sum;
    logic [3:0] a, b;

    always_comb begin
        sum = a + b; // Correcto: 'sum' es de tipo logic
    end
endmodule
```
Aquí, `sum` se declara como `logic`, lo que es válido en SystemVerilog. Al usar `always_comb`, SystemVerilog garantiza que `sum` solo pueda ser asignado dentro de este bloque, reforzando la regla de una única fuente de asignación para `sum`.

**Ejemplo 3: Uso de Múltiples Fuentes**

**En Verilog:**
```verilog
module ejemplo_verilog;
    reg a;
    wire b;

    always @(posedge clk) begin
        a = 1'b1; // Correcto: 'a' es de tipo reg
    end

    assign b = a; // Correcto: 'b' es de tipo wire
endmodule
```
En Verilog, `a` se asigna en un bloque `always`, y `b` es un `wire` que recibe el valor de `a`. Si intentas asignar `a` en otro bloque `always`, podría causar errores si `a` es también usado en un contexto diferente.

**En SystemVerilog:**
```verilog
module ejemplo_systemverilog;
    logic a;
    logic b;

    always_ff @(posedge clk) begin
        a = 1'b1; // Correcto: 'a' es de tipo logic y está en always_ff
    end

    always_comb begin
        b = a; // Correcto: 'b' es de tipo logic y está en always_comb
    end
endmodule
```
Aquí, `a` y `b` son ambos de tipo `logic`. `a` es asignado dentro de `always_ff` (ideal para flip-flops), y `b` es asignado dentro de `always_comb` (ideal para lógica combinacional). SystemVerilog permite esta separación clara, garantizando que no se mezclarán asignaciones procedurales y continuas para las mismas señales.

## f. Modificadores: signed and unsigned

En SystemVerilog, los tipos de datos pueden ser **signed** (con signo) o **unsigned** (sin signo). Esto afecta cómo se interpretan los bits de una variable, especialmente en operaciones aritméticas.

### f.1 **Tipos `unsigned`**

- **Descripción:** Los tipos `unsigned` solo representan valores positivos. Todos los bits se interpretan como parte del valor numérico sin signo.
- **Por defecto:** En Verilog y SystemVerilog, las variables de tipo `logic` y `bit` son `unsigned` por defecto.
- **Ejemplo:**

```verilog
logic [7:0] a;   // 8-bit unsigned
```

Aquí, `a` puede tener valores desde `0` hasta `255` (`8'b00000000` a `8'b11111111`).

### f.2 **Tipos `signed`**

- **Descripción:** Los tipos `signed` pueden representar valores tanto positivos como negativos. El bit más significativo (MSB) se interpreta como el bit de signo: `0` para positivo y `1` para negativo.
- **Por defecto:** EN SystemVerilog, las variables por de tipo `byte`, `shortint`, `int` y `longint` son `signed` por defecto.
- **Sintaxis:** Puedes declarar una variable como `signed` utilizando la palabra clave `signed`.
- **Ejemplo:**

```verilog
logic signed [7:0] b;   // 8-bit signed
```

Aquí, `b` puede tener valores desde `-128` (`8'b10000000`) hasta `127` (`8'b01111111`).

### f.3 **Diferencias en Operaciones Aritméticas**

- **`unsigned`:** Cuando se realiza una operación aritmética en un tipo `unsigned`, todos los bits se tratan como parte del valor numérico positivo. No hay ningún bit de signo, por lo que una adición, sustracción, etc., se realiza directamente sobre todos los bits.

    ```verilog
    logic [7:0] x = 8'd250;
    logic [7:0] y = 8'd10;
    logic [7:0] z;

    assign z = x + y;  // z = 4 (overflow)
    ```

- **`signed`:** En operaciones aritméticas con `signed`, el bit más significativo (MSB) se considera el bit de signo. Esto cambia cómo se realiza la operación, ya que el resultado debe respetar el signo.

    ```verilog
    logic signed [7:0] m = -8'd5;   // m = 8'b11111011 (-5 en decimal)
    logic signed [7:0] n = 8'd10;   // n = 8'b00001010 (10 en decimal)
    logic signed [7:0] p;

    assign p = m + n;  // p = 8'b11111101 (-5 + 10 = 5 en decimal)
    ```

### f.4 **Conversión entre `signed` y `unsigned`**

- **Conversión Implícita:** Al mezclar `signed` y `unsigned` en una operación, SystemVerilog puede realizar conversiones implícitas, lo que puede llevar a resultados inesperados si no se tiene cuidado.

    ```verilog
    logic [7:0] a = 8'd128;
    logic signed [7:0] b = -8'd1;

    logic [7:0] result_unsigned = a + b; // result_unsigned = 8'b10000000 + 8'b11111111 = 8'b01111111 (255 unsigned)
    logic signed [7:0] result_signed = a + b; // result_signed = 8'b10000000 + 8'b11111111 = 8'b00000000 (0 signed)
    ```

- **Conversión Explícita:** Es posible convertir explícitamente entre `signed` y `unsigned` utilizando el operador de conversión `$signed` ó`$unsigned`:

    ```verilog
    logic [7:0] unsigned_value = 8'b11111111;  // 255 en unsigned
    logic signed [7:0] signed_value;

    assign signed_value = $signed(unsigned_value);  // signed_value = -1 en signed
    ```

    Similarmente, se puede convertir de `signed` a `unsigned`:

    ```verilog
    logic signed [7:0] signed_value = -8'd1;  // -1 en signed
    logic [7:0] unsigned_value;

    assign unsigned_value = $unsigned(signed_value);  // unsigned_value = 255 en unsigned
    ```

### f.5 **Ejemplo Práctico**

```verilog
module signed_unsigned_example;
    logic [3:0] u = 4'b1101;  // unsigned 13
    logic signed [3:0] s = 4'b1101;  // signed -3

    logic signed [4:0] result_signed;
    logic [4:0] result_unsigned;

    initial begin
        result_signed = s + u;  // signed operation: -3 + 13 = 10
        result_unsigned = u + u;  // unsigned operation: 13 + 13 = 26

        $display("Signed result: %0d", result_signed);
        $display("Unsigned result: %0d", result_unsigned);
    end
endmodule
```

En este ejemplo:
- `u` es `unsigned` y representa `13`.
- `s` es `signed` y representa `-3`.
- Las operaciones aritméticas producen resultados diferentes según el tipo de datos.

## g. Variables estáticas y automáticas (static and automatics)

Estas especificaciones determinan el tiempo de vida y el ámbito (scope) de las variables, es decir, cuándo se crean y destruyen, y en qué contextos pueden ser utilizadas.

**`Nota: `**Es importante señalar que las variables declaradas a nivel de módulo no pueden ser declaradas explícitamente como static o automatics. A nivel de módulo, todas las variables son estáticas..

**Variables static**

- **`Tiempo de Vida:`** Una variable static se crea una vez cuando se carga el diseño (antes de que comience la simulación) y persiste durante toda la ejecución del programa.

- **`Ámbito:`** Aunque se declare dentro de una función, tarea, o bloque, la variable static conserva su valor entre llamadas sucesivas a la función o tarea.

- **`Uso Común:`** Se utilizan cuando se necesita conservar el valor de una variable entre diferentes llamadas o iteraciones, como en contadores o en la implementación de registros de estado.

**Variables automatics**

- **`Tiempo de vida:`** Una variable automatic se crea cada vez que se ingresa al bloque o función en el que está declarada y se destruye cuando se sale del bloque o función. Es una variable de duración temporal, similar a las variables locales en la mayoría de los lenguajes de programación.

- **`Ámbito`**: La variable automatic es local a la instancia de la función o tarea en la que fue declarada, y no conserva su valor entre diferentes llamadas o invocaciones.

- **`Uso Común`**: Se utilizan cuando se necesita que cada invocación de una función o tarea tenga su propio conjunto de variables independientes.

### g.1 Inicialización de variables static y automatics

La inicialización en línea de variables en SystemVerilog es una característica que permite asignar un valor inicial a una variable en el mismo momento en que se declara. Esto es útil para garantizar que la variable tenga un valor conocido desde el inicio de su vida, evitando que contenga datos no definidos.

Verilog solo permite la inicialización en línea de variables para aquellas declaradas a nivel de módulo. Las variables declaradas en tareas (tasks), funciones y bloques begin...end o fork...join no pueden tener un valor inicial especificado como parte de la declaración de la variable.

**`Notas: `** 
- Una variable declarada en una tarea o función no automática será estática por defecto. 

- Una variable declarada explícitamente como automática en una tarea o función no automática será creada dinámicamente cada vez que se entre en la tarea o función, y solo existirá hasta que la tarea o función salga.

- Una variable declarada en una tarea o función automática será automática por defecto. El almacenamiento para la variable se creará dinámicamente cada vez que se entre en la tarea o función, y se destruirá cada vez que la tarea o función salga.

Considerar el siguiente ejemplo:

~~~verilog
function int count_ones (input [31:0]);
    logic [31:0] count = 0; // inicializado una vez
    logic [31:0] temp = data; // inicializado una vez

    for (int i=0; i<32; i++) begin
        if (temp[0]) count++;
        temp >>=1;
    end
    return(count);
endfunction
~~~

- La función count_ones es estática, por lo tanto, todo el almacenamiento dentro de la función también es estático, a menos que se declare explícitamente como automático. 

- En este ejemplo, la variable count tendrá un valor inicial de 0 la primera vez que se llame a la función. Sin embargo, no se reinicializará la próxima vez que se llame. 
- En cambio, la variable estática retendrá su valor de la llamada anterior, lo que resultará en un recuento erróneo. 
- La variable estática temp tendrá un valor de 0 la primera vez que se llame a la función, en lugar del valor de data. Esto se debe a que la inicialización en línea ocurre antes del tiempo cero, y no cuando se llama a la función.

Corrección del ejemplo:

~~~verilog
function int count_ones (input [31:0]);
    automatic logic [31:0] count = 0; // inicializado una vez
    automatic logic [31:0] temp = data; // inicializado una vez

    for (int i=0; i<32; i++) begin
        if (temp[0]) count++;
        temp >>=1;
    end
    return(count);
endfunction
~~~

Una variable declarada explícitamente como automática en una tarea o función no automática será creada dinámicamente cada vez que se entre en la tarea o función, y solo existirá hasta que la tarea o función salga. Un valor inicial en línea se asignará cada vez que se llame a la tarea o función. La siguiente versión de la función count_ones funcionará correctamente, porque las variables automáticas count y temp se inicializan cada vez que se llama a la función:

### g.2 Synthesis guidelines

- Para ser sintetizadas en un modelo de hardware, las variables automáticas deben utilizarse únicamente para representar almacenamiento temporal que no se propaga fuera de la tarea, función o bloque procedural.

- La inicialización en línea de variables automáticas es sintetizable.

- La inicialización en línea de variables declaradas con el calificador const también es sintetizable. 

### g.3 Guía para el uso de variables statics y automatics

- **En un bloque always o initial, usa variables estáticas si no hay inicialización en línea, y variables automáticas si hay inicialización en línea.** Usar variables automáticas con inicialización en línea dará el comportamiento más intuitivo, ya que la variable se reinicializará cada vez que se vuelva a ejecutar el bloque.

- Si una tarea o función debe ser reentrante, debe ser automática.
Las variables también deben ser automáticas, a menos que haya
una razón específica para mantener el valor de una llamada a la
siguiente.

- **Si una tarea o función representa el comportamiento de una sola pieza de hardware**, y por lo tanto no es reentrante, **debe declararse como estática**, y todas las variables dentro de la tarea o función deben ser estáticas.
 
## h. Inicialización de variables determinísticas

La inicialización determinística de variables se refiere a la práctica de garantizar que las variables en un programa o en un diseño de hardware se inicialicen a un valor conocido y predecible, sin depender de valores aleatorios, indefinidos o del estado previo de la ejecución. En otras palabras, el valor inicial de la variable es siempre el mismo cada vez que se ejecuta el código o se sintetiza el diseño, independientemente de las condiciones externas o del historial de ejecución.

### h.1 Inicialiación determinística

**1. Verilog-2001: Inicialiación de variables**

Verilog define que la semántica de la inicialización en línea de variables es exactamente la misma que si el valor inicial se hubiera asignado en un bloque procedural inicial. Esto significa que la inicialización en línea ocurrirá en un orden no determinístico, en conjunción con la ejecución de eventos en otros bloques procedurales iniciales y siempre que se ejecuten en el tiempo de simulación cero.

~~~verilog
integer i = 5; // declara e inicializa i
integer j;  // declara e inicializa j

initial 
    j = 1; // inicializa j al valor de i
~~~

En este ejemplo, parecería intuitivo esperar que i se inicialice primero, y por lo tanto, j se inicialice con un valor de 5. Sin embargo, el orden de eventos no determinista especificado en el estándar de Verilog no garantiza esto. Según la especificación del estándar de Verilog, es posible que a j se le asigne el valor de i antes de que i haya sido inicializado, lo que significaría que j recibiría un valor de X en lugar de 5.

**2. SystemVerilog: Orden de inicialiación**

**SystemVerilog define que todos los valores iniciales en línea serán evaluados antes de la ejecución de cualquier evento al inicio del tiempo de simulación cero.** Esto garantiza que cuando los bloques procedimentales initial o always lean variables con inicialización en línea, se leerá el valor inicializado. Este comportamiento determinista elimina la ambigüedad que puede surgir en el estándar Verilog.

Considerar el siguiente ejemplo:
~~~verilog
logic resetN = 0; // declaración e inicialización de reset

always @(posedge clock, negedge resetN)
    if (!resetN) coutn <=0; // activar low reset
    else count <= count +1;
~~~

Utilizando la semántica no determinística de  Verilog, pueden ocurrir dos escenarios:

- Un simulador podría activar primero el bloque procedural always, antes de inicializar la variable resetN. Entonces, el bloque procedural always estará observando activamente el siguiente evento de transición positiva en el reloj (clock) o evento de transición negativa en resetN. Luego, aún en el tiempo de simulación cero, cuando resetN se inicializa a 0, lo que resulta en una transición de X a 0, el bloque procedural always activado detectará el evento y reiniciará el contador en el tiempo de simulación cero.

- Alternativamente, según la semántica de Verilog, un simulador podría ejecutar la inicialización de resetN antes de que se active el bloque procedural always. Luego, aún en el tiempo de simulación cero, cuando se activa el bloque procedural always, éste se volverá sensible al siguiente evento de transición positiva en el clock o evento de transición negativa en resetN. Dado que la inicialización de resetN ya ha ocurrido en el orden de eventos, el contador no se activará en el tiempo cero, sino que esperará hasta el siguiente flanco positivo del clock o flanco negativo de resetN.

SystemVerilog elimina este posibilidad no determinita y asegura que la inicialización en línea ocurra primero, lo que significa que solo el segundo escenario ocurra. 

### h.2 Inicialización de entradas asincronas de lógica secuencial
Análisis de código escrito en Verilog. 

En el siguiente ejemplo, el contador tiene una entrada de reset asíncrona. El reset es activo en bajo, lo que significa que el contador debería resetearse en el momento en que resetN transicione a 0. Para resetear el contador en el tiempo de simulación cero, la entrada resetN debe transicionar a lógica 0. Si resetN se declara como un tipo de dato de 2 estados, como bit, como en el ejemplo del banco de pruebas anterior, su valor inicial por defecto es lógica 0. La primera prueba en el banco de pruebas es activar el reset colocando resetN en 0. Sin embargo, dado que resetN es un tipo de dato de 2 estados, su valor inicial por defecto es 0. La primera prueba no provocará un evento de simulación en resetN, y por lo tanto, la lista de sensibilidad del modelo del contador detectar un cambio en resetN y activar el bloque procedural para reiniciar el contador. 

~~~verilog
module counter (
    input wire clock, 
    input wire resetN,
    output logic [15:0] count
);

    always @(posedge clock, negedge resetN)
    if (!resetN) 
        count <= 0; // active low reset
    else 
        count <= count + 1;

endmodule

module test;
    wire [15:0] count;
    bit clock;
    bit resetN = 1; // initialize reset to inactive value

    counter dut (clock, resetN, count);

    always #10 clock = ~clock;

    initial begin
        resetN = 0; // assert active-low reset at time 0
        #2 resetN = 1; // de-assert reset before posedge of clock
        $display("\n count=%0d (expect 0)\n", count);
        #1 $finish;
    end
endmodule
~~~
Para asegurar que se produzca un cambio en resetN cuando se establece en 0, resetN se declara con una inicialización en línea a lógica 1, que es el estado inactivo de reset.

> bit resetN = 1; // inicializar reset

Siguiendo las reglas semánticas de Verilog, esta inicialización en línea se ejecuta durante el tiempo de simulación cero, en un orden no determinista junto con otras asignaciones ejecutadas en el tiempo cero. En el ejemplo anterior, son posibles dos órdenes de eventos:

- La inicialización en línea podría ejecutarse primero, estableciendo resetN en 1, seguido de la asignación procedural que establece resetN en 0. Se producirá una transición a 0, y al final del paso de tiempo 0, resetN será 0.

- La asignación procedural podría ejecutarse primero, estableciendo resetN en 0 (ya que un tipo de 2 estados es 0 por defecto), seguida de la inicialización en línea que establece resetN en 1. No se producirá ninguna transición a 0, y al final del paso de tiempo 0, resetN será 1.

SystemVerilog elimina este no determinismo. Con SystemVerilog,
la inicialización en línea se realizará antes del tiempo de simulación
cero. En el ejemplo mostrado anteriormente, resetN siempre se
inicializará primero a 1, y luego se ejecutará la asignación
procedural, estableciendo resetN en 0. Una transición de 1 a 0
ocurrirá cada vez, en todas las herramientas de software. Al final
del paso de tiempo 0, resetN será 0.

## i. Type casting (like C)

SystemVerilog añade la capacidad de realizar un casting de tipo a un
valor diferente. El casting de tipo es diferente a la conversión de valor
durante una asignación. **Con el casting de tipo**, un valor puede
convertirse a un nuevo tipo dentro de una expresión, sin necesidad de
realizar ninguna asignación.

### i.1 Static compile time casting 

**1. Type casting**

> `new_type'(expresion)`

En este ejemplo, `my_int` es un entero (32 bits por defecto) y se convierte a un vector de 8 bits (`logic [7:0]`). Aquí, solo se toman los 8 bits menos significativos de `my_int`.

~~~verilog
int my_int = 255;
logic [7:0] my_byte;

my_byte = logic'(my_int);  // Casting a un vector de 8 bits
~~~

**2. Size casting**

> `new_size'(expresion)`

El casting de tamaño se utiliza para ajustar el número de bits de una expresión a un nuevo tamaño especificado. Este tipo de casting es útil cuando se necesita forzar una expresión a que se ajuste a un tamaño de bits particular, recortando o extendiendo los bits según sea necesario.

~~~verilog
logic [15:0] my_word;
logic [7:0] my_byte;

// Casting para ajustar el tamaño de la expresión a 8 bits.
my_byte = my_word[7:0];     // Selecciona los 8 bits menos significativos
~~~

**3. Sign casting**

> `new_sign'(expresion)`

El casting de signo se usa para cambiar el tipo de signo de una expresión. Por ejemplo, convertir una variable sin signo a una variable con signo o viceversa. Este tipo de casting asegura que la expresión se interprete correctamente en operaciones aritméticas, teniendo en cuenta su signo.

~~~verilog
logic signed [15:0] my_signed_word;
logic [15:0] my_unsigned_word;

my_signed_word = signed'(my_unsigned_word);  // Casting de signo: unsigned a signed
~~~ 

**4. Error checking**

La expresión a convertir siempre se convierte durante el tiempo de ejecución, sin verificar si la expresión a convertir cae dentro del rango legal del tipo al cual se está convirtiendo el valor. 

**Ejemplo Explicado**:
Considera el siguiente código:
   
~~~verilog
typedef enum {S1, S2, S3} states_t;
states_t state, next_state;

always_comb begin
    if (state != S3)
        next_state = states_t'(state + 1);
    else
        next_state = S1;
end
~~~   
   - Aquí, `states_t` es un tipo de dato enumerado con tres posibles valores: `S1`, `S2`, y `S3`.
   - La línea `next_state = states_t'(state + 1);` intenta incrementar el valor de `state` en 1 y luego convertirlo al tipo `states_t` usando una conversión estática.
   
   - **Peligro Potencial**:
     - Si `state` tiene el valor `S3` (que sería el último valor en la enumeración), entonces `state + 1` genera un valor que está fuera del rango de `states_t` porque no hay un valor válido en la enumeración después de `S3`.
     - Sin embargo, debido a que se está utilizando una conversión estática, no se verificará si `state + 1` es un valor válido para `states_t`. Esto podría llevar a comportamientos impredecibles, ya que `next_state` podría tomar un valor no definido en el conjunto de valores enumerados.

**Cuidado Requerido**:
   - Dado que no se realizan comprobaciones, es responsabilidad del programador asegurarse de que los valores que se están asignando a `next_state` mediante una conversión estática sean valores legales y válidos dentro del tipo enumerado `states_t`.
   - En el ejemplo, el código evita un valor fuera de rango verificando si `state != S3` antes de incrementar. Sin embargo, si no se hace esta verificación y `state` es igual a `S3`, la operación `state + 1` puede causar que `next_state` tome un valor inválido.


### i.2 Casting dinámico

La operación de conversión estática descrita anteriormente es una conversión en tiempo de compilación. La conversión siempre se realiza sin verificar la validez del resultado. Cuando se desea una verificación más estricta, SystemVerilog proporciona una nueva función del sistema, **$cast**, que realiza una verificación dinámica en tiempo de ejecución sobre el valor que se va a convertir.

La función del sistema $cast toma dos argumentos, una variable de destino y una variable de origen.

**Sintáxis**

> $cast(destino, origen);

Si la asignación es inválida, se informa un error en tiempo de ejecución y la variable de destino queda sin cambios.

**Ejemplo:**
~~~verilog
int radio, area;
always@(posedge clock)
    $cast(area, 3.154 * radius ** 2);
    // result of cast operation is cast to
    // the type of area
~~~

**$cast** puede ser llamado como una función del sistema. La función devuelve un indicador de estado que indica si el cast fue exitoso o no. 
- **Si el cast es exitoso**, $cast devuelve 1. 
- **Si el cast falla**, la función $cast devuelve 0 y no cambia la variable de destino. 

~~~verilog
typedef enum {S1, S2, S3} states_t;
states_t state, next_state;
int status;
always_comb begin
    status = $cast(next_state, state + 1);
    if (status == 0) // if cast did not succeed...
        next_state = S1;
end
~~~

**`Nota: `**Tener en cuenta que la función $cast no se puede usar con operadores que modifican directamente la expresión fuente, como ++ o +=.

> $cast(next_state, ++state) // Ilegal


### i.3 Synthesis guidelines

El operador de cast estático en tiempo de compilación es sintetizable. La función de sistema dinámico $cast podría no ser compatible con los compiladores de síntesis.


## j. Constantes (const) bits

Verilog proporciona tres tipos de constantes: parameter, specparam y localparam. En resumen:

- **parameter** es una constante cuyo valor puede redefinirse durante la elaboración mediante defparam o redefinición en línea de parámetros.
- **specparam** es una constante que puede redefinirse en el tiempo de elaboración desde archivos SDF.
- **localparam** es una constante en tiempo de elaboración que no puede redefinirse directamente, pero cuyo valor puede basarse en otras constantes.

Verilog también restringe la declaración de las constantes parameter, specparam y localparam a módulos, tareas estáticas y funciones estáticas. Es ilegal declarar una de estas constantes en una tarea o función automática, o en un bloque begin...end o fork...join.

**SystemVerilog** añade la capacidad de declarar cualquier variable como
constante, utilizando la palabra clave const. La forma const de una constante no
recibe su valor hasta después de que la elaboración esté completa.
**Una constante const puede:**

- Ser declarada en contextos dinámicos como tareas y funciones automáticas.
- Asignarse con el valor de una red o variable en lugar de una expresión constante. 
- Asignarse con el valor de un objeto que esté definido en otra parte de la jerarquía de diseño.

La declaración de una constante const debe incluir un tipo de datos.
**Ejemplo:**

~~~verilog
const logic [23:0] c1 = 7; // constante de 24 bits
const int c2 = 15;  // constante de 32 bits
const real c3 = 3.14; // constante real
const c4 = 5; // error, no se ha asignado ningún tipo
~~~