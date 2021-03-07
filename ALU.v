`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:06:27 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output zero,
           output reg [31:0] out);
           
     reg signed [31:0] signed_ina, signed_inb;
     
     always@(*) begin
        case(ALUop)
            // AND
            4'b0000: out <= ina & inb;
            
            // OR
            4'b0001: out <= ina | inb;
            
            // add
            4'b0010: out <= ina + inb;
            
            // substract
            4'b0110: out <= ina - inb;
            
            // XOR
            4'b0011: out <= ina ^ inb;
            
            // logic shift right
            4'b0101: out <= ina >> inb;
            
            // logic shift left
            4'b0100: out <= ina << inb;
            
            // arithmetic shift right
            4'b1001: begin 
                signed_ina <= ina;
                out <= signed_ina >>> inb;
            end
            
            // SLT, blt, bge
            4'b1000: begin
                signed_ina <= ina;
                signed_inb <= inb;
                
                out <= signed_ina < signed_inb ? 1 : 0;
            end
            
            // SLTU, bltu, bgeu
            4'b0111: out <= ina < inb ? 1 : 0;
        endcase
     end
     
     assign zero = out == 0 ? 1 : 0;
           
endmodule
