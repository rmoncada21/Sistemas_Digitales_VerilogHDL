IVE = iverilog
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
	$(IVE) $(VFLAGS) -o $@ $<

# funciona para compilar las dependercias del testbench
$(EXE_TESTBENCHES): $(MODULE_FROM_TESTBENCH) $(TESTBENCHES)
	$(IVE) -o $@ $(VFLAGS) $^

# reglar para imprimir los modulos por separado
$(EXE_MODULES): $(MODULES)
	$(IVE) -o $@ $(VFLAGS) $^

run: $(EXE_TESTBENCHES)
	$(VVP) $(EXE_TESTBENCHES)

clean:
	rm -f $(EXE_MODULES) $(EXE_TESTBENCHES)

.PHONY: all modules $(EXE_TESTBENCHES $(EXE_MODULES)) run clean
