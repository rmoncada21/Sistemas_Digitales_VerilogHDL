# User define type (typedef) and enumerates types

Los tipos definidos por el usuario permiten modelar diseños complejos a un nivel más abstracto que sigue siendo preciso y sintetizable. Utilizando los tipos definidos por el usuario en SystemVerilog, se puede modelar más funcionalidad de diseño en menos líneas de código, con la ventaja adicional de hacer que el código sea más auto-documentado y más fácil de leer.

## a. User define types (typedef)

Los tipos definidos por el usuario permiten crear nuevas definiciones de tipo a partir de tipos existentes. Una vez que se ha definido un nuevo tipo, se pueden declarar variables del nuevo tipo.

Para facilitar la lectura y el mantenimiento del código fuente, **una convención de nomenclatura común es terminar todos los tipos definidos por el usuario con los caracteres "_t".**

~~~verilog
typedef int unsigned uint_t;

uint_t a, b;  // dos variables de tipo uint
~~~


### a.1 Definiciones typedef locales

En el siguiente fragmento de código se declara un tipo definido por el usuario llamado nibble, usado para las declaraciones de variables dentro de un módulo llamado alu. Dado que el tipo nibble se define localmente, solo el módulo alu puede ver la definición

~~~verilog
module alu(...);
    typedef logic [3:0] nibble;
    nibble opA, opB;

    nibble [7:0] data; // a 32-bit data vector made from 8 nibble types
    ...
endmodule
~~~

### a.2 Definiciones typedef compartidas

Cuando se desea utilizar un tipo definido por el usuario en varios modelos diferentes, la **definición typedef puede declararse en un paquete**. Estas definiciones pueden ser referenciadas directamente o importadas en cada módulo, interfaz o bloque de programa que utilice los tipos definidos por el usuario

**1. En package**
~~~verilog
package chip_types;
    `ifdef TWO_STATE
        typedef bit dtype_t;
    `else
        typedef logic dtype_t;
    `endif
endpackage

module counter(
    output chip_types::dtype_t [15:0] count
    input chip_types::dtype_t clock, resetN
);
    always @(posedge clock, negedge resetN)
        if(!resetN) count <= 0;
        else        count <= count + 1;
endmodule
~~~


**2. $unit**

Una definición typedef también puede declararse externamente, en el ámbito de
la unidad de compilación, asi como es posible importar definiciones de paquetes al espacio de unidad de compilación $unit. Esto puede ser útil cuando muchos puertos de un módulo son de tipos definidos por el usuario, y resulta tedioso referenciar directamente el nombre del paquete para cada declaración de puerto. 

~~~verilog
package chip_types;
    `ifdef TWO_STATE
        typedef bit dtype_t;
    `else
        typedef logic dtype_t;
    `endif
endpackage

import chip_types::dtype_t;  // import definition int $unit

module counter(
    output dtype_t [15:0] count, 
    input dtype_t clock, resetN
);
    always @(posedge clock, negedge resetN)
        if(!resetN) count <= 0;
        else        count <= count + 1;
endmodule
~~~

## b. Enumerated types (enum)

Los tipos enumerados proporcionan un medio para declarar una variable abstracta que puede tener una lista específica de valores válidos. Cada valor se identifica con un nombre definido por el usuario o etiqueta.

~~~ verilog
/*
    los valores de la vaiables dentro de enum toman un valor por defecto si no se les asigna uno

    red = 0;
    green = 1;
    blue = 2;
*/
enum {red, green, blue} RGB;
~~~

**1. Ejemplo de una maquina de estados modelado con enum:**

~~~verilog
package chip_types;
    typedef enum {FETCH, WRITE, ADD, SUB, 
                MULT, DIV, SHIFT, NOP } instr_t;
endpackage

import chip_types::*; // importa package into $unit

module controller (
    output logic read, write,
    input instr_t instruction,
    input wire clock, resetN
);
    enum{WAITE, LOAD, STORE} State, NextState;

    always_ff @ (posedge clock, negedge resetN)
        if(!resetN) State <= WAITE;
        else        State <= NextState;

    always_comb begin
        case (State)
            WAITE:  NextState = LOAD;
            LOAD:   NextState = STORE;
            STORE:  NextState = WAITE;
        endcase
    end

    always_comb begin
        read = 0; 
        write = 0;
        if(State == LOAD && instruction == FECTH)
            read = 1;
        else if (State == STORE && instruction == WRITE)
            write = 1;
    end
endmodule
~~~

**2. Importando enum types desde package**

Para hacer visibles las etiquetas del tipo enumerado, cada etiqueta debe importarse explícitamente, o bien el paquete debe ser importado mediante un comodín (*).

~~~verilog
package chip_types;
    typedef enum {WAITE, LOAD, READY} states_t;
endpackage

module chip(...);
    import chip_types::states_t;

    states_t state nextt_state;

    always_ff @(posedge clok, negedge resetN)
        if(!resetN)
            state <=WAITE;
        else 
            state <= mext_state;
endmodule        
~~~

### b.1 Etiquetas de secuencias para enum

| Sintaxis    | Descripción                                                                                                                                   |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| `state`     | crea una única etiqueta llamada `state`                                                                                                        |
| `state[N]`  | crea una secuencia de etiquetas, comenzando con `state0`, `state1`, ... `stateN-1`                                                             |
| `state[N:M]`| crea una secuencia de etiquetas, comenzando con `stateN` y terminando con `stateM`. Si `N` es menor que `M`, la secuencia incrementa de `N` a `M`. Si `N` es mayor que `M`, la secuencia decrece de `N` a `M`. |



Ejemplo:

> enum {RESET, S[5], W[6:9]} state;

Ahora, al definir la enumeración `enum {RESET, S[5], W[6:9]} state;`, los valores asignados a cada etiqueta se asignan de manera secuencial de la misma manera, comenzando desde 0:

- **`RESET`** tomará el valor **0**.
- **`S[0]`** tomará el valor **1**.
- **`S[1]`** tomará el valor **2**.
- **`S[2]`** tomará el valor **3**.
- **`S[3]`** tomará el valor **4**.
- **`S[4]`** tomará el valor **5**.
- **`W[6]`** tomará el valor **6**.
- **`W[7]`** tomará el valor **7**.
- **`W[8]`** tomará el valor **8**.
- **`W[9]`** tomará el valor **9**.

### b.2 Etiquetas enum en un mismo scope/ámbito

Las etiquetas dentro de una lista de tipos enumerados deben ser únicas dentro de ese ámbito, como lo son; unidad de compilación, módulos, interfaces, programas, bloques begin...end, bloques fork...join, tareas y funciones.

El siguiente fragmento de código resultará en un error, porque la etiqueta enumerada GO se utiliza dos veces en el mismo ámbito:

~~~verilog
module FSM(...);
    enum {GO, STOP} fsm1_state;
    ...
    enum {WAITE, GO, DONE} fsm2_state; // ERROR, ya la etiquete GO se declaró antes en este ámbito
~~~

Este error en el ejemplo anterior puede corregirse colocando al menos una de las declaraciones de tipo enumerado en un bloque begin...end, que tiene su propio ámbito de nombres.

~~~verilog
module FSM (...);
    ...
    always @(posedge clock) begin: fsm1
        enum {STOP, GO} fsm1_state;
        ...
    end
    
    always @(posedge clock) begin: fsm2
        enum {WAITE, GO, DONE} fsm2_state;  // distinto ámbito
        ...
    end
...
~~~

### b.3 Valores para los tipos enum

Por defecto, el valor real representado por la etiqueta en una lista de tipos enumerados es un entero del **tipo int**. 

SystemVerilog permite que el valor de cada etiqueta en la lista enumerada se declare explícitamente. Esto permite refinar el tipo enumerado abstracto, si es necesario, para representar características de hardware más detalladas.

~~~verilog
enum {ONE = 1, FIVE = 5, TEN = 10}
~~~

No es necesario especificar el valor de cada etiqueta en la lista enumerada. Si no se especifica, el valor que representa cada etiqueta se incrementará en 1 respecto a la etiqueta anterior.


En el siguiente ejemplo B=2, C=3, Y=25, Z=26

~~~verilog
enum {A=1, B, C, X=24, Y, Z} list1;
~~~

En el siguiente ejemplo la compilación da ERROR
~~~
enum {A=1, B, C, D=3} list2;
~~~

### b.4 Tipos bases para enum

Los tipos enumerados tienen un tipo base de Verilog o SystemVerilog. El tipo base predeterminado para los tipos enumerados es int, que es un tipo de 32 bits de 2 estados. SystemVerilog permite declarar explícitamente un tipo base para los tipos enumerados.

~~~verilog
// enumerated type with a 1-bit wide,
// 2-state base type
enum bit {TRUE, FALSE} Boolean;

// enumerated type with a 2-bit wide,
// 4-state base type
enum logic [1:0] {WAITE, LOAD, READY} state;
~~~

Si una etiqueta enumerada de un tipo enumerado declarado explícitamente se le asigna un valor, el tamaño debe coincidir con el tamaño del tipo base.

~~~verilog
enum logic [2:0] {  WAITE = 3’b001, 
                    LOAD = 3’b010,
                    READY = 3’b100} state;

/*
    EL siguiente ejemplo presentará un erro en compilación
    esto debido a que tiene por defecto un enum de tipo int
    y en cambió se le asigno valores binarios de 3 bits
*/
enum {  WAITE =   3’b001,
        LOAD = 3’b010,
        READY = 3’b100} state; // ERROR!
~~~

Si se asigna un valor de X o Z a una etiqueta en una lista enumerada, la siguiente etiqueta debe tener también un valor explícito asignado. **Es un error intentar tener un valor automáticamente incrementado después de una etiqueta a la que se le asigna un valor de X o Z.**

~~~verilog
enum logic [1:0] { WAITE, ERR = 2'bxxx,LOAD, READY } // ERROR
~~~

### b.5 Tipos y enumeraciones anónimas

Se refiere al no uso de la palabra clave **typedef** antes del enum{};, por ejemplo

~~~verilog
enum {RED, GREEN, BLUE} current_color;
~~~
La instrucción anterrio no crea un nuevo tipo de dato, si no que crea la variable current_color para un uso mas local, y sin necesidad de reutilización. 

### b.6 - b.7 Strong typing en operaciones enum - Casting expressions to enumerated types

El tipado fuerte en las operaciones con enumeraciones implica que **solo se puede realizar operaciones y asignaciones con valores que son explícitamente compatibles con el tipo de la enumeración.** Esto significa que una variable de tipo enumerado no puede recibir o ser comparada con valores fuera del conjunto definido en la enumeración, a menos que se realice una conversión explícita. Esto contrasta con el tipado débil (weak typing), donde estas restricciones son más flexibles, permitiendo asignar valores fuera de la enumeración sin necesidad de conversión.

### Ejemplo

```verilog
typedef enum logic [1:0] {RED, GREEN, BLUE} color_t;
color_t current_color;
```

Aquí, `color_t` es un tipo de datos fuertemente tipado que solo puede tomar los valores `RED`, `GREEN` o `BLUE`.

- **Operación Permitida**
Asignar uno de los valores definidos en la enumeración es perfectamente válido:

    ```verilog
    current_color = RED;  // Válido
    ```

- **Operación No Permitida**
Intentar asignar un valor que no es parte de la enumeración (sin conversión explícita) provocará un error de compilación o advertencia:

    ```verilog
    current_color = 2'b11;  // Inválido (si no está en la enumeración)
    ```

    En el caso de tipado fuerte, el compilador no permite esta asignación porque `2'b11`    no es uno de los valores enumerados en `color_t`. Debes realizar una conversión    explícita si realmente quieres hacer esto:

    ```verilog
    current_color = color_t'(2'b11);  // Válido con conversión explícita usando casting
    $cast(current_color, 2'b11);  // usando $cast
    ```
    **`NOTA:`** Recordar que el uso de la función de sistema dinámica $cast verifica que el resultado de la expresión sea un valor legal antes de cambiar la variable de destino.

### b.8 Special system tasks and methods for enumerated types

SystemVerilog proporciona varias funciones integradas, denominadas métodos, para iterar a través de los valores en una lista de tipos enumerados. 

**- enum_name.`first`**: Devuelve el valor del primer miembro en la lista enumarada. 
**- enum_name.`last`**: Devuelve el valor del último miembro en la lista enumarada. 
**- enum_name.`next`**(N): Devuelve el valor del siguiente miembro en la lista enumerada. Opcionalmente, se puede especificar un valor entero como argumento para `next`. 
**- enum_name.`prev`**(N): Devuelve el valor del miembro anterior en la lista enumerada. 
**- enum_name.`num`**: Devuelve el número de etiquetas en la lista.
**- enum_name.`name`**: Devuelve la representación de cadena de la etiqueta para el valor en el tipo enumerado dado. Si el valor no es un miembro de la enumeración, el método `name` devuelve una cadena vacía.

### b.9 Printing enumerated types

Los enumerated type values pueden ser impresos tanto como el valor interno de la etiqueta, o como el nombre de la etiqueta. 
- Al imprimir el tipo enumerado directamente, se imprimirá el valor interno del tipo enumerado. 
- El nombre de la etiqueta que representa el valor actual se accede utilizando el método de nombre del tipo enumerado. Este método devuelve una cadena que contiene el name. Esta cadena luego se puede pasar a $display para imprimir.

~~~verilog
module print_enum;
    typedef enum logic [1:0] {
        RED = 2'b00,
        GREEN = 2'b01,
        BLUE = 2'b10
    } color_t;

    color_t my_color;

    initial begin
        my_color = GREEN;
        $display("The color is: %s", my_color.name());  // Imprime: The color is: GREEN
    end
endmodule
~~~

El siguiente ejemplo imprime el valor atual de la variable my_color que es de tipo color_t.

~~~verilog
module print_enum_value;
    typedef enum logic [1:0] {
        RED = 2'b00,
        GREEN = 2'b01,
        BLUE = 2'b10
    } color_t;

    color_t my_color;

    initial begin
        my_color = BLUE;
        $display("The color value is: %0d", my_color);  // Imprime: The color value is: 2
    end
endmodule
~~~