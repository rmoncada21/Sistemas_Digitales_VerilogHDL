module multiplexer4_to_1 (
    // Port declarations from the I/O diagram
    output out,
    input i0, i1, i2, i3,
    input s1, s0
);

// Use nested conditional operator
assign out = s1 ? (s0 ? i3 : i2) : (s0 ? i1 : i0);

endmodule