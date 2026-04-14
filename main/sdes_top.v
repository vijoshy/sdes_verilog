`timescale 1ns / 1ps

module sdes_top(
    input [7:0] plain_text,
    input [9:0] key,
    output [7:0] cipher_text
    );
    
    //wires from stages
    wire  [7:0] ip_to_feistel;
    wire [7:0] k1_wire, k2_wire;
    wire [7:0] fk1_op;
    wire [7:0] fk_to_sw, sw_op;
    wire [7:0] fk_to_ip_inverse;
    
    //instantiation 
    initial_permutation d1 (.plain_text(plain_text), .ip_out(ip_to_feistel));
    key_generation d2 (.key(key), .k1(k1_wire), .k2(k2_wire));
    feistel_k d3 (.ip_op(ip_to_feistel), .k1(k1_wire), .fk_op(fk1_op));
    switch d4 (.data_in(fk_to_sw), .sw_out(sw_op));
    feistel_k d5 (.ip_op(sw_out), .k2_wire(k1), .fk_op(fk_to_ip_inverse));
    ip_inverse d6 (.fk_to_ip_inverse(data_in), .ct(cipher_text));
endmodule
