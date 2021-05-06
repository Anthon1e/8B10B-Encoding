`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2021 01:41:36 PM
// Design Name: 
// Module Name: fcn5b6b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 3B/4B classification or the S function 
//              Figure 4 in Encoder diagram
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fcn3b(
    input clk, 
    input K,
    input [7:3] data_in,  
    input PDL6,
    input [5:0] L,
    output [4:0] data_buffer
    );
    wire F, G, H, E, D;
    assign {H, G, F, E, D} = data_in;
    wire NDL6 = ~PDL6;
    wire L13 = L[2];
    wire L31 = L[4];
    // Buffers to hold the values of F,G,H and K 
    reg S, F4, G4, H4, K4;
    always @(negedge clk) 
    begin
        F4 <= F; 
        G4 <= G;
        H4 <= H;
        K4 <= K;  
    end 
    // Bit encoding in 3B/4B Classifications
    // Redundant so obmitted here (see disCtrl function for more details) 
    // Flip flop to update value of S
    always @(posedge clk)
    begin
        S = (PDL6 & L31 & D & ~E) | (NDL6 & L13 & ~D & E);
    end
    assign data_buffer = {S, K4, H4, G4, F4};
endmodule
