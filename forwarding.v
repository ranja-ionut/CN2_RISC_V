`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:06:27 PM
// Design Name: 
// Module Name: forwarding
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


module forwarding(input [4:0] rs1,
                  input [4:0] rs2,
                  input [4:0] ex_mem_rd,
                  input [4:0] mem_wb_rd,
                  input ex_mem_regwrite,
                  input mem_wb_regwrite,
                  output reg [1:0] forwardA,forwardB);
                  
    always@(*) begin
        forwardA = 0;
        forwardB = 0;
    
        if (ex_mem_regwrite == 1 && ex_mem_rd != 0 && ex_mem_rd == rs1)
            forwardA <= 2'b10;
        if (ex_mem_regwrite == 1 && ex_mem_rd != 0 && ex_mem_rd == rs2)
            forwardB <= 2'b10;
            
        if (mem_wb_regwrite == 1 && mem_wb_rd != 0
            && !(ex_mem_regwrite == 1 && ex_mem_rd != 0 && ex_mem_rd == rs1)
            && mem_wb_rd == rs1)
            forwardA <= 2'b01;
        if (mem_wb_regwrite == 1 && mem_wb_rd != 0
            && !(ex_mem_regwrite == 1 && ex_mem_rd != 0 && ex_mem_rd == rs2)
            && mem_wb_rd == rs2)
            forwardB <= 2'b01;
    end
                  
endmodule
