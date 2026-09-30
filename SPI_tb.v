`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2026 15:49:19
// Design Name: 
// Module Name: SPI_tb
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


module SPI_tb;
reg clk,rst,start;
reg [7:0]data_in;
wire done;
wire [7:0] data_out;
SPI uut(.clk(clk),.rst(rst),.start(start),.data_in(data_in),.done(done),.data_out(data_out));
initial begin
  repeat(1000)
    begin
       clk=1'b0;#5;
       clk=1'b1;#5;
    end
end
initial begin
rst=1;
start=0;
data_in=0;
#15;
rst=0;
data_in = 8'b10110010;
start = 1;
#10;
start = 0;
#500;
$finish;
end
initial begin
  $monitor(
   "t=%0t mosi=%b sclk=%b cs=%b M_cnt=%d S_cnt=%d shift_reg=%h data_out=%h done=%b",
    $time,uut.mosi,uut.sclk,uut.cs,uut.spi1.bit_count,uut.spi2.bit_count,uut.spi2.shift_reg,data_out,done);
end
endmodule
