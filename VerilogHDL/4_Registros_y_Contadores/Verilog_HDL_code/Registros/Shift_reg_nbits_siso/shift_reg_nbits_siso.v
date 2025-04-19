module shift_reg_nbits_siso #(parameter N=4)(
    input clk, si, 
    output reg [N-1:0] shift
);

    always @(posedge clk) begin
        shift <= {si, shift[N-1:1]};
    end
endmodule