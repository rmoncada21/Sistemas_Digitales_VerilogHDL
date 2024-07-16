module circuito_simp_mfd(A, B, C, D, F, G);
    input A, B, C, D;
    output F, G;
    reg reg_f, reg_g;

    always @* begin 
        reg_f = (~A&D) | (~A&B&C&D) | (A&B&C);
        reg_g = (~A&~D) | (B&C&~D) | (A&B&C);
    end 

    assign F = reg_f;
    assign G = reg_g;

endmodule 