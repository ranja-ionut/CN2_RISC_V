`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:14:56 PM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
                      
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall);

    // IF wires
    wire PC_write; // DONE
    wire [31:0] PC_Branch; // DONE
    wire [31:0] PC_IF, INSTRUCTION_IF; // DONE

    // ID wires
    wire [31:0] PC_ID, INSTRUCTION_ID; // DONE
    wire RegWrite_WB; // DONE
    wire [4:0] RD_WB; // DONE
    wire [31:0] IMM_ID; // x
    wire [31:0] REG_DATA1_ID, REG_DATA2_ID; // x
    wire [2:0] FUNCT3_ID; // x
    wire [6:0] FUNCT7_ID; // x
    wire [6:0] OPCODE_ID; // x
    wire [4:0] RD_ID; // x
    wire [4:0] RS1_ID; // x
    wire [4:0] RS2_ID; // x
    
    // EX wires
    wire [31:0] IMM_EX;
    wire [31:0] REG_DATA1_EX;
    wire [31:0] REG_DATA2_EX;
    wire [2:0] FUNCT3_EX;
    wire [6:0] FUNCT7_EX;
    wire [4:0] RD_EX;
    wire [4:0] RS1_EX;
    wire [4:0] RS2_EX;
    wire RegWrite_EX;
    wire MemtoReg_EX;
    wire MemRead_EX;
    wire MemWrite_EX;
    wire [1:0] ALUop_EX;
    wire ALUSrc_EX;
    wire Branch_EX;
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_EX;
    wire [31:0] REG_DATA2_EX_FINAL;
    
    wire [2:0] FUNCT3_MEM;
    wire [4:0] RD_MEM;
    wire ZERO_MEM;
    
    // Control path wires
    wire [6:0] opcode;
    wire control_sel;
    wire MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc;
    wire [1:0] ALUop;
    
    // Forwarding wires
    wire [4:0] rs1;
    wire [4:0] rs2;
    
    // Hazard detection wires
    wire [4:0] rd;
    
    // WB
    wire [31:0] DATA_MEMORY_WB, ALU_OUT_WB, REG_DATA2_MEM;
    
    wire beq, bne, blt, bge, bltu, bgeu;
    
    assign beq = ZERO_MEM & (FUNCT3_MEM == 3'b000);
    assign bne = ~ZERO_MEM & (FUNCT3_MEM == 3'b001);
    assign blt = ~ZERO_MEM & (FUNCT3_MEM == 3'b100);
    assign bge = ZERO_MEM & (FUNCT3_MEM == 3'b101);
    assign bltu = ~ZERO_MEM & (FUNCT3_MEM == 3'b110);
    assign bgeu = ZERO_MEM & (FUNCT3_MEM == 3'b111);
    
    assign PCSrc = Branch_MEM & (beq|bne|blt|bge|bltu|bgeu);
    assign pipeline_stall = control_sel;
    

    // Modulul IF
    IF IF_MODULE(clk, reset,
                 PCSrc, PC_write,
                 PC_Branch,
                 
                 PC_IF, INSTRUCTION_IF);
                
    // PIPELINE IF/ID
    IF_ID_reg IF_ID_REGISTER(clk,reset,
                           IF_ID_write,
                           PC_IF, INSTRUCTION_IF,
                           
                           PC_ID, INSTRUCTION_ID);
  
    // Modulul ID
    ID ID_MODULE(clk,
                 PC_ID, INSTRUCTION_ID,
                 RegWrite_WB,
                 ALU_DATA_WB,
                 RD_WB,
                 
                 IMM_ID,
                 REG_DATA1_ID, REG_DATA2_ID,
                 FUNCT3_ID,
                 FUNCT7_ID,
                 OPCODE_ID,
                 RD_ID,
                 RS1_ID,
                 RS2_ID);
                 
    // PIPELINE ID/EX
    ID_EX_reg ID_EX_REGISTER(clk, reset, 1'b1,
                             RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch, ALUop,
                             PC_ID, REG_DATA1_ID, REG_DATA2_ID, IMM_ID,
                             FUNCT7_ID, FUNCT3_ID,
                             RS1_ID, RS2_ID, RD_ID,
                                 
                             RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX, ALUop_EX,
                             PC_EX, REG_DATA1_EX, REG_DATA2_EX, IMM_EX,
                             FUNCT7_EX, FUNCT3_EX,
                             RS1_EX, RS2_EX, RD_EX);
    
    // Modulul EX
    EX EX_MODULE(IMM_EX,
                 REG_DATA1_EX,
                 REG_DATA2_EX,
                 PC_EX,
                 FUNCT3_EX,
                 FUNCT7_EX,
                 RD_EX,
                 RS1_EX,
                 RS2_EX,
                 RegWrite_EX,
                 MemtoReg_EX,
                 MemRead_EX,
                 MemWrite_EX,
                 ALUop_EX,
                 ALUSrc_EX,
                 Branch_EX,
                 forwardA,forwardB,
                 ALU_DATA_WB,
                 ALU_OUT_MEM,
          
                 ZERO_EX,
                 ALU_OUT_EX,
                 PC_Branch,
                 REG_DATA2_EX_FINAL);
                 
    // PIPELINE EX/MEM
    EX_MEM_reg EX_MEM_REGISTER(clk, reset, 1'b1,
                               RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
                               PC_Branch, FUNCT3_EX,
                               ALU_OUT_EX, ZERO_EX,
                               REG_DATA2_EX_FINAL,
                               RS2_EX, RD_EX,
                                  
                               RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
                               PC_MEM, FUNCT3_MEM,
                               ALU_OUT_MEM, ZERO_MEM,
                               REG_DATA2_MEM,
                               RS2_MEM, RD_MEM);
                 
    // Modulul MEM
    data_memory MEM(clk,
                    MemRead_MEM,
                    MemWrite_MEM,
                    ALU_OUT_MEM,
                    REG_DATA2_MEM,
                    
                    DATA_MEMORY_MEM);
                    
    // PIPELINE MEM/WB
    MEM_WB_reg MEM_WB_REGISTER(clk, reset, 1'b1,
                               RegWrite_MEM, MemtoReg_MEM,
                               DATA_MEMORY_MEM,
                               ALU_OUT_MEM,
                               RD_MEM,
                                  
                               RegWrite_WB, MemtoReg_WB,
                               DATA_MEMORY_WB,
                               ALU_OUT_WB,
                               RD_WB);
                               
    // Stagiul WB
    mux2_1 WB(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);
                    
    // Control path
    control_path CPATH(OPCODE_ID,
                       control_sel,
                       
                       MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc,
                       ALUop);
                       
    // Forwarding
    forwarding FORWARD(RS1_EX,
                       RS2_EX,
                       RD_MEM,
                       RD_WB,
                       RegWrite_MEM,
                       RegWrite_WB,
                  
                       forwardA,forwardB);
                       
    // Hazard Detection
    hazard_detection HAZARD(RD_EX,
                            RS1_ID,
                            RS2_ID,
                            MemRead_EX,
                        
                            PC_write,
                            IF_ID_write,
                            control_sel);
    
endmodule
