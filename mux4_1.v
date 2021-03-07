`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2020 05:30:54 PM
// Design Name: 
// Module Name: mux4_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4_1(
    input [31:0] ina, inb, inc, ind,
    input [1:0] sel,
    output [31:0] out
    );
    
    assign out = sel == 2'b00 ? ina
               : sel == 2'b01 ? inb
               : sel == 2'b10 ? inc
               : sel == 2'b11 ? ind : 0;
    
endmodule
