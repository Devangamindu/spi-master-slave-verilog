`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2026 15:06:28
// Design Name: 
// Module Name: SPI_SL
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


module SPI_SL(
input rst,mosi,sclk,cs,
output reg done,
output reg [7:0]data_out
    );
reg [7:0]shift_reg;
reg [2:0] bit_count;
always @(negedge sclk or posedge rst) begin
if(rst)begin
 shift_reg<=0;
 done<=0;
 bit_count<=0;
 data_out<=0;
end
 else if(!cs) begin
   done<=0;
     shift_reg <= {shift_reg[6:0], mosi};
if(bit_count == 7) begin
   data_out <= {shift_reg[6:0], mosi};
   done <= 1;
   bit_count <= 0;
end
else
   bit_count <= bit_count + 1;
end
end
endmodule
