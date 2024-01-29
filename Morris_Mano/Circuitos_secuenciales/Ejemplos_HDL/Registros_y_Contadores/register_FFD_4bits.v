`include "FFD_reset_async.v"

module register_FFD_4bits(
    output [3:0] An,
    input clk, clear,
    input [3:0] In
);
    FFD_reset_async
        FFD0(An[0],clk, In[0], clear),
        FFD1(An[1],clk, In[1], clear),
        FFD2(An[2],clk, In[2], clear),
        FFD3(An[3],clk, In[3], clear);

endmodule