
// Modelado por comportamiento

module gray_binary_mpc(
    input reg [3:0] GRAY,
    output reg [3:0] wxyz
);

    // Modelado Convertir código GRAY a binario
    always @(GRAY) begin
            case(GRAY)
            4'b0000:
                wxyz = 4'b0000;
            4'b0001:
                wxyz = 4'b0001;
            4'b0011:
                wxyz = 4'b0010;
            4'b0010:
                wxyz = 4'b0011;
            4'b0110:
                wxyz = 4'b0100;
            4'b0111:
                wxyz = 4'b0101;
            4'b0101:
                wxyz = 4'b0110;
            4'b0100:
                wxyz = 4'b0111;
            4'b1100:
                wxyz = 4'b1000;
            4'b1101:
                wxyz = 4'b1001;
            4'b1111:
                wxyz = 4'b1010;
            4'b1110:
                wxyz = 4'b1011;
            4'b1010:
                wxyz = 4'b1100;
            4'b1011:
                wxyz = 4'b1101;
            4'b1001:
                wxyz = 4'b1110;
            4'b1000:
                wxyz = 4'b1111;
            default:
                $display("ERROR Defautl en circuito");
        endcase
    end
endmodule