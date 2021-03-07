`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2020 08:07:13 PM
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg(input clk, reset, write,
                  input RegWrite_MEM, MemtoReg_MEM,
                  input [31:0] DATA_MEMORY_MEM,
                  input [31:0] ALU_OUT_MEM,
                  input [4:0] RD_MEM,
                                  
                  output reg RegWrite_WB, MemtoReg_WB,
                  output reg [31:0] DATA_MEMORY_WB,
                  output reg [31:0] ALU_OUT_WB,
                  output reg [4:0] RD_WB);
                  
    always@(posedge clk) begin
        if (reset == 1) begin
            RegWrite_WB <= 0;
            MemtoReg_WB <= 0;
            DATA_MEMORY_WB <= 0;
            ALU_OUT_WB <= 0;
            RD_WB <= 0;
        end else begin
            if (write == 1) begin
                RegWrite_WB <= RegWrite_MEM;
                MemtoReg_WB <= MemtoReg_MEM;
                DATA_MEMORY_WB <= DATA_MEMORY_MEM;
                ALU_OUT_WB <= ALU_OUT_MEM;
                RD_WB <= RD_MEM;
            end
        end
    end
                
endmodule
