module testbench_delay;
    reg A,B,C;
    wire x,y;

    delay uut(A,B,C,x,y);
    initial begin
        // código para generar archivo vcd para gtkwave
        $dumpfile("testbench_delay.vcd");
        $dumpvars(0, testbench_delay);
        A = 1'b0; B = 1'b0; C = 1'b0;
        #100
        A = 1'b1; B = 1'b1; C = 1'b1;
        #100 
        $finish;
    end

endmodule