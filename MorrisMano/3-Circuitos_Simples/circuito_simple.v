//Libro Morris Mano pag 101
//Descripción del circuito simple de la fig 3-37

module circuito_simple ();
input A,B,C;
output x,y;
    wire e;
    and a1(e,A,B);
    not n2(y,C);
    or o3(x,e,y);

endmodule


//circtuio simple parametizables
module circuito_simple_con_retardo (A,B,C,x,y);
input A,B,C;
output x,y;
wire e;
    and #(30) a1(e,A,B);
    not #(20) n2(y,C);
    or  #(10) o3(x,e,y);

endmodule

//Estimulo para circuito simple
/* estimulo -> parecido a un testbench
no tiene puertos */
module estimulo;
reg A,B,C;
wire x,y;
circuito_simple_con_retardo ccr(A,B,C,x,y);

initial 
    begin
        A = 1'b0; B = 1'b0; C = 1'b0;
        #100

        A = 1'b1; B = 1'b1; C = 1'b1;
        #100 $finish;
        
    end
    
endmodule