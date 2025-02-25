module testbench_mux2x1;
    reg TA, TB, TS;
    wire TY;

    // instanciacion
    mux2x1 uut(TA, TB, TS, TY);
    initial
        begin   
            TS = 1; TA = 0; TB = 1;
            #10
            TA = 1; TB = 0;
            #10
            TS = 0;
            #10
            TA = 0; TB = 1;
        end 
    initial 
        $monitor("select = %b A = %b B = %b OUT = %b time = %0d", TS, TA, TB, Y, $time);
endmodule