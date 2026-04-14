`timescale 1ns / 1ps

module sdes_tb();
    reg  [7:0] tb_plaintext;
    reg  [9:0] tb_key;
    wire [7:0] tb_ciphertext;

    sdes_top UUT (
        .plain_text(tb_plaintext),
        .key(tb_key),
        .cipher_text(tb_ciphertext)
    );

    initial begin
        tb_key       = 10'b1010000010; 
        tb_plaintext = 8'b01110010;
        #10; 
        
        tb_key       = 10'b0111111101; 
        tb_plaintext = 8'b10101010;
        #10;

        $finish;
    end
endmodule
