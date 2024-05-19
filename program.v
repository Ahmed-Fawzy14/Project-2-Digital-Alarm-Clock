`timescale 1ns / 1ps
/*******************************************************************
*
* Module: programRun.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This module has the FSM and CU control signals
*
* Change history: 
* 16/05/24 - Created the module
* 17/05/24 - deleted redundant code blocks and fixed bugs
* 18/05/24 - fixed bugs
* 19/05/24 - Done


**********************************************************************/


module clockState(
   input clk,clk_out_200, reset, en, 
   input [21:0] in_count,//enable for seconds counter
   input load,
   input [1:0] en_Time, //1: Hr 0: Min
   output [6:0] segments,
   output [3:0] anodes,
   output [21:0] count,
   output dp  //MADE THIS NOT REG
//   output alarm,
   );
    
  wire [1:0] twoOut;  
  reg [3:0] muxOut;   
  wire [21:0] count;     
    
    
Clock clock(.clk(clk), .rst(reset), .en(en) , .in_count(in_count), .count(count),.load(load), .en_Time(en_Time));
  

counterModN #(2,4)twoCount (.clk(clk_out_200), .reset(reset), .en(1'b1), .count(twoOut));  

SevenSegCase seg(.en(twoOut), .num(muxOut), .segments(segments),.anode_active(anodes),.dp(dp), .en_clock(en), .clk_1Hz(clk));



   always @(*) begin  // choosing which part of the time (hours or minutes) to be displayed based on its anode position
  
  if(twoOut == 2'b00)
    muxOut = count[11:8];
  else if(twoOut == 2'b01)
    muxOut = count[15:12];
  else if(twoOut == 2'b10)
    muxOut = count[19:16];
  else if(twoOut == 2'b11)
    muxOut =  count[21:20];
   
      
      
end  
  
  
   
endmodule
