module mux4x1_mfd(A, B, ES, Y);
    input reg [1:0] ES;
    input reg [3:0] A, B; 
    output reg [3:0] Y;

    assign
        Y[0] = (A[0] & ~ES[0] & ~ES[1]) | (B[0] & ES[0] & ~ES[1]),
        Y[1] = (A[1] & ~ES[0] & ~ES[1]) | (B[1] & ES[0] & ~ES[1]),
        Y[2] = (A[2] & ~ES[0] & ~ES[1]) | (B[2] & ES[0] & ~ES[1]),
        Y[3] = (A[3] & ~ES[0] & ~ES[1]) | (B[3] & ES[0] & ~ES[1]);
endmodule