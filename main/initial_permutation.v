module initial_permutation(
    input [7:0] plain_text,
    output [7:0] ip_out
    );
    // 2 6 3 1 4 8 5 7
    // to remember: verilog index (i) is not the same as the algorithm index (p)
    // p1 p2 p3 p4 p5 p6 p7 -> p2 p6 p5 p1 p4 p8 p5 p7
    // i7 i6 i5 i3 i3 i2 i1 i0 -> i6 i2 i5 i7 i4 i0 i3 i1
    assign ip_out [7] = plain_text [6];
    assign ip_out [6] = plain_text [2];
    assign ip_out [5] = plain_text [5];
    assign ip_out [4] = plain_text [7];
    assign ip_out [3] = plain_text [4];
    assign ip_out [2] = plain_text [0];
    assign ip_out [1] = plain_text [3];
    assign ip_out [0] = plain_text [1];
endmodule
