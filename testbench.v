`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2020 20:12:02
// Design Name: 
// Module Name: testbench
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

module testbench;
 
    // Inputs
    reg clk;
    reg wr_en;
    reg [31:0] data_in;
    reg [4:0] addr_in_0;
    reg [4:0] addr_in_1;
    reg port_en_0;
    reg port_en_1;

    // Outputs
    wire [31:0] data_out_0;
    wire [31:0] data_out_1;
    reg [31:0] data_store[31:0];
    integer i;

    // Instantiate the Unit Under Test (UUT)
    dual_port_memory uut (
        .clk(clk), 
        .wr_en(wr_en), 
        .data_in(data_in), 
        .addr_in_0(addr_in_0), 
        .addr_in_1(addr_in_1), 
        .port_en_0(port_en_0), 
        .port_en_1(port_en_1), 
        .data_out_0(data_out_0), 
        .data_out_1(data_out_1)
    );
    
    always
        #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 1;
        addr_in_1 = 0;
        port_en_0 = 0;
        port_en_1 = 0;
        wr_en = 0;
        data_in = 0;
        addr_in_0 = 0;  
        #20;
        //Write all the locations of RAM
        port_en_0 = 1;  
        wr_en = 1;
      for(i=1; i <= 32; i = i + 1) begin
            data_in = i;
            addr_in_0 = i-1;
            #10;
        end
        port_en_0 = 0;  
        wr_en = 0;
        //Read from port 1, all the locations of RAM.
        port_en_1 = 1;  
        for(i=1; i <= 32; i = i + 1) begin
            addr_in_1 = i-1;
            data_store[addr_in_1] = data_out_1;
             data_store[addr_in_1] = data_store[addr_in_1] + 10;
            #10;
        end
        port_en_1 = 0;
         port_en_0 = 1;  
        wr_en = 1;
        for(i=1; i <= 32; i = i + 1) begin
            data_in = data_store[i-1];
            addr_in_0 = i-1;
            #10;
        end
        
         port_en_0 = 0;  
        wr_en = 0;
        port_en_1 = 1;
         for(i=1; i <= 32; i = i + 1) begin
            addr_in_1 = i-1;
            #10;
            end
        port_en_1 = 0;
    end

endmodule
