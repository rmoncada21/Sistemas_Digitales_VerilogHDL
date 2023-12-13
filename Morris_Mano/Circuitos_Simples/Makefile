IVE = iverilog
VERSION = -g2012
VVP = vvp
GTK = gtkwave
VFLAGS = -Wall
SOURCES = $(wildcard *.v)
WAVEFILES = $(wildcard *.vcd)
MODULES = $(filter-out testbench_%, $(SOURCES))
TESTBENCHES = $(filter testbench_%, $(SOURCES))
EXE_MODULES = $(filter-out testbench_%, $(MODULES:.v=))
EXE_TESTBENCHES = $(filter testbench_%, $(TESTBENCHES:.v=))
# utiliza patsubst para eliminar el prefijo "testbench_
MODULE_FROM_TESTBENCH = $(patsubst testbench_%,%,$(TESTBENCHES))

# compila los modulos y los testbench al mismo tiempo
all: $(EXE_MODULES) $(EXE_TESTBENCHES) run

# reglar para imprimir los modulos por separado
$(EXE_MODULES):
%:%.v
	$(IVE) $(VFLAGS) $(VERSION) -o bin/$@ $<

# funciona para compilar las dependercias del testbench
$(EXE_TESTBENCHES): $(MODULE_FROM_TESTBENCH) $(TESTBENCHES)
	$(IVE) $(VFLAGS) $(VERSION) -o bin/$@ $(VFLAGS) $^


run: $(EXE_TESTBENCHES)
	$(VVP) bin/$<

clean:
	rm -f bin/*

gitignore: 
	echo "$(EXE_MODULES)" > .gitignore
	echo "$(EXE_TESTBENCHES)" >> .gitignore

gtk: $(WAVEFILES)
	$(GTK) $(WAVEFILES)

help:
	@echo make all 
	@echo make modules
	@echo make testbench_nombre_modulo.v
	@echo make nombre_modulo.v
	@echo make run "run a executable"
	@echo make clean
	@echo make gitignore
	@echo make gtk

.PHONY: all modules $(EXE_TESTBENCHES $(EXE_MODULES)) run clean help
