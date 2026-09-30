`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2026 15:38:34
// Design Name: 
// Module Name: SPI
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


module SPI(
input clk,rst,start,
input [7:0]data_in,
output done,
output [7:0] data_out
    );
wire sclk,cs,mosi,master_done,slave_done;
assign done = slave_done;
SPI_M spi1(.clk(clk),.rst(rst),.start(start),.data_in(data_in),
.mosi(mosi),.cs(cs),.sclk(sclk),.done(master_done));
SPI_SL spi2(.sclk(sclk),.rst(rst),.mosi(mosi),.cs(cs)
,.done(slave_done),.data_out(data_out));
endmodule
