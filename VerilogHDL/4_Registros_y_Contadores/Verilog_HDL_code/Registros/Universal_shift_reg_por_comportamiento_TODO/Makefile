# -------------------------------------------------------------------
# Makefile: Archivo para la gestión y compilación de proyectos en Verilog.
# -------------------------------------------------------------------
# target: prerequisites
# 	command to build target

# Ejemplos de comandos de compilación:
# Verificar sintaxis sin generar archivo ejecutable
#   iverilog -g2012 -Wall -Wextra -t null archivo.v
# Compilar un archivo .v generando ejecutable
#   iverilog -g2012 -Wall -Wextra archivo.v -o bin/archivo
# Ejecutar un testbench compilado
#   vvp bin/testbench_modulos
# Ver archivo de onda .vcd con gtkwave
#   gtkwave gtkwave/archivo.vcd

# -------------------------------------------------------------------
# Variables
# -------------------------------------------------------------------

# Compilador y opciones
IVERILOG=iverilog
VVP=vvp
GTKWAVE=gtkwave
VERSION=-g2012
VFLAGS=-Wall
VSYNTAX=-t null

# Archivos de cabecera
VSOURCES=$(wildcard *.v)
MODULES=$(filter-out testbench_%,$(VSOURCES))
TESTBENCHES=$(filter testbench_%,$(VSOURCES))
EXE_TESTBENCHES=$(TESTBENCHES:.v=_vvp)
GTK_FILES=$(TESTBENCHES:.v=.vcd)
TESTBENCHES_ALL=$(TESTBENCHES:.v=_all)

# Directorios
BIN_FOLDER=bin
TEST_FOLDER=
GTKWAVE_FOLDER=gtkwave

# -------------------------------------------------------------------
# Código ansi de colores
# -------------------------------------------------------------------

# Colores básicos:
RESET = \033[0m
NEGRO = \033[30m
ROJO = \033[31m
VERDE = \033[32m
AMARILLO = \033[33m
AZUL = \033[34m
MAGENTA = \033[35m
CIAN = \033[36m
BLANCO = \033[37m

# Colores brillantes (intensos):
NEGRO_BRILLANTE = \033[90m
ROJO_BRILLANTE = \033[91m
VERDE_BRILLANTE = \033[92m
AMARILLO_BRILLANTE = \033[93m
AZUL_BRILLANTE = \033[94m
MAGENTA_BRILLANTE = \033[95m
CIAN_BRILLANTE = \033[96m
BLANCO_BRILLANTE = \033[97m

# Fondo de colores:
NEGRO_FONDO = \033[40m
ROJO_FONDO = \033[41m
VERDE_FONDO = \033[42m
AMARILLO_FONDO = \033[43m
AZUL_FONDO = \033[44m
MAGENTA_FONDO = \033[45m
CIAN_FONDO = \033[46m
BLANCO_FONDO = \033[47m

# Fondos brillantes:
NEGRO_BRILLANTE_FONDO = \033[100m
ROJO_BRILLANTE_FONDO = \033[101m
VERDE_BRILLANTE_FONDO = \033[102m
AMARILLO_BRILLANTE_FONDO = \033[103m
AZUL_BRILLANTE_FONDO = \033[104m
MAGENTA_BRILLANTE_FONDO = \033[105m
CIAN_BRILLANTE_FONDO = \033[106m
BLANCO_BRILLANTE_FONDO = \033[107m

# -------------------------------------------------------------------
# Reglas
# -------------------------------------------------------------------

# Regla principal
# all: $(TESTBENCHES) $(EXE_TESTBENCHES) $(GTK_FILES)
all:


mkdir:
	@mkdir -p $(BIN_FOLDER) $(TEST_FOLDER) $(GTKWAVE_FOLDER)


# Regla para verificar sintaxis de los modulos sin generar ejecutables
$(MODULES): mkdir
	@echo -e '$(AZUL_FONDO)make $$(MODULES)$(RESET)'
	@echo -e "$(AZUL_BRILLANTE)make $@\n$(RESET)"
	@echo -e "$(IVERILOG) $(VERSION) $(VFLAGS) $(CIAN_FONDO)$(VSYNTAX)$(RESET) $(VERDE_BRILLANTE)$@$(RESET)\n"
	@$(IVERILOG) $(VERSION) $(VFLAGS) $(VSYNTAX) $@


# Regla para verificar sintaxis de los testbenches sin generar ejecutables
$(TESTBENCHES): mkdir
	@echo -e '$(AZUL_FONDO)make $$(TESTBENCHES)$(RESET)'
	@echo -e "$(AZUL_BRILLANTE)make $@$(RESET)\n"
	@echo -e "$(IVERILOG) $(VERSION) $(VFLAGS) $(VERDE_BRILLANTE)$@$(RESET) -o $(BIN_FOLDER)/$(CIAN_BRILLANTE)$(@:.v=_vvp)$(RESET)\n"
	@$(IVERILOG) $(VERSION) $(VFLAGS) $@ -o $(BIN_FOLDER)/$(@:.v=_vvp)


# Regla para ejecutar simulaciones con vvp
$(EXE_TESTBENCHES):
	@echo -e '$(AZUL_FONDO)make $$(EXE_TESTBENCHES)$(RESET)'
	@echo -e "$(AZUL_BRILLANTE)make $@$(RESET) \n"
	@echo -e "$(VVP) $(BIN_FOLDER)/$(CIAN_BRILLANTE)$@$(RESET) \n"
	@$(VVP) $(BIN_FOLDER)/$@


# Regla para ejecutar archivos de onda .vcd con gtkwave
$(GTK_FILES):
	@echo -e '$(AZUL_FONDO)make $$(GTK_FILES)$(RESET)'
	@echo -e "$(AZUL_BRILLANTE)make $@$(RESET) \n"
	@echo -e "$(GTKWAVE) $(GTKWAVE_FOLDER)/$(CIAN_BRILLANTE)$@$(RESET)"
	@$(GTKWAVE) $(GTKWAVE_FOLDER)/$@


# Regla general para compilar, ejecutar, y ver formas de onda de salida
$(TESTBENCHES_ALL):
# testbench.v
	@echo -e '$(AZUL_FONDO)make $$(TESTBENCHES_ALL)$(RESET)'
	@echo -e "$(AZUL_BRILLANTE)make $@$(RESET)\n"
	@echo -e "$(IVERILOG) $(VERSION) $(VFLAGS) $(VERDE_BRILLANTE)$(@:_all=.v)$(RESET) -o $(BIN_FOLDER)/$(CIAN_BRILLANTE)$(@:_all=_vvp)$(RESET)\n"
	@$(IVERILOG) $(VERSION) $(VFLAGS) $(@:_all=.v) -o $(BIN_FOLDER)/$(@:_all=_vvp)
# exe_testbench
	@echo -e "$(VVP) $(BIN_FOLDER)/$(CIAN_BRILLANTE)$(@:_all=_vvp)$(RESET) \n"
	@$(VVP) $(BIN_FOLDER)/$(@:_all=_vvp)
# gtk
	@echo -e "\nnohup $(GTKWAVE) $(GTKWAVE_FOLDER)/$(CIAN_BRILLANTE)$(@:_all=.vcd)$(RESET) &"
	@nohup $(GTKWAVE) $(GTKWAVE_FOLDER)/$(@:_all=.vcd) &


# Regla para limpiar archivos ejecutables
clean:
	rm -rf $(BIN_FOLDER)/
	rm -rf $(GTKWAVE_FOLDER)/


# Regla para mostrar contenidos de las variables
mostrar_archivos:
	@echo "Modulos:"
	@echo "$(MODULES)"
	@echo -e "\nTestbenches:"
	@echo "$(TESTBENCHES)"
	@echo -e "\nExe_Testbenches:"
	@echo "$(EXE_TESTBENCHES)"
	@echo -e "\nGTK FILES:"
	@echo "$(GTK_FILES)"


help:
	@echo "  Ayuda para comandos Makefile (Verilog):"
	@echo "  make mkdir            -> Crea los directorios bin/, test/, y gtkwave/."
	@echo "  make <módulo>.v       -> Verifica la sintaxis de un archivo módulo específico."
	@echo "  make <testbench>.v    -> Compila un testbench específico y genera un ejecutable."
	@echo "  make <ejecutable>     -> Corre un testbench compilado con vvp."
	@echo "  make <archivo>.vcd    -> Abre un archivo de onda con gtkwave."
	@echo "  make clean            -> Limpia los archivos en bin/ y gtkwave/."
	@echo "  make mostrar_archivos -> Muestra los archivos definidos en las variables del Makefile."
	@echo "  make help             -> Muestra esta ayuda."


# -------------------------------------------------------------------
# Declaraciones .PHONY
# -------------------------------------------------------------------
.PHONY: mostrar_archivos $(MODULES) \
		$(TESTBENCHES) mkdir \
		$(EXE_TESTBENCHES) clean \
		$(GTK_FILES) help \