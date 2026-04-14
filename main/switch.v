module switch(
    input [7:0] data_in,
    output [7:0] sw_out
    );
    
    assign sw_out = {data_in [3:0] , data_in [7:4]};
endmodule
