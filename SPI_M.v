`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2026 11:29:32
// Design Name: 
// Module Name: SPI_M
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


module SPI_M(
input clk,rst,start,
input [7:0] data_in,
output reg cs,mosi,done,sclk
    );
reg [3:0] bit_count;
reg [7:0] shift_reg;
reg [1:0] ps,ns;
parameter IDLE=2'b00,
          SHIFT=2'b01,
          DONE=2'b10;
always @(posedge clk) begin
  if(rst) 
    ps<=IDLE;
  else
    ps<=ns;
end 
always @(*) begin
 ns=ps;
 case(ps)
  IDLE:ns=start?SHIFT:IDLE;
  SHIFT :ns=(bit_count==8)?DONE:SHIFT;
  DONE :ns=IDLE;
  default:ns=IDLE;
endcase
end
always @(posedge clk) begin
if(rst) begin
  shift_reg<=0;
  bit_count<=0;
  done<=0;mosi<=0;sclk<=0;
end
else begin
  if(ps==IDLE && start) begin
    shift_reg<=data_in;
    bit_count<=0;
  end
 if(ps==SHIFT) begin
   sclk<=~sclk;
  if(sclk==1'b0) begin
   mosi <= shift_reg[7];
   shift_reg <= shift_reg << 1;
    bit_count <= bit_count + 1;
end
end
 if(ps == DONE)begin
   done <= 1;
   sclk<=0;
 end
else
   done <= 0;
 end   
end
always @(*) begin
case(ps)
 IDLE:  cs = 1'b1;
 SHIFT: cs = 1'b0;
 DONE:  cs = 1'b0;   
 default: cs = 1'b1;
endcase
end
endmodule
