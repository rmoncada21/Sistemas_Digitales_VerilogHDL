# Hardware_codeHub

Este repositorio funciona como un **hub central** que agrupa y organiza distintas desarrollos  relacionadas con el diseño y verificación de sistemas digitales usando lenguajes de descripción de hardware como **Verilog HDL** y **SystemVerilog**.

La mayoría de los proyectos están incluidos como **submódulos de Git**.

---

## 📁 Repositorios incluidos

| Repositorio | Descripción |
|------------|-------------|
| [`digital_architectureHDL`](https://github.com/rmoncada21/digital_architectureHDL/tree/main) | Modelado de micro/arquitecturas en HDL (e.g. LC3, RISC-V, MIPS). |
| [`digital_design_SystemVerilog`](https://github.com/rmoncada21/digital_design_SystemVerilog/tree/main) | Desarrollo e implementaciones de circuitos digitales utilizando **SystemVerilog HDL**. |
| [`digital_design_VerilogHDL`](https://github.com/rmoncada21/digital_design_VerilogHDL/tree/main) | Desarrollo e implementaciones de circuitos digitales utilizando **VerilogHDL**. |
| [`digital_verification_SystemVerilog`](https://github.com/rmoncada21/digital_verification_SystemVerilog/) | **Técnicas de verificación funcional** con SystemVerilog. Testbenches, transactores, scoreboard, **UVM**, etc, |
|~|~|

> 🔗 *Los enlaces apuntan a URLs de los submodulos a sus respectivos repositorios de GitHub.*

---

## 📦 Estructura común de un proyecto HDL

```
proyecto_hdl/
│
├── rtl/            # Código fuente RTL
│   ├── modulos/    # Módulos internos
│   └── top.v       # Módulo de nivel superior
│
├── tb/             # Bancos de prueba (Testbenches)
│
├── sim/            # Resultados y archivos de simulación
├── syn/            # Resultados de síntesis
├── scripts/        # Scripts de automatización (sim/synth)
├── docs/           # Documentación técnica
└── README.md       # Documentación del proyecto
```

<!-- ---

## 🛠️ Clonado del repositorio (con submódulos)

Para clonar el repositorio junto con todos los submódulos:

```bash
git clone --recurse-submodules https://github.com/usuario/Hardware_codeHub.git
```

En caso de que el repositorio se haya sido clonado sin los submódulos, se pueden inicializar y actualizar con el siguiente comando:

```bash
git submodule update --init --recursive
``` -->

---

## 🚧 Estado del proyecto

Este repositorio está en constante crecimiento.
<!-- Se recomienda clonar con submódulos para garantizar que se mantenga la estructura adecuada entre los diferentes componentes de diseño y verificación. -->

---