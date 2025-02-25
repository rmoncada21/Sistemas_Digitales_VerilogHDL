## Ejemplo 4.1 HDL Decode 2x4 con entrada Enable


![image](img/decode2x4.png)

![image](img/decode2x4_code.png)


## Ejemplo 4.2 Diseño jerarquico ascendente

### Semisumador
![image](img/half_adder.png)

### Sumador Completo

![image](img/full_adder.png)


### Sumador de 4 bits 

![image](img/4bits_adder.png)


## Ejemplo 4.10 TESTBENCH Circuito de análisis
![Imagen](img/ejemplo_analisis.png)

~~~verilog
module test_circuit;
    reg [2:0]D;
    wire F1,F2;
    circuito_analisis dut(D[2],D[1],D[0],F1,F2);
    
    initial
        begin
        D = 3'b000;
        repeat(7)
        #10 D = D + 1'b1;
    end
    initial
        $monitor ("ABC = %b F1 = %b F2 =%b ",D, F1, F2);
endmodule
~~~

- Las entradas oara estimular el circuito se especifican con un vector reg de tres bits llamda D.
D[2]: equivale a la entrada A. 
D[1]: a la entrada B
D[0]: a la entrada C

- Las salidas F1 Y F2 se declaran **wire**
- El ciclo repeat proporciona los 7 numeros binario que siguen a 000 para la tabla de verdad.
