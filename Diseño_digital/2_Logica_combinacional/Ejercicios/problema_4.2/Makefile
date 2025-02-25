IVE = iverilog
ICDIFF = icdiff
VERSION = -g2012
VVP = vvp
GTK = gtkwave
VFLAGS = -Wall
SOURCES = $(wildcard *.v)
SOURCES_TXT = $(wildcard test/*.txt)
WAVEFILES = $(wildcard *.vcd)
MODULES = $(filter-out testbench_%, $(SOURCES))
TESTBENCHES = $(filter testbench_%, $(SOURCES))
EXE_MODULES = $(filter-out testbench_%, $(MODULES:.v=))
EXE_TESTBENCHES = $(filter testbench_%, $(TESTBENCHES:.v=))
VVP_TESTBENCHES = $(EXE_TESTBENCHES)
# utiliza patsubst para eliminar el prefijo "testbench_
MODULE_FROM_TESTBENCH = $(patsubst testbench_%,%,$(TESTBENCHES))
BIN_FOLDER = bin
TEST_FOLDER = tests
REFERENCIA = referencia.txt


# compila los modulos y los testbench al mismo tiempo
all: $(EXE_MODULES) $(EXE_TESTBENCHES) 

# regla para imprimir los modulos por separado
$(EXE_MODULES): $(MODULES)
%:%.v
	$(IVE) $(VFLAGS) $(VERSION) -o $(BIN_FOLDER)/$@ $^

# funciona para compilar las dependercias del testbench lllllllllllll
$(EXE_TESTBENCHES): $(MODULE_FROM_TESTBENCH)
%:%.v
	$(IVE) $(VFLAGS) $(VERSION) $(VFLAGS) -o $(BIN_FOLDER)/$@ $^

run: runm runt

runt: $(EXE_TESTBENCHES)
# 	$(VVP) $(BIN_FOLDER)/$^
# $(foreach file_in_bin, $(EXE_TESTBENCHES), $(VVP) $(BIN_FOLDER)/$(file_in_bin) > $(TEST_FOLDER)/referencia0000.txt; echo "";)
	$(foreach file_in_bin, $(EXE_TESTBENCHES), $(VVP) $(BIN_FOLDER)/$(file_in_bin); echo "";)
# $(foreach file_in_bin, $(EXE_TESTBENCHES), $(VVP) $(BIN_FOLDER)/$(file_in_bin) > $(TEST_FOLDER)/$(file_in_bin:=_output.txt); echo "";)


runm: $(EXE_MODULES)
# 	$(VVP) $(BIN_FOLDER)/$<
	$(foreach file_in_bin, $(EXE_MODULES), $(VVP) $(BIN_FOLDER)/$(file_in_bin); echo "";)

# icdiff <(vvp bin/testbench_circuito_simp_mfd) tests/referencia.txt
test: $(EXE_TESTBENCHES)
# $(foreach file_in_bin, $(EXE_TESTBENCHES), $(ICDIFF) $(TEST_FOLDER)/$(file_in_bin:=_output.txt) $(TEST_FOLDER)/$(REFERENCIA); echo "";)
# icdiff <(vvp bin/testbench_circuito_simp_mfd) tests/referencia.txt
	$(foreach file_in_bin, $(EXE_TESTBENCHES), $(ICDIFF) <($(VVP) $(BIN_FOLDER)/$(file_in_bin)) $(TEST_FOLDER)/$(REFERENCIA); echo "";)

clean:
	rm -f $(BIN_FOLDER)/*

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

.PHONY: all modules $(EXE_TESTBENCHES $(EXE_MODULES)) run clean help test



# de aca para abajo funciona
# IVE = iverilog
# VERSION = -g2012
# VVP = vvp
# GTK = gtkwave
# VFLAGS = -Wall
# SOURCES = $(wildcard *.v)
# WAVEFILES = $(wildcard *.vcd)
# MODULES = $(filter-out testbench_%, $(SOURCES))
# TESTBENCHES = $(filter testbench_%, $(SOURCES))
# EXE_MODULES = $(filter-out testbench_%, $(MODULES:.v=))
# EXE_TESTBENCHES = $(filter testbench_%, $(TESTBENCHES:.v=))
# # utiliza patsubst para eliminar el prefijo "testbench_
# MODULE_FROM_TESTBENCH = $(patsubst testbench_%,%,$(TESTBENCHES))

# # compila los modulos y los testbench al mismo tiempo
# all: $(EXE_MODULES) $(EXE_TESTBENCHES) 

# # regla para imprimir los modulos por separado
# $(EXE_MODULES):
# %:%.v
# 	$(IVE) $(VFLAGS) $(VERSION) -o bin/$@ $<

# # funciona para compilar las dependercias del testbench lllllllllllll
# $(EXE_TESTBENCHES): %:%.v $(MODULE_FROM_TESTBENCH)

# 	$(IVE) $(VFLAGS) $(VERSION) $(VFLAGS) -o bin/$@ $< $(MODULE_FROM_TESTBENCH)

# run: runm runt

# runt: $(EXE_TESTBENCHES)
# 	$(VVP) bin/$<

# runm: $(EXE_MODULES)
# 	$(VVP) bin/$<

# clean:
# 	rm -f bin/*

# gitignore: 
# 	echo "$(EXE_MODULES)" > .gitignore
# 	echo "$(EXE_TESTBENCHES)" >> .gitignore

# gtk: $(WAVEFILES)
# 	$(GTK) $(WAVEFILES)

# help:
# 	@echo make all 
# 	@echo make modules
# 	@echo make testbench_nombre_modulo.v
# 	@echo make nombre_modulo.v
# 	@echo make run "run a executable"
# 	@echo make clean
# 	@echo make gitignore
# 	@echo make gtk

# .PHONY: all modules $(EXE_TESTBENCHES $(EXE_MODULES)) run clean help
