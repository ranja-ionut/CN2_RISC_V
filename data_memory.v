`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 04:06:27 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
    
    reg [31:0] dataMemory [0:1023];
    integer i;
    
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            dataMemory[i] <= 0;
        end
    end
           
    always@(posedge clk, mem_read) begin
        if (mem_read == 1) begin
            read_data <= dataMemory[address >> 2];
        end else begin 
            if (mem_write == 1) begin
                dataMemory[address >> 2] <= write_data;
                read_data <= write_data;
            end
        end
    end
                   
endmodule
