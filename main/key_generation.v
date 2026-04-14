module key_generation(
    input [9:0] key,
    output [7:0] k1, k2
    );
    //p10
    wire [9:0] permutation_10; //p3 p5 p2 p7 p4 p10 p1 p9 p8 p6
    assign permutation_10 [9] = key [7] ;
    assign permutation_10 [8] = key [5] ;
    assign permutation_10 [7] = key [8] ;
    assign permutation_10 [6] = key [3] ;
    assign permutation_10 [5] = key [6] ;
    assign permutation_10 [4] = key [0] ;
    assign permutation_10 [3] = key [9] ;
    assign permutation_10 [2] = key [1] ;
    assign permutation_10 [1] = key [2] ;
    assign permutation_10 [0] = key [4] ;
    
    //splitting into 2 blocks of 5 bits
    wire [4:0] left  = permutation_10[9:5];
    wire [4:0] right = permutation_10[4:0];
    
    //ls1
    wire [4:0] left_ls1 = {left[3:0], left[4]};
    wire [4:0] right_ls1 = {right[3:0], right[4]};
    
    //p8
    wire [9:0] before_p8;
    assign before_p8 = {left_ls1, right_ls1};
    wire [7:0] permutation_8; //p2 p6 p3 p1 p4 p8 p5 p7
    assign permutation_8 = { before_p8[4], before_p8[7],before_p8[3], before_p8[6], before_p8[2], before_p8[5], before_p8[0], before_p8[1]};
    assign k1 = permutation_8;
    
    //ls2
    wire [4:0] left_ls1_ls2 = {left_ls1 [2:0], left_ls1[4:3]};
    wire [4:0] right_ls1_ls2 = {right_ls1 [2:0], right_ls1 [4:3]};
    
    //second p8
    wire [9:0] before_second_p8;
    wire [7:0] second_permutation_8;
    assign second_permutation_8 = {before_second_p8[4], before_second_p8[7], before_second_p8[3],  before_second_p8[6],  before_second_p8[2],  before_second_p8[5],  before_second_p8[0],  before_second_p8[1]};
    assign k2 = second_permutation_8;
endmodule
