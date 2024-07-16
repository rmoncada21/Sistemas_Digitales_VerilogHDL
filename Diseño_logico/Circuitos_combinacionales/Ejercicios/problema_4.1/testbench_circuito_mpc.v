module testbench_circuito_mfd;
    reg [3:0] in;
    wire F1, F2;

    // instanciación de circuito_mfd 
    circuito_mpc uut(
        .A(in[3]),
        .B(in[2]),
        .C(in[1]),
        .D(in[0]),
        .F1(F1),
        .F2(F2)
    );


    initial begin
        $display("\nTESTBENCH de circuito_mpc.v");
        in = 4'b0000;
        repeat(16) begin
            #10
            in = in + 1'b1;
        end

    end

    initial begin
        $display("ABCD  F1  F2");
        $monitor("%b  %b    %b", in, F1, F2);
    end
endmodule