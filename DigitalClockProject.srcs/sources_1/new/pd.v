`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 06:46:47 PM
// Design Name: 
// Module Name: Pushbutton Detector
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


module Pushbutton_Detector(input X,input clk , input rst, output Z);
wire debounce;
wire signal1;
debouncer b( .clk(clk), .rst(rst), .in(X),  .out(debounce));
synchronizer q2(.signal(debounce), .clk(clk), .rst(rst),.sync_signal(signal1));
Rising_edge_detector re(  .clk(clk), .rst(rst),.w(signal1), .z(Z));



endmodule
