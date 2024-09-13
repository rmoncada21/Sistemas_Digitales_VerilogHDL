# Programación orientada a objetos en SystemVerilog

En SystemVerilog, la **Programación Orientada a Objetos (POO)** extiende las capacidades del lenguaje al incorporar conceptos de software como clases, herencia, polimorfismo, encapsulación y abstracción. Estos conceptos permiten escribir testbenches y modelos de verificación de una manera más estructurada, reutilizable y fácil de mantener.

## a. Breve introducción 

**¿Qué es la Programación Orientada a Objetos (POO) en SystemVerilog?**

POO en SystemVerilog es un enfoque de diseño que organiza el código en **objetos**. Los objetos son instancias de **clases**, que actúan como plantillas que definen tanto los **atributos** (datos) como los **métodos** (funciones) que los objetos pueden usar.

**Beneficios de la POO en SystemVerilog**

1. **Reutilización del código**: Puedes definir clases base genéricas y reutilizarlas en diferentes partes del banco de pruebas.
2. **Mantenimiento más sencillo**: El código está más organizado y es más fácil de actualizar o mejorar.
3. **Extensibilidad**: Puedes añadir nuevas funcionalidades extendiendo las clases existentes mediante **herencia**.
4. **Polimorfismo**: Permite que diferentes clases se usen de manera intercambiable, facilitando la creación de bancos de pruebas modulares y adaptables.

**Conceptos Clave de la POO en SystemVerilog**

1. **Clases**: Una clase es una plantilla que define un conjunto de datos (propiedades) y funciones (métodos) que operan sobre esos datos.
   
   ```verilog
   class MiClase;
       // Propiedad (atributo)
       int valor;

       // Método (función)
       function void mostrar_valor();
           $display("Valor es: %0d", valor);
       endfunction
   endclass
   ```

2. **Objetos**: Un objeto es una instancia de una clase. Se crea usando la palabra clave `new`.

   ```verilog
   MiClase objeto;  // Declaración de un objeto de tipo MiClase
   objeto = new();  // Creación del objeto usando new
   ```

3. **Encapsulación**: Los datos y métodos se agrupan en una clase, controlando el acceso a ellos mediante especificadores de acceso (`local`, `protected`, `public`).

   ```verilog
   class MiClase;
       protected int valor;  // Solo accesible desde la clase y sus subclases
       public function void set_valor(int v);  // Método público
           valor = v;
       endfunction
   endclass
   ```

4. **Herencia**: Permite crear una nueva clase que herede propiedades y métodos de una clase existente. Utiliza la palabra clave `extends`.

   ```verilog
   class ClaseBase;
       int base_atributo;
   endclass

   class ClaseDerivada extends ClaseBase;
       int derivado_atributo;
   endclass
   ```

5. **Polimorfismo**: Permite que diferentes clases se usen de manera intercambiable. Se logra mediante el uso de herencia y funciones virtuales.

   ```verilog
   virtual class Animal;
       virtual function void sonido();
       endfunction
   endclass

   class Perro extends Animal;
       function void sonido();
           $display("Guau!");
       endfunction
   endclass

   class Gato extends Animal;
       function void sonido();
           $display("Miau!");
       endfunction
   endclass
   ```

   Aquí, `Perro` y `Gato` son subclases de `Animal` y pueden usarse donde se espere un objeto `Animal`.

**Ejemplo Básico**

A continuación, se muestra un ejemplo básico de cómo usar la POO en SystemVerilog para crear una clase de transacción simple para un banco de pruebas de verificación:

```verilog
class Transaccion;
    rand bit [7:0] direccion;
    rand bit [31:0] datos;

    function void imprimir();
        $display("Transacción: Dirección=%0h, Datos=%0h", direccion, datos);
    endfunction
endclass

// Uso de la clase en el testbench
initial begin
    Transaccion tx = new();
    if (tx.randomize()) begin  // Generación aleatoria de los datos
        tx.imprimir();
    end
end
```

En este ejemplo, la clase `Transaccion` tiene propiedades `direccion` y `datos` que se pueden randomizar. La función `imprimir` se utiliza para mostrar los datos de la transacción.

## b. Think of nouns, not verbs

La idea de **"Pensar en Sustantivos, no en Verbos"** en el contexto de la Programación Orientada a Objetos (POO) y el diseño de testbenches en SystemVerilog se refiere a cambiar el enfoque de cómo se estructura el testbench, centrándose en **los datos** (sustantivos) en lugar de **las acciones** (verbos). Este enfoque ayuda a crear un diseño más limpio, mantenible y fácil de entender.

- **Agrupación de Datos y Código en Clases**

    En POO, el enfoque está en **agrupar datos y código juntos** en lugar de tenerlos separados. Esto se logra mediante el uso de **clases**, donde cada clase representa un "sustantivo" o entidad en el sistema, que tiene atributos (datos) y métodos (funciones que operan sobre esos datos).

    Por ejemplo, en un testbench, una **transacción** es un concepto clave (un "sustantivo"). Una transacción puede tener varios atributos, como dirección, datos, tipo de operación, etc. En lugar de pensar en términos de "crear una transacción", "transmitir una transacción" o "verificar una transacción" (verbos), el diseño del testbench debe girar en torno a la transacción misma como objeto principal.

- **Estructurar el Testbench Alrededor de Transacciones**

    El objetivo de un testbench es aplicar estímulos al diseño bajo prueba (DUT, Device Under Test) y luego verificar si el resultado es correcto. Las **transacciones** representan los datos que fluyen dentro y fuera del DUT. Por lo tanto, la mejor manera de organizar el testbench es alrededor de estas transacciones y las operaciones que se realizan sobre ellas.

    En lugar de escribir código para crear, enviar y verificar transacciones directamente (enfoque orientado a verbos), el testbench debe estar organizado en **clases** que representen las entidades principales involucradas en este flujo de datos:

    - **Generador (Generator)**: Crea transacciones.
    - **Driver**: Toma las transacciones del generador y las aplica al DUT.
    - **Monitor**: Observa las respuestas del DUT y captura las transacciones resultantes.
    - **Scoreboard**: Verifica que las transacciones capturadas coincidan con las expectativas.

- **Diseño Modular del Testbench**

    La recomendación es dividir el testbench en **módulos** o **bloques**, cada uno con una responsabilidad específica, y definir claramente cómo se comunican entre sí:

    - **Generator**: Se encarga de **crear transacciones** y pasarlas al siguiente bloque.
    - **Driver**: Interactúa con el DUT aplicando las transacciones.
    - **Monitor**: Captura las transacciones de salida del DUT.
    - **Scoreboard**: Verifica que las transacciones coincidan con los datos esperados.

    Al pensar en términos de **sustantivos** (transacciones, generador, driver, monitor, scoreboard), el testbench se vuelve más estructurado y orientado a datos, y cada componente tiene una responsabilidad clara.

## c. Clases 

Una clase encapsula los datos junto con las rutinas que los manipulan

EL siguiente ejemplo muestra una clase para un paquete genérico. El paquete contiene un dirección, un CRC y un arreglo de valores de datos. 

~~~verilog
// Ejemplo 5.1
class Transaction;
  // Variables de la transacción
  bit [31:0] addr, crc;
  bit [31:0] data[8];

  // Método para mostrar la transacción
  function void display();
    $display("Transaction: %h", addr);
  endfunction : display

  // Método para calcular el CRC
  function void calc_crc();
    crc = addr ^ data.xor();
  endfunction : calc_crc
endclass : Transaction
~~~

Se seguirá la siguiente nomenclatura para la codificación:
- `Nombres de clases:` Letra inicial en mayúscula y se evita en uso del guión bajo. 
- `Constantes:` Toda la palabra en mayúscula. Ej: CELL_SIZE.
- `Variables:` Toda la palabra en minúscula. Ej: trans_type.

**c.1 Donde se puede definir una clase?**

Se puede definir una clase en un program, module, package o fuera de cualquiera de estos. 

## c. Terminología de POO en SV

- `Class:` Un bloque básico que contiene rutinas y variables. El análogo en Verilog es un módulo.

- `Object:` Una instancia de una clase. En Verilog, necesitas instanciar un módulo para usarlo.

- `Handle:` Un puntero a un objeto. En Verilog, usas el nombre de una instancia cuando te refieres a señales y métodos desde fuera del módulo. Un handle en OOP es como la dirección del objeto, pero se almacena en un puntero que solo puede referirse a un tipo.

- `Property:` Una variable que contiene datos. En Verilog, esto es una señal como un registro o un wire.

- `Method:` El código procedimental que manipula variables, contenido en tareas y funciones. Los módulos en Verilog tienen tareas y funciones, además de bloques initial y always.

- `Prototype:` El encabezado de una rutina que muestra el nombre, tipo y lista de argumentos. El cuerpo de la rutina contiene el código ejecutable.

En Verilog, construyes diseños complejos creando módulos e instanciándolos jerárquicamente. En OOP, creas clases e instancias (creando objetos) para crear una jerarquía similar.

## d. Creando objetos
En el siguiente ejemplo, 5.2, `tr` es un handle (puntero a ojbeto) que apunta a un objeto de tipo Transaction, o simplemente se llama como Transaction handle. 

~~~verilog
// Ejemplo 5.2
Transaction tr; // Declare a handle
tr = new(); // Allocate a Transaction object
~~~

Cuando se declara el handle tr, se inicializa con el valor especial null. A continuación, se llama a la `función new()` para construir el objeto Transaction. La función new asigna espacio para el Transaction, inicializa las variables a su valor por defecto (0 para variables de 2 estados y X para las de 4 estados), y devuelve la dirección dondese almacena el objeto.

### d.1 Constructor `new` presonalizado

El constructor `new` hace más que asignar memoria; también inicializa los valores. Se puede definir una función new personalizada para establecer valores propios por defecto. 
NO SE DEBE especificar un valor de retorno para el constructor, ya que este devuelbe un handle a un objeto del mismo tipo que la clase. 

El Ejemplo 5.3 establece addr y data en valores fijos, pero deja crc en su valor predeterminado de X.

~~~verilog
// Ejemplo 5.3 
class Transaction;
  // Variables de la transacción
  logic [31:0] addr, crc;
  logic [31:0] data[8];

  // Constructor de la clase
  function new();
    addr = 3;
    foreach (data[i]) begin
      data[i] = 5;
    end
  endfunction : new
endclass : Transaction
~~~

Se pueden usar argumentos con valores predeterminados para hacer un constructor más flexible, como se muestra en el Ejemplo 5.4. Ahora se puede especificar el valor para addr y data cuando llamas al constructor, o utilizar los valores predeterminados.

~~~verilog
// Ejemplo 5.4 
class Transaction;
  // Variables de la transacción
  logic [31:0] addr, crc;
  logic [31:0] data[8];

  // Constructor de la clase con argumentos predeterminados
  function new(logic [31:0] a = 3, logic [31:0] d = 5);
    addr = a;
    foreach (data[i]) begin
      data[i] = d;
    end
  endfunction : new
endclass : Transaction

// Bloque inicial para crear una instancia de la clase Transaction
initial begin
  Transaction tr;
  tr = new(10); // `data` usa el valor predeterminado de 5
end
~~~

### d.2 Declaración y llamda del constructor

En SystemVerilog, es una buena práctica separar la declaración de un objeto de su inicialización mediante el constructor.
Cuando se trabaja con clases en SystemVerilog, se puede declarar e inicializar un objeto de la siguiente manera:

```systemverilog
// Declaración e inicialización combinada
Driver d = new();
```

En este caso, se declara e inicializa `d` en una sola línea usando el constructor `new()`. Aunque esto puede parecer conveniente y más conciso, tiene algunas desventajas:

1. **Orden de Ejecución**:
   - **Problema**: El constructor `new()` se llama inmediatamente al momento de la declaración, antes de que se inicie el primer bloque procedural (por ejemplo, `initial` o `always` blocks). Esto puede ser problemático si se necesita inicializar los objetos en un orden específico o si dependes de ciertas condiciones que solo están disponibles en bloques procedimentales.
   - **Solución**: Puedes declarar el objeto primero y luego inicializarlo explícitamente en un bloque procedural donde tienes control completo sobre cuándo y cómo se realiza la inicialización.

   ```verilog
   // Declaración separada
   Driver d;

   initial begin
     // Inicialización en un bloque procedural
     d = new();
   end
   ```

2. **Control de Inicialización**:
   - **Problema**: Al llamar al constructor en la declaración, se pierde el control sobre el momento exacto en que se realiza la inicialización. Esto puede ser crucial si la inicialización de objetos depende de ciertas condiciones o debe ocurrir en un momento específico durante la simulación.
   - **Solución**: Declarar el objeto sin inicializarlo y luego inicializarlo dentro de un bloque procedural te permite tener un control más preciso sobre el momento y las condiciones bajo las cuales se inicializa el objeto.

3. **Almacenamiento Automático vs. Estático**:
   - **Problema**: Si no se usa el almacenamiento automático, el objeto se inicializa al inicio de la simulación, no cuando se entra en un bloque procedural. Esto puede llevar a comportamientos inesperados si el objeto necesita ser inicializado en un momento específico durante la simulación.
   - **Solución**: Si el objeto debe ser inicializado en un bloque procedural, asegúrate de declararlo con almacenamiento automático o de inicializarlo en un bloque procedural para garantizar que se comporte como se espera.


### d.3 Diferencias entre `new()` y `new[]`

- `new():` se llama para construir un solo objeto y puede recibir múltiples valores como argumentos. 
- `new[]:` construye un arreglo con múltiples elementos y solo puedo recibir un valor como argumento. 

### d.4 Obteniendo los handles de los objetos

Los handles se declarany un objeto se contruye. A lo largo de una simulación, un handle puede apuntar a muchos objetos. 

En el siguiente ejemplo, t1 apunta a un objeto. 

~~~verilog
// Ejemplo 5.6
class Transaction;
  bit [31:0] data;
endclass : Transaction

module example;
  Transaction t1, t2;

  initial begin
    t1 = new();  // t1 apunta al primer objeto Transaction
    t2 = t1;     // t2 también apunta al primer objeto Transaction

    t1.data = 10; // Modifica el campo 'data' del primer objeto

    t1 = new();   // Crea un segundo objeto y t1 ahora apunta al nuevo objeto
    // t2 sigue apuntando al primer objeto, que ahora tiene data = 10

    $display("t1.data = %0d", t1.data); // Muestra el valor del campo 'data' del segundo objeto
    $display("t2.data = %0d", t2.data); // Muestra el valor del campo 'data' del primer objeto
  end
endmodule : example
~~~

### e. Designación de objetos (eliminación)
La recolección de basura es el proceso de liberar automáticamente los objetos que ya no están referenciados.

SystemVerilog:
- no permite ninguna modificación de un handle ni usar un handle de un tipo para referirse a un objeto de otro tipo. 
- permite que un handle solo apunte a objetos de un tipo, 

~~~verilog
// Ejemplo 5.7
Transaction t;  // Create a handle
t = new();  // Allocate a new Transaction
t = new();  // Allocate a second one, free the first
t = null;   // Deallocate the second
~~~

## f. Uso de los objetos

En la OOP estricta, el único acceso a las variables en un objeto debería ser a través de sus métodos públicos como `get()` y `put()`. El problema con esta metodología es que fue escrita para aplicaciones de software grandes con una vida útil de una década o más. 
Aunque los métodos `get()` y `put()` son adecuados para compiladores, interfaces gráficas de usuario (GUIs) y APIs, para el uso en sv para verificación, sería útil apegarse a **variables públicas que puedan ser accedidas directamente en cualquier parte del testbench**.

~~~verilog
// Ejemplo 5.8
Transaction t;  // Declare a handle to a Transaction
t = new();      // Construct a Transaction object
t.addr = 32h42; // Set the value of a variable
t.display();    // Call a routine
~~~

## g. Variables `statics` vs `global`

Cada objeto tiene sus propias variables locales que no se comparten con ningún otro objeto. Si tienes dos objetos Transaction, cada uno tiene sus propias variables addr, crc y data. Sin embargo, a veces necesitas una variable que sea compartida por todos los objetos de un cierto tipo. Por ejemplo, podrías querer llevar un conteo continuo del número de transacciones que se han creado.

### g.1 Variable estáticas (`static`)
Se puede crear una variable estática dentro de una clase. Esta variable se comparte entre todas las instancias de la clase, pero su alcance está limitado a la clase.

En el siguiente ejemplo, solo hay una copia de la variable estática count, sin importar cuántos objetos Transaction se creen. Se puede pensar que count está almacenado con la clase (al ser estática) y no con el objeto. La variable id no es estática, por lo que cada Transaction tiene su propia copia. 

~~~verilog
// Ejemplo 5.9 
class Transaction;
  static int count = 0; // Número de objetos creados
  int id;               // ID único para cada instancia

  function new();
    id = count++;       // Asigna ID y aumenta la cuenta
  endfunction
endclass

Transaction t1, t2;
initial begin
  t1 = new();  // 1ra instancia, id=0, count=1
  t2 = new();  // 2da instancia, id=1, count=2
  $display("Second id=%d, count=%d", t2.id, t2.count);
end
~~~

### g.2 Acceso a la variable estática a través del nombre de la clase
Para acceder a la variable no se necesita un handle, se puede usar el nombre de la clase seguido de `::`, el operador de resolución de ámbito de clase.
~~~verilog
// Ejemplo 5.10
class Transaction;
  static int count = 0; // Number of objects created
  ...
endclass

initial begin
  run_test();
  $display("%d transactions were created", Transaction::count); // Reference static w/o handle
end
~~~

**Inicialización de variables `static`**

Una variable estática generalmente se inicializa en la declaración. No se puede inicializarla fácilmente en el constructor de la clase, ya que este se llama para cada nuevo objeto. Se necesitaría otra variable estática para actuar como una bandera, indicando si la variable original había sido inicializada. Si se tiene una inicialización más elaborada, se podría usar un bloque initial. Solo se debe asegúrar de que las variables estáticas estén inicializadas antes de que se construya el primer objeto.

**Problemas con la Inicialización en el Constructor**

Si se intentas inicializar una variable estática en el constructor de la clase, ocurrirán varios problemas:

- `Reinicialización Repetida`: Cada vez que se crea un nuevo objeto, el constructor se ejecuta y, por lo tanto, la variable estática se reinicializaría. Esto no es deseable porque generalmente quieres que las variables estáticas mantengan su valor entre las instancias.
- `Necesidad de una Bandera Adicional`: Para evitar la reinicialización, necesitarías usar otra variable estática como bandera para verificar si la variable original ya ha sido inicializada. Este método es propenso a errores y aumenta la complejidad del código.

### g.3 Métodos statics



~~~verilog
// Ejemplo 5.11
class Transaction;
  static Config cfg; // A handle with static storage
  MODE_E mode;

  function new();
    mode = cfg.mode;
  endfunction
endclass

Config cfg;
initial begin
  cfg = new(MODE_ON);
  Transaction::cfg = cfg;
  // ...
end
~~~

**En SystemVerilog:**
- se puede crear un método estático dentro de una clase que pueda leer y escribir variables estáticas, incluso antes de que se haya creado la primera instancia. 
- no permite que un método estático lea o escriba variables no estáticas, como id. 

~~~verilog
// Ejemplo 5.12
class Transaction;
  static Config cfg;
  static int count = 0;
  int id;

  // Static method to display static variables.
  static function void display_statics();
    $display("Transaction cfg.mode=%s, count=%0d", cfg.mode.name(), count);
  endfunction
endclass

Config cfg;
initial begin
  cfg = new(MODE_ON);
  Transaction::cfg = cfg;
  Transaction::display_statics();
end
~~~

**Explicación del Código**

1. **Clase `Transaction`**:
   - `static Config cfg;`:
     - `cfg` es una variable estática que guarda un handle de tipo `Config`. Al ser estática, esta variable es compartida por todas las instancias de la clase `Transaction`.
   - `static int count = 0;`:
     - `count` es otra variable estática que se utiliza para contar o realizar un seguimiento de las instancias de `Transaction` o para cualquier otro propósito requerido. Inicialmente, se establece en 0.
   - `int id;`:
     - `id` es una variable de instancia, lo que significa que cada objeto `Transaction` tendrá su propio valor `id`.
   
2. **Método Estático `display_statics`**:
   - `static function void display_statics();`:
     - Este es un método estático que se utiliza para mostrar las variables estáticas `cfg` y `count`.
   - `$display("Transaction cfg.mode=%s, count=%0d", cfg.mode.name(), count);`:
     - Esta línea imprime el valor del modo de configuración (`cfg.mode.name()`) y el valor actual de `count`. Dado que es un método estático, se puede llamar sin necesidad de crear una instancia de `Transaction`.

3. **Bloque `initial`**:
   - `Config cfg;`:
     - Se declara una variable `cfg` de tipo `Config`.
   - `cfg = new(MODE_ON);`:
     - Se crea una nueva instancia de `Config` y se asigna a `cfg`. El constructor toma un argumento `MODE_ON`, que presumiblemente es un valor definido en algún lugar del código.
   - `Transaction::cfg = cfg;`:
     - Se asigna el objeto `cfg` a la variable estática `cfg` de la clase `Transaction`. Todas las instancias de `Transaction` tendrán acceso a este objeto `cfg`.
   - `Transaction::display_statics();`:
     - Llama al método estático `display_statics()` para mostrar los valores de las variables estáticas `cfg` y `count`.

### Puntos Clave

1. **Uso de Variables y Métodos Estáticos**:
   - Las variables estáticas (`static`) pertenecen a la clase y no a instancias individuales de la clase. Por lo tanto, cualquier modificación de una variable estática es visible para todas las instancias.
   - Los métodos estáticos pueden ser llamados sin crear una instancia de la clase. Estos métodos solo pueden acceder a otras variables o métodos estáticos.

2. **Configuración Compartida a través de `cfg`**:
   - El código muestra cómo un objeto de configuración (`cfg`) puede ser compartido entre todas las instancias de una clase. Esto es útil cuando necesitas que todas las instancias de la clase `Transaction` trabajen con la misma configuración.

3. **Mostrar Información Global del Sistema**:
   - El método `display_statics()` es una forma conveniente de mostrar información global sobre la configuración y el estado del sistema (como la cantidad de objetos creados).

Este patrón de uso de métodos y variables estáticas es común en la programación orientada a objetos para compartir datos o configuraciones globales entre múltiples instancias de una clase.

## h. Métodos de la clase

Un método en una clase es simplemente una tarea o función definida dentro del
ámbito de la clase. SystemVerilog llama al método correcto basado en el
tipo del manejador (handle).

~~~verilog
class Transaction;
  bit [31:0] addr, crc, data[8];
  
  function void display();
    $display("@%0t: TR addr=%h, crc=%h", $time, addr, crc);
    $write("\tdata[0-7]=");
    foreach (data[i]) 
      $write(data[i]);
    $display();
  endfunction
endclass : Transaction

class PCI_Tran;
  bit [31:0] addr, data; // Use realistic names
  
  function void display();
    $display("@%0t: PCI: addr=%h, data=%h", $time, addr, data);
  endfunction
endclass : PCI_Tran

Transaction t;
PCI_Tran pc;

initial begin
  t = new();          // Construct a Transaction
  t.display();        // Display a Transaction
  
  pc = new();         // Construct a PCI transaction
  pc.display();       // Display a PCI Transaction
end

~~~


## i. Métodos fuera de la clase

Para poder hacer el método fuera de la clase, se debe copiar la primera línea del método, con el nombre y los argumentos, y agrega la **palabra clave extern** al principio. Luego, toma todo el método y muévelo después del cuerpo de la clase, y añade el nombre de la clase y dos puntos (:: el operador de alcance) antes del nombre del método.

~~~verilog
class Transaction;
  bit [31:0] addr, crc, data[8];
  // La palabra clave extern es vital para poder 
  // crear la función fuera de la clase
  extern function void display();
endclass : Transaction

// Es necesario usar el operador de resolución
// con el nombre de la clase
function void Transaction::display();
  $display("@%0t: Transaction addr=%h, crc=%h", $time, addr, crc);
  $write("\tdata[0-7]=");
  foreach (data[i]) 
    $write(data[i]);
  $display();
endfunction : display


class PCI_Tran;
  bit [31:0] addr, data; // Use realistic names
  extern function void display();
endclass : PCI_Tran

function void PCI_Tran::display();
  $display("@%0t: PCI: addr=%h, data=%h", $time, addr, data);
endfunction : display
~~~

## j. Reglas de alcance (scoping rules)

Las **reglas de alcance** se refieren a cómo se manejan los nombres de las variables y otras entidades en el código, determinando dónde se pueden usar y cómo se resuelven los conflictos de nombres en diferentes partes de un programa.

1. **Ámbito de un Bloque de Código**: Un **ámbito** es una región del código donde las variables y otros identificadores son visibles y pueden ser utilizados. Los ejemplos de bloques de código que crean un ámbito incluyen módulos, programas, tareas, funciones, clases, bloques `begin-end`, y bucles `for` y `foreach`.

2. **Variables de Ámbito Local**: Puedes declarar variables dentro de un bloque, y estas serán locales a ese bloque. Esto significa que las variables solo son accesibles dentro del bloque donde se declaran.

3. **Ámbito de Bucles**: En SystemVerilog, los bucles `for` y `foreach` crean automáticamente un ámbito para que las variables de índice sean locales a ese bucle. Esta característica permite evitar conflictos de nombres y hacer que el código sea más claro y mantenible.

4. **Ámbito de Bloques sin Nombre**: Una característica nueva en SystemVerilog es la capacidad de declarar variables dentro de bloques `begin-end` sin nombre. Esto puede ser útil en algunas situaciones para crear variables locales de manera más controlada.

5. **Nombres Relativos y Absolutos**: Un nombre puede ser **relativo** al ámbito actual o **absoluto**, comenzando con `$root`. SystemVerilog buscará en los ámbitos actuales y superiores hasta encontrar una coincidencia para un nombre relativo. Si quieres ser claro y específico, utiliza `$root` al principio del nombre para referirte al ámbito global.

6. **Uso de Nombres en Diferentes Ámbitos**: Un mismo nombre, como `limit` en tu ejemplo, puede utilizarse en diferentes ámbitos: como variable global, variable de programa, variable de clase, variable de tarea, y variable local dentro de un bloque `initial`. Cada instancia de `limit` es distinta y se refiere a una entidad diferente dependiendo del ámbito en que se use.

### Ejemplo y Aplicación

El uso de diferentes nombres de variable en distintos ámbitos permite una mejor organización y legibilidad del código, y evita errores que puedan surgir de la reutilización de nombres. Sin embargo, en un código real, se recomienda usar nombres más significativos para cada variable, lo que ayuda a entender mejor el propósito de cada una en su contexto respectivo.

~~~verilog
// Ejemplo 5.16
int limit;

program automatic p;
  int limit;
  
  class Foo;
    int limit, array[];
    
    // Accessing different scopes
    //////$root.limit
    $root.p.limit
    $root.p.Foo.limit
    // $root.p.Foo.print.limit
    
    function void print(int limit);
      for (int i = 0; i < limit; i++)
        $display("%m: array[%0d] = %0d", i, array[i]);
    endfunction
  endclass
  
  initial begin
    int limit = $root.limit; // **see note above
    Foo bar;
    bar = new();
    bar.array = new[limit];
    bar.print(limit);
  end
endprogram
~~~

### j.1 Uso de `this` en systemverilog

Cuando se usa un nombre de variable en SystemVerilog, el compilador sigue un conjunto de **reglas de alcance** para determinar a qué variable se esta refiriendo. Estas reglas consisten en buscar primero en el ámbito actual (local) y luego en los ámbitos superiores (padres) hasta encontrar la definición de la variable.

**Problema de Ambigüedad en Constructores**

En situaciones donde se está profundamente dentro de un método de una clase, es posible que se desee referirse de manera inequívoca a un atributo o variable miembro de la clase, especialmente cuando se ha utilizado el mismo nombre para una variable local (argumento de una función o método) y para un miembro de la clase.

Este tipo de ambigüedad es común en los **constructores**, donde el programador puede usar el mismo nombre para un argumento de función que para un atributo de la clase. Por ejemplo, en el constructor de una clase, podrías tener un parámetro de entrada con el mismo nombre que un atributo de la clase que deseas inicializar.

**Solución con la Palabra Clave `this`**

La palabra clave `this` en SystemVerilog se utiliza para **eliminar la ambigüedad** y dejar claro que te refieres al atributo de la instancia de la clase actual, en lugar de a una variable local con el mismo nombre. Al usar `this`, se puede distinguir entre la variable miembro de la clase y el argumento local.

**Ejemplo Explicado**

En el siguiente código, se muestra cómo usar `this` para asignar un valor a una variable de clase cuando hay ambigüedad con un nombre de variable local:

```verilog
class Scoping;
  string oname; // Variable miembro de la clase

  function new(string oname); // Constructor con un argumento del mismo nombre
    this.oname = oname; // class oname = local oname
  endfunction
endclass
```

- **`string oname;`**: Declara un atributo miembro de la clase `Scoping` llamado `oname`.
- **`function new(string oname);`**: Define un constructor para la clase `Scoping` que recibe un argumento `oname`.
- **`this.oname = oname;`**: Aquí es donde la palabra clave `this` se utiliza para eliminar la ambigüedad:
  - `this.oname` se refiere al atributo `oname` de la instancia actual de la clase `Scoping`.
  - `oname` (sin `this.`) se refiere al argumento local del constructor.

### Ventajas del Uso de `this`

- **Claridad**: Usar `this` mejora la legibilidad del código al hacer explícito a qué variable o atributo te refieres.
- **Evita Errores**: Previene errores de asignación accidental al aclarar las referencias a las variables miembro de la clase.
- **Buenas Prácticas**: Es una buena práctica de programación en lenguajes orientados a objetos como SystemVerilog, donde la sobrecarga de nombres puede ocurrir frecuentemente.

## k. Clases anidadass
