module nonblocking;
  reg [3:0] data = 4'h4;
  real r_value = 1;
  integer i_value;
  time T;
  
  initial begin
    $monitor("At time T = %0t: data = %0d, r_value = %0f,", T, data, r_value);
    #2
    $display("a-Pasaron 2s");

    data = 5;
    r_value = 3;
    #2
    $display("b-Pasaron 2s");

    data <= 10;
    r_value <= data;
    #1
    $display("c-Pasaron 1s");

    data <= r_value;
    #1
    $display("d-Pasaron 1s");

    r_value <= data;
    data <= r_value;
    #2
    $display("e-Pasaron 2s");

    $finish;
  end
  
  always #1 T = $time;
endmodule