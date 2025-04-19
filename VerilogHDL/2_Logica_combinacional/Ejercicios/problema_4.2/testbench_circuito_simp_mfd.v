module testbench_circuito_simp_mfd;
    reg [3:0] in;
    wire F, G;


    circuito_simp_mfd uut(
        .A(in[3]),
        .B(in[2]),
        .C(in[1]),
        .D(in[0]),
        .F(F),
        .G(G)
    );

    task gen_table;
        reg [3:0] in_task;
        $display("testbench_circuito_simp_mfd");
        $display("A B C D| F G");

        for (int i=0; i<=15; i++) begin 
            in_task = in;
            #10;
            $display("%b %b %b %b| %b %b", in_task[3], in_task[2], in_task[1], in_task[0], F, G);
            in = in + 1;
        end
        $finish;
    endtask

    initial begin
        in = 4'b0000;
        gen_table;
    end
endmodule 