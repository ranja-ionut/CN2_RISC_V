`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:06:27 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);

    always@(*) begin
    
        casex({ALUop, funct7, funct3})
            //ld, sd
            13'b00xxxxxxxxxx: ALUinput <= 4'b0010;
            
            //add
            13'b100000000000: ALUinput <= 4'b0010;
            
            //sub
            13'b100100000000: ALUinput <= 4'b0110;
            
            //and
            13'b100000000111: ALUinput <= 4'b0000;
            
            //or
            13'b100000000110: ALUinput <= 4'b0001;
            
            //xor
            13'b100000000100: ALUinput <= 4'b0011;
            
            //srl, srli
            13'b100000000101: ALUinput <= 4'b0101;
            
            //sll, slli
            13'b100000000001: ALUinput <= 4'b0100;
            
            //sra, srai
            13'b100100000101: ALUinput <= 4'b1001;
            
            //sltu
            13'b100000000011: ALUinput <= 4'b0111;
            
            //slt
            13'b100000000010: ALUinput <= 4'b1000;
            
            //beq, bne
            13'b01xxxxxxx00x: ALUinput <= 4'b0110;
            
            //blt, bge
            13'b01xxxxxxx10x: ALUinput <= 4'b1000;
            
            //bltu, bgeu
            13'b01xxxxxxx11x: ALUinput <= 4'b0111;
        
        endcase
    
    end

endmodule
