# VerilogHDL
Ejercicios y práctica de Verilog HDL
Estructura común en un proyecto de sistemas digitales:
~~~
        proyecto_verilog/
        |-- rtl/                # Código fuente RTL (Register-Transfer Level)
        |   |-- modulos/       # Módulos del diseño
        |   |-- top_modulo.v   # Módulo de nivel superior
        |-- tb/                 # Bancos de prueba (Testbenches)
        |   |-- test_modulo.v  # Bancos de prueba para los módulos
        |-- scripts/            # Scripts útiles para la simulación o síntesis
        |-- sim/                # Archivos y resultados de simulación
        |-- syn/                # Archivos y resultados de síntesis
        |-- docs/               # Documentación del proyecto
        |-- README.md           # Documentación principal del proyecto

~~~
Otras herramientas ademas de **icarus**
## 1 **Verilator:**
Verilator es una herramienta de simulación de hardware de código abierto y rápida. A diferencia de las herramientas de simulación tradicionales que interpretan el código Verilog, Verilator realiza una compilación previa (síntesis lógica y simulación) para lograr una simulación más rápida. Es especialmente útil para proyectos grandes y complejos donde la velocidad de simulación es crucial.

Características clave de Verilator:

- **Síntesis de hardware:** Verilator realiza una síntesis lógica del código Verilog antes de la simulación, lo que contribuye a una simulación más rápida.
- **Código abierto:** Verilator está disponible como software de código abierto y se puede utilizar de forma gratuita.
- **Soporte para SystemVerilog:** Aunque inicialmente se centró en Verilog, Verilator ha agregado soporte para algunas características de SystemVerilog.

## 2 **Yosys:**
Yosys es una suite de herramientas de código abierto para síntesis lógica y verificación de hardware. Se utiliza para convertir descripciones de hardware en lenguajes como Verilog o VHDL en netlists y circuitos lógicos, lo que puede ser implementado en dispositivos FPGA o ASIC.

Características clave de Yosys:

- **Síntesis de hardware:** Yosys realiza síntesis lógica y puede generar netlists y circuitos lógicos a partir de descripciones de hardware en Verilog, SystemVerilog u otros lenguajes.
- **Soporte para FPGAs y ASICs:** Yosys puede generar implementaciones para dispositivos FPGA y ASIC.
- **Extensibilidad:** Yosys es extensible y se puede ampliar mediante scripts y plugins para realizar diversas tareas de síntesis y verificación.
- **Código abierto:** Yosys es de código abierto y está disponible de forma gratuita.

Ambas herramientas, **Verilator y Yosys**, son populares en el campo del diseño de hardware digital y son utilizadas por la comunidad para el desarrollo y la verificación de circuitos integrados. Cada una tiene sus propias características y casos de uso específicos, y la elección entre ellas puede depender de los requisitos y preferencias del proyecto.
