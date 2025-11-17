// Simple Verilog Netlist for Tcl/Tk GUI Demo

module INVX1 (input A, output Y);
endmodule

module NAND2X1 (input A, B, output Y);
endmodule

module ALU (input A, B, output Y);
    wire n1;

    INVX1   U1 (.A(A),    .Y(n1));
    NAND2X1 U2 (.A(n1),   .B(B), .Y(Y));
endmodule

module TOP (input A, B, output Y);
    wire n2;

    ALU      U_ALU (.A(A),  .B(B), .Y(n2));
    INVX1    U_INV (.A(n2), .Y(Y));
endmodule

