# target: prerrequisites
# command to build target

# crear el comando de compilación 
# iverilog -g2012 -Wall  archivo.v -o bin/archivo 

# Variables
APP=
CODE=$(patsubst %.v,%,$(APP))
IVERILOG=iverilog
VPP=vpp
VERSION=-g2012
VFLAGS=-Wall
OUTPUT=-o
TOP=-s
# Folder
BIN_FOLDER=bin
SRC_FOLDER=src

# Reglas
all:

code: $(APP)
	mkdir -p $(BIN_FOLDER)
	$(IVERILOG) $(VERSION) $(VFLAGS) $(APP) $(OUTPUT) $(BIN_FOLDER)/$(CODE)

run: $(APP)
	$(VPP) $(BIN_FOLDER)/$(CODE)

clean:
	rm -rf $(BIN_FOLDER)/*

.PHONY: all code run clean