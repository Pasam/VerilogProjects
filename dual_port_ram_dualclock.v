`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2020 18:58:55
// Design Name: 
// Module Name: dual_port_ram_dualclock
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


module dual_port_ram_dualclock(
        input read_clk,input write_clk,input[31:0] data_in_0,input we,input [4:0] addr_in_0,
        input [4:0] addr_out_0 , output [31:0] data_out_0,
        input[31:0] data_in_1,input we_1,input [4:0] addr_in_1,
        input [4:0] addr_out_1 , output [31:0] data_out_1,
        input port_en_0,input port_en_1 
    );
     reg [31:0] data_out_0;
     reg[31:0] data_out_1;
     reg[31:0] dual_port_mem[31:0];
     
     always @ (posedge read_clk) begin
     data_out_0 <= (port_en_0 == 1)? dual_port_mem[addr_out_0] : 'dZ;
     data_out_1 <= (port_en_1 == 1)? dual_port_mem[addr_out_1] : 'dZ;
     end
     
     always @ (posedge write_clk) begin
     if(port_en_0 == 1 && we == 1)
     dual_port_mem[addr_in_0] <= data_in_0;
     
     if(port_en_1 == 1 && we_1 == 1)
     dual_port_mem[addr_in_1] <= data_in_1;
     end
endmodule
