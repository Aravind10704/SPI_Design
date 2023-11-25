`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2023 19:57:24
// Design Name: 
// Module Name: tb
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


module tb();
        reg wb_clk_in, wb_rst_in;
        wire wb_we_in, wb_stb_in, wb_cyc_in, miso;
        wire [4:0] wb_addr_in;
        wire [31:0] wb_data_in;
        wire [3:0] wb_sel_in;
        wire [31:0] wb_data_out;
        wire wb_ack_out, sclk_out, mosi;
        wire [31:0] ss_pad_o;
        
        parameter T = 20;
        
        wishbone_master MASTER(wb_clk_in,wb_rst_in,wb_ack_out,wb_data_out,wb_addr_in,
                               wb_cyc_in,wb_stb_in,wb_we_in,wb_data_in,wb_sel_in);
                               
        spi_top SPI_CORE(wb_clk_in,wb_rst_in,wb_stb_in,wb_cyc_in,miso,wb_we_in,wb_addr_in,wb_data_in,
                         wb_sel_in,sclk_out,mosi,wb_ack_out,wb_int_out,wb_data_out,ss_pad_o);
                         
        spi_slave SPI_SLAVE(sclk_out,mosi,ss_pad_o,miso);
        
        initial begin
        wb_clk_in = 1'b0;
        forever #(T/2) wb_clk_in = ~wb_clk_in;
        end
        
        task rst();
        begin
        wb_rst_in = 1'b1;
        #13
        wb_rst_in = 1'b0;
        end
        endtask
        
        //tx_neg = 1, rx_neg = 0, LSB = 1, char_len = 4
        /*initial begin
        rst;
        MASTER.initialize;
        MASTER.single_write(5'h10,32'h0000_3C04,4'b1111);
        MASTER.single_write(5'h14,32'h0000_0004,4'b1111);
        MASTER.single_write(5'h18,32'h0000_0001,4'b1111);
        MASTER.single_write(5'h00,32'h0000_2361,4'b1111);
        MASTER.single_write(5'h10,32'h0000_3d04,4'b1111);
        repeat(1000)
        @(negedge wb_clk_in);
        #1000 $finish;
        end*/
        
        //tx_neg = 0, rx_neg = 1, LSB = 1, char_len = 4
        initial begin
        rst;
        MASTER.initialize;
        MASTER.single_write(5'h10,32'h0000_3A04,4'b1111);
        MASTER.single_write(5'h14,32'h0000_0004,4'b1111);
        MASTER.single_write(5'h18,32'h0000_0001,4'b1111);
        MASTER.single_write(5'h00,32'h0000_2361,4'b1111);
        MASTER.single_write(5'h10,32'h0000_3B04,4'b1111);
        repeat(1000)
        @(negedge wb_clk_in);
        #1000 $finish;
        end
endmodule
