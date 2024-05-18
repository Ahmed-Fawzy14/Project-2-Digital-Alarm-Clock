`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 03:23:25 PM
// Design Name: 
// Module Name: synchronizer
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


module synchronizer(input  clk,rst,signal,
  output reg  sync_signal
);
reg Meta;
always@(posedge clk,posedge rst)begin
if(rst==1'b1)begin
  Meta<=0;
  sync_signal<=0;
  end
  else begin 
  Meta<=signal;
  sync_signal<=Meta;
  end
  end
endmodule