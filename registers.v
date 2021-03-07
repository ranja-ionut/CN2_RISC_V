`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 05:52:24 PM
// Design Name: 
// Module Name: registers
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


module registers(
    input clk, reg_write,
    input [4:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    output reg [31:0] read_data1, read_data2 
    );
    
    reg [31:0] regs [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1)
            begin
                regs[i] <= i;
            end
    end
   
    always@(read_reg1)
    begin
        read_data1 <= regs[read_reg1];
    end
    
    always@(read_reg2)
    begin
        read_data2 <= regs[read_reg2];
    end
    
    always@(posedge clk)
    begin
        if (reg_write)
            regs[write_reg] <= write_data;
    end
    
endmodule
