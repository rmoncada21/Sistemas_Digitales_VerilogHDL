module test_circuit;
    reg [2:0] D;
    wire F1, F2;
    circuito_analisis dut(D[2], D[1], D[0], F1, F2);

    initial
    begin
        D = 3'b000;
        repeat(7)
        begin
            #10 D = D + 1'b1;
            if (F1)
                $display("ABC = %b F1 = %b F2 = %b", D, F1, F2);
        end
        $finish;
    end

endmodule
