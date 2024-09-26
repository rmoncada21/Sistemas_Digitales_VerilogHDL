module test
    // Registros
    reg variable;
    
    // Integer - real
    integer numero_entero;
    real numero_real;

    // Vectores
    wire [7:0] bus; // vector de 8 bits
    reg [7:0] busA;

    // Arrays
    reg contador[0:7]; // arreglo de 8 elementos, cada elemento de 1 bit
    reg [4:0] port_id[0:7]; // Arreglo de 8 elementos port_id; cada port_id contiene 5 bits de ancho


    // Memorias
    reg mem1bit [0:1023]; // Memoria mem1bit de 1K de 1-bit de palabra
    reg [7:0] membyte[0:1023]; // Memoria membyte con 1k de 8-bits de palabra

endmodule