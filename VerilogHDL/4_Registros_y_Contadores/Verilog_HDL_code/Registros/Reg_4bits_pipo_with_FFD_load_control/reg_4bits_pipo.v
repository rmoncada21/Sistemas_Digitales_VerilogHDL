`include "reg_1bit_pipo_with_FFD_load_control.v"

module reg_4bits_pipo_with_FFD_load_control(
    input carga, reloj,
    input [3:0] In,
    output [3:0] An
);

    // Instanciar el registro con control de carga
    reg_1bit_pipo_with_FFD_load_control
        reg_pipo_0(.carga(carga),.reloj(reloj),.In(In[0]),.An(An[0])),
        reg_pipo_1(.carga(carga),.reloj(reloj),.In(In[1]),.An(An[1])),
        reg_pipo_2(.carga(carga),.reloj(reloj),.In(In[2]),.An(An[2])),
        reg_pipo_3(.carga(carga),.reloj(reloj),.In(In[3]),.An(An[3]));
endmodule