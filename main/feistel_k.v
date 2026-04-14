module feistel_k(
    input [7:0] ip_op,
    input [7:0] k1,
    output [7:0] fk_op
);
//splitting into 2 blocks of 4 bits
    wire [3:0] fk1_left = ip_op [7:4];
    wire [3:0] fk1_right= ip_op [3:0];
    
    //expanded permutation
    wire [7:0] ep;
    assign ep = { fk1_right[0], fk1_right[3], fk1_right[2], fk1_right[1], fk1_right[2], fk1_right[1], fk1_right[0], fk1_right[3]};
    
    //xoring with k1
    wire [7:0] xork1 = ep ^ k1;
    
    //splitting xord k1
    wire [3:0] xork1_left = xork1 [7:4];
    wire [3:0] xork1_right = xork1 [3:0];

    //substitution boxes
    wire [3:0] s0_index = {xork1_left[3], xork1_left[0], xork1_left[2], xork1_left[1]};
    wire [3:0] s1_index = {xork1_right[3], xork1_right[0], xork1_right[2], xork1_right[1]};
    reg [1:0] s0_out;
    reg [1:0] s1_out;

    // S-Box 0 Lookup Table
    always @(*) begin
        case (s0_index)
            4'b00_00: s0_out = 2'b01; 
            4'b00_01: s0_out = 2'b00; 
            4'b00_10: s0_out = 2'b11; 
            4'b00_11: s0_out = 2'b10; 
            
            4'b01_00: s0_out = 2'b11; 
            4'b01_01: s0_out = 2'b10; 
            4'b01_10: s0_out = 2'b01; 
            4'b01_11: s0_out = 2'b00; 
            
            4'b10_00: s0_out = 2'b00; 
            4'b10_01: s0_out = 2'b10; 
            4'b10_10: s0_out = 2'b01; 
            4'b10_11: s0_out = 2'b11; 
            
            4'b11_00: s0_out = 2'b11; 
            4'b11_01: s0_out = 2'b01; 
            4'b11_10: s0_out = 2'b11; 
            4'b11_11: s0_out = 2'b10; 
            
            default:  s0_out = 2'b00;
        endcase
    end

    // S-Box 1 Lookup Table
    always @(*) begin
        case (s1_index)
            4'b00_00: s1_out = 2'b00; 
            4'b00_01: s1_out = 2'b01;
            4'b00_10: s1_out = 2'b10;
            4'b00_11: s1_out = 2'b11;
            
            4'b01_00: s1_out = 2'b10;
            4'b01_01: s1_out = 2'b00; 
            4'b01_10: s1_out = 2'b01;
            4'b01_11: s1_out = 2'b11;
            
            4'b10_00: s1_out = 2'b11;
            4'b10_01: s1_out = 2'b00;
            4'b10_10: s1_out = 2'b01;
            4'b10_11: s1_out = 2'b00; 
            
            4'b11_00: s1_out = 2'b10; 
            4'b11_01: s1_out = 2'b01; 
            4'b11_10: s1_out = 2'b00;
            4'b11_11: s1_out = 2'b11; 
            
            default:  s1_out = 2'b00; 
        endcase
    end
    wire [3:0] sbox_combined = {s0_out, s1_out};
    
    //p4
    wire [3:0] p4 = { sbox_combined[2], sbox_combined[0], sbox_combined[1], sbox_combined[3] };
    
    //xoring p4 with left half of ip
    wire [3:0]  xor2 = fk1_left ^ p4;
    
    assign fk_op = { xor2, fk1_right };
endmodule
