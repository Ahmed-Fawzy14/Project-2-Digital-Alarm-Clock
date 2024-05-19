`timescale 1ns / 1ps
/*******************************************************************
*
* Module: Pushbutton_Detector.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This is the module for handling push button presses
*
* Change history: 14/05/24 - Added initial counters
* 18/05/24 - Added the modules. Source: Digital Design I
* 19/05/24 - Done

**********************************************************************/


module Pushbutton_Detector(input X,input clk , input rst, output Z);
wire debounce;
wire signal1;
debouncer b( .clk(clk), .rst(rst), .in(X),  .out(debounce));
synchronizer q2(.signal(debounce), .clk(clk), .rst(rst),.sync_signal(signal1));
Rising_edge_detector re(  .clk(clk), .rst(rst),.w(signal1), .z(Z));



endmodule
