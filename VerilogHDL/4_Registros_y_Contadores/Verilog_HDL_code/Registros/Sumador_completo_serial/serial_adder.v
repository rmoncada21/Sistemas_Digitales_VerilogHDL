/*
============================================================
Módulo: serial_adder
Descripción: 

Serial adder
    - Carga 8 bits en serie a través de la entrada `si`, uno por ciclo de reloj.
    - Los primeros 4 bits se almacenan en `regA` (operando A).
    - Los siguientes 4 bits se almacenan en `regB` (operando B).
    - Luego, realiza una suma bit a bit (LSB primero) de A + B.
    - El resultado de la suma se guarda en `result`.
    - La señal `done` se activa al completar la operación.

Características:
    - Arquitectura secuencial controlada por una máquina de estados.
    - Basado en lógica síncrona positiva con reset activo en bajo.
    - Suma serial: solo se usa 1 bit por ciclo

============================================================
*/

module serial_adder #(parameter N = 4)(
    input clk,               // Reloj del sistema
    input start,             // Señal para iniciar la operación
    input si,                // Entrada serial (1 bit por ciclo)
    input reset,             // Reset asincrónico activo en bajo
    output reg done,         // Señal de operación finalizada
    output reg [N-1:0] result // Resultado de la suma serial
);

    // Definición de estados de la máquina de estados
    localparam  IDLE = 2'b00,
                LOAD = 2'b01,
                RUN  = 2'b10,
                DONE = 2'b11;

    // Registros internos
    reg [N-1:0] regA;        // Operando A (4 bits)
    reg [N-1:0] regB;        // Operando B (4 bits)
    reg [2:0] contador;      // Contador general (hasta 8 para carga)
    reg [1:0] state;         // Estado actual
    reg carry;               // Acarreo de la suma

    // Lógica de suma por bit
    wire a_bit = regA[0];
    wire b_bit = regB[0];
    wire sum_bit = a_bit ^ b_bit ^ carry;
    wire next_carry = (a_bit & b_bit) | (a_bit & carry) | (b_bit & carry);

    // Máquina de estados secuencial
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset asincrónico
            regA <= 0;
            regB <= 0;
            contador <= 0;
            carry <= 0;
            done <= 0;
            state <= IDLE;
        end else begin
            case (state)
                // Estado IDLE: espera a que se inicie el proceso
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        regA <= 0;
                        regB <= 0;
                        contador <= 0;
                        carry <= 0;
                        state <= LOAD;
                    end
                end

                // Estado LOAD: carga 8 bits en total -> A y luego B
                LOAD: begin
                    if (contador < N)
                        regA <= {si, regA[N-1:1]}; // Bits 0 a 3 -> A
                    else
                        regB <= {si, regB[N-1:1]}; // Bits 4 a 7 -> B

                    contador <= contador + 1;

                    // Después de 8 bits, pasar a suma
                    if (contador == 7) begin
                        contador <= 0;
                        state <= RUN;
                    end
                end

                // Estado RUN: realiza suma serial bit a bit
                RUN: begin
                    regA <= {sum_bit, regA[N-1:1]}; // Resultado parcial en A
                    regB <= {1'b0, regB[N-1:1]};    // Desplazar B
                    carry <= next_carry;
                    contador <= contador + 1;

                    // Después de N ciclos, resultado completo
                    if (contador == N - 1) begin
                        result <= regA;
                        state <= DONE;
                    end
                end

                // Estado DONE: activa señal de finalización
                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
