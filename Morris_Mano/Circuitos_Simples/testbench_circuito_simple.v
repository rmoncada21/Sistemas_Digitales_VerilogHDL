module testbench_circuito_simple;
    reg A,B,C;
    wire x,y;

    circuito_simple uut(A,B,C,x,y);
    initial begin
        // código para generar archivo vcd para gtkwave
        $dumpfile("testbench_circuito_simple.vcd");
        $dumpvars(0, testbench_circuito_simple);
        A = 1'b0; B = 1'b0; C = 1'b0;
        #100
        A = 1'b1; B = 1'b1; C = 1'b1;
        #100 
        $finish;
    end

endmodule