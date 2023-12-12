IVE = iverilog
VERSION = -g2012
VVP = vvp
VFLAGS = -Wall
SOURCES = $(wildcard *.v)
MODULES = $(filter-out testbench_%, $(SOURCES))
TESTBENCHES = $(filter testbench_%, $(SOURCES))
EXE_MODULES = $(filter-out testbench_%, $(MODULES:.v=))
EXE_TESTBENCHES = $(filter testbench_%, $(TESTBENCHES:.v=))
# utiliza patsubst para eliminar el prefijo "testbench_
MODULE_FROM_TESTBENCH = $(patsubst testbench_%,%,$(TESTBENCHES))

all: modules $(EXE_TESTBENCHES)

modules: $(EXE_MODULES)
# testbenches: $(EXE_TESTBENCHES)
%:%.v
	$(IVE) $(VFLAGS) $(VERSION) -o $@ $<

# funciona para compilar las dependercias del testbench
$(EXE_TESTBENCHES): $(MODULE_FROM_TESTBENCH) $(TESTBENCHES)
	$(IVE) $(VERSION) -o $@ $(VFLAGS) $^

# reglar para imprimir los modulos por separado
$(EXE_MODULES): $(MODULES)
	$(IVE) $(VERSION) -o $@ $(VFLAGS) $^

run: $(EXE_TESTBENCHES)
	$(VVP) $(EXE_TESTBENCHES)

clean:
	rm -f $(EXE_MODULES) $(EXE_TESTBENCHES)

gitignore: 
	echo "$(EXE_MODULES)" > .gitignore
	echo "$(EXE_TESTBENCHES)" >> .gitignore

help:
	@echo make all 
	@echo make modules
	@echo make testbench_nombre_modulo.v
	@echo make nombre_modulo.v
	@echo make run "run a executable"
	@echo make clean
	@echo make gitignore

.PHONY: all modules $(EXE_TESTBENCHES $(EXE_MODULES)) run clean help
