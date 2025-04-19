`include "FFD_reset_async.v"

module extern_FFD( 
    output Q,
    input clk, reset_async, a, b, data
);

    // reg D;
    // assign D = (J & ~Q) | (~K & Q);
    reg m;
    assign m = a*b;
    // Instanciar FFD
    FFD_reset_async FFD(
        .qd(Q),
        .clk(clk),
        .reset_async(reset_async),
        .data(m)
        // .data(a&b)
    );
endmodule