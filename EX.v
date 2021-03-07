`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:06:27 PM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX, // 
          input [31:0] REG_DATA1_EX, //
          input [31:0] REG_DATA2_EX, //
          input [31:0] PC_EX, //
          input [2:0] FUNCT3_EX, //
          input [6:0] FUNCT7_EX, //
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX, //
          input ALUSrc_EX, //
          input Branch_EX, //
          input [1:0] forwardA,forwardB, //
          
          input [31:0] ALU_DATA_WB, //
          input [31:0] ALU_OUT_MEM, //
          
          output ZERO_EX, //
          output [31:0] ALU_OUT_EX, //
          output [31:0] PC_Branch_EX, //
          output [31:0] REG_DATA2_EX_FINAL //
          );
    
    wire[3:0] ALUinput;
    wire[31:0] reg_imm_out;
    wire[31:0] PC_branch;
    wire[31:0] rs1, rs2;
    
    mux4_1 muxA(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 0, forwardA, rs1); // forward A
    
    mux4_1 muxB(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 0, forwardB, rs2); // forward B
    
    ALUcontrol control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput); // ALUcontrol
    
    mux2_1 reg_imm(rs2, IMM_EX, ALUSrc_EX, reg_imm_out); // forward B sau imm
    
    ALU alu(ALUinput, rs1, reg_imm_out, ZERO_EX, ALU_OUT_EX); // ALU
    
    adder adder(PC_EX, IMM_EX, PC_branch); // adder pentru branch
    
    assign PC_Branch_EX = PC_branch;
    assign REG_DATA2_EX_FINAL = rs2;
          
endmodule
