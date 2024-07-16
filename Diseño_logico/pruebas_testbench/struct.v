module TestStruct;
    typedef struct {
        logic [7:0] data;
        logic [3:0] addr;
        logic valid;
    } MyStruct;

    MyStruct myInstance;

    initial begin
        // Inicializar la estructura
        myInstance.data = 8'b11001100;
        myInstance.addr = 4'b0101;
        myInstance.valid = 1;

        // Acceder a los elementos de la estructura
        $display("Data: %b", myInstance.data);
        $display("Address: %b", myInstance.addr);
        $display("Valid: %b", myInstance.valid);
    end
endmodule
