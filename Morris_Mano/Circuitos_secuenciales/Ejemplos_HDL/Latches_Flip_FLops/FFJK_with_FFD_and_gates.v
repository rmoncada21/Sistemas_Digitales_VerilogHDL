// Ejemplo 5.3 b)
`include "FFD_reset_async.v"

module FFJK( 
    output Q,
    // input clk, J, K, reset_async, data
    input clk, J, K, reset_async
);

    /* 
        NOTAR el uso de las EXPRESIONES 
        (cambian la salida en lógica secuencial) 
    */
    // reg D;
    // assign D = (J & ~Q) | (~K & Q);
    // assign D = (J * !Q) + (!K * Q);

    // Instanciar FFD
    FFD_reset_async FFD(
        .qd(Q),
        .clk(clk),
        /* 
            NOTAR el uso de las EXPRESIONES 
            (cambian la salida en lógica secuencial) 
        */
        // .data((J & ~Q) | (~K & Q)),
        .data((J * !Q) + (!K * Q)),
        // .data(Q?(!K):J),
        .reset_async(reset_async)
        // .data(data)
    );
endmodule

/*
Voy a explicar cómo se evalúan estas expresiones en Verilog:

1. **`assign mult = (x&~z)|(~y&z);`**

   En esta expresión, se evalúan las operaciones dentro de los paréntesis primero, y luego se realiza la operación OR (`|`) entre los resultados.

   - `x & ~z`: Primero se calcula la operación AND bit a bit entre `x` y el complemento de `z`.
   - `~y & z`: Luego se calcula la operación AND bit a bit entre el complemento de `y` y `z`.
   - Finalmente, se realiza la operación OR (`|`) entre los resultados de las operaciones anteriores.

   La evaluación es secuencial, primero se calculan los resultados de las operaciones internas y luego se realiza la operación final.

2. **`assign mult = (x*~z)+(~y*z);`**

   En esta expresión, primero se multiplican los operandos (`x * ~z` y `~y * z`), y luego se realiza la operación de suma (`+`) entre los resultados.

   - `x * ~z`: Se calcula la multiplicación bit a bit entre `x` y el complemento de `z`.
   - `~y * z`: Se calcula la multiplicación bit a bit entre el complemento de `y` y `z`.
   - Finalmente, se realiza la operación de suma (`+`) entre los resultados de las multiplicaciones anteriores.

   Al igual que en el primer caso, la evaluación es secuencial: primero se calculan los resultados de las multiplicaciones y luego se realiza la suma final.

En resumen, en ambas expresiones, las operaciones dentro de los paréntesis se evalúan primero y luego se aplica la operación externa (`|` o `+`). Esto sigue el orden de evaluación estándar en Verilog y en muchos lenguajes de programación, donde los paréntesis indican la prioridad de las operaciones.

*/

