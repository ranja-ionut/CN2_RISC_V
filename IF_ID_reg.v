`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2020 08:06:51 PM
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg(input clk, reset, IF_ID_write,
                 input [31:0] PC_IF,
                 input [31:0] INSTRUCTION_IF,
                 output reg [31:0] PC_ID,
                 output reg [31:0] INSTRUCTION_ID);
  
      always@(posedge clk) begin
        if (reset) begin
          PC_ID <= 0;
          INSTRUCTION_ID <= 0;
        end
        else begin
          if(IF_ID_write) begin
            PC_ID <= PC_IF;
            INSTRUCTION_ID <= INSTRUCTION_IF;
          end
        end
      end
  
endmodule
