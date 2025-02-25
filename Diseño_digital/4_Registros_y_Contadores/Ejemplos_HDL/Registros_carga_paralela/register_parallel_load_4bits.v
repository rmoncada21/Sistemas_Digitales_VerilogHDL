`include "register_parallel_load_1bit.v"

module register_parallel_load_4bits(
    output reg [3:0] An,
    input clk, carga, reset_async,
    input reg [3:0] In
);

    // reg [3:0] get_Q;

    register_parallel_load_1bit 
        rpl0(An[0], clk, carga, In[0], reset_async),
        rpl1(An[1], clk, carga, In[1], reset_async),
        rpl2(An[2], clk, carga, In[2], reset_async),
        rpl3(An[3], clk, carga, In[3], reset_async);

        // rpl0(get_Q[0], clk, carga, In[0], reset_async),
        // rpl1(get_Q[1], clk, carga, In[1], reset_async),
        // rpl2(get_Q[2], clk, carga, In[2], reset_async),
        // rpl3(get_Q[3], clk, carga, In[3], reset_async);

endmodule