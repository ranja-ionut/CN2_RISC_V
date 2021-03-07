`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2020 08:06:51 PM
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg( input clk, reset, write,
                  input RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUSrc_ID, Branch_ID,
                  input [1:0] ALUop_ID,
                  input [31:0] PC_ID, REG_DATA1_ID, REG_DATA2_ID, IMM_ID,
                  input [6:0] FUNCT7_ID,
                  input [2:0] FUNCT3_ID,
                  input [4:0] RS1_ID, RS2_ID, RD_ID,
                                 
                  output reg RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX,
                  output reg [1:0] ALUop_EX,
                  output reg [31:0] PC_EX, REG_DATA1_EX, REG_DATA2_EX, IMM_EX,
                  output reg [6:0] FUNCT7_EX, 
                  output reg [2:0] FUNCT3_EX,
                  output reg [4:0] RS1_EX, RS2_EX, RD_EX);
                  
    always@(posedge clk) begin
        if (reset == 1) begin
            RegWrite_EX <= 0;
            MemtoReg_EX <= 0;
            MemRead_EX <= 0;
            MemWrite_EX <= 0;
            ALUSrc_EX <= 0;
            Branch_EX <= 0;
            ALUop_EX <= 0;
            PC_EX <= 0;
            REG_DATA1_EX <= 0;
            REG_DATA2_EX <= 0;
            IMM_EX <= 0;
            FUNCT7_EX <= 0;
            FUNCT3_EX <= 0;
            RS1_EX <= 0;
            RS2_EX <= 0;
            RD_EX <= 0;
        end else begin
            if (write == 1) begin
                RegWrite_EX <= RegWrite_ID;
                MemtoReg_EX <= MemtoReg_ID;
                MemRead_EX <= MemRead_ID;
                MemWrite_EX <= MemWrite_ID;
                ALUSrc_EX <= ALUSrc_ID;
                Branch_EX <= Branch_ID;
                ALUop_EX <= ALUop_ID;
                PC_EX <= PC_ID;
                REG_DATA1_EX <= REG_DATA1_ID;
                REG_DATA2_EX <= REG_DATA2_ID;
                IMM_EX <= IMM_ID;
                FUNCT7_EX <= FUNCT7_ID;
                FUNCT3_EX <= FUNCT3_ID;
                RS1_EX <= RS1_ID;
                RS2_EX <= RS2_ID;
                RD_EX <= RD_ID;
            end
        end
    end
    
endmodule
