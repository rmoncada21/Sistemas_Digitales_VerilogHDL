# Diseño Lógico - VerilogHDL
Ejercicios y práctica de Verilog HDL basados en el libro de **Diseño Digital de Morris Mano**

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