module ip_inverse(
    input [7:0] data_in,
    output [7:0] ct
    );
    
    // in cryptography algorith: c4 c1 c3 c5 c7 c2 c8 c6
    assign ct = {data_in[4], data_in[7], data_in[5], data_in[3], data_in[1], data_in[6], data_in[0], data_in[2]};
endmodule
