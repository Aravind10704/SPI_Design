`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2023 12:21:50
// Design Name: 
// Module Name: spi_clkgen_tb
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


module spi_clkgen_tb();
        reg wb_clk, wb_rst, tip, go, last_clk;
        reg [15:0] divider;
        wire sclk_out, cpol_0, cpol_1;
        //DUT Initialization
        spi_clkgen dut(wb_clk, wb_rst, tip, go, last_clk, divider, sclk_out, cpol_0, cpol_1);
        //Clock Initialization
        initial wb_clk = 0;
        always #5 wb_clk = !wb_clk;
        //Input ports Initiliazation
        initial begin
        wb_rst = 0;tip = 0;go = 0;divider = 16'd4;last_clk = 0;
        #10 wb_rst = 1;#10 tip = 1;go = 1; wb_rst = 0;
        #200 $finish();
        end
endmodule
