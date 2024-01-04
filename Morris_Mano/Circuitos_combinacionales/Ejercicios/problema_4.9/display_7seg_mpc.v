module display_7seg_mpc(
    input reg [3:0] iBCD,
    output reg [6:0] abcdefg
);

    always@(iBCD) begin
        case(iBCD)
            4'b0000: abcdefg=7'b1111110;
            4'b0001: abcdefg=7'b0110000;
            4'b0010: abcdefg=7'b1101101;
            4'b0011: abcdefg=7'b1111001;
            4'b0100: abcdefg=7'b0110011;
            4'b0101: abcdefg=7'b1001011;
            4'b0110: abcdefg=7'b1001111;
            4'b0111: abcdefg=7'b1110000;
            // 4'b1000: abcdefg=7'b1111111;
            // 4'b1001: abcdefg=7'b1111011;
            default: abcdefg = 7'b0000000;
                
        endcase
    end

endmodule