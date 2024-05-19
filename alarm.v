`timescale 1ns / 1ps
/*******************************************************************
*
* Module: Clock.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This is the module that controls the alarm 
*
* Change history: 14/05/24 - Added initial counters
* 19/05/24 - Added the entire module with debugging. Heavly inspired by Clock module.

**********************************************************************/


module alarm(
input clk,clk_out_200, rst, load, en,
input [1:0] en_Time, //1: Hr 0: Min
input [13:0]in_count, //current clolck for time NOT ALARM TIME
output [13:0]count, //current clolck for time NOT ALARM TIME
output [6:0] segments,
output [3:0] anodes
    );
    
 
  wire [1:0] twoOut;  
  reg [3:0] muxOut;   
    
   
    
    reg en_minsOnes;
    reg en_minsTens;
    reg en_hrsOnes;
    reg en_hrsTens;
    
    //n = Fin/2*Fout
//    assign count = in_count;

//wire reset;
//assign reset = ( count[21:20] == 2 &  count[19:16] == 3 &  count[15:12] == 5 & count[11:8] == 9);
   

counterModN  #(4,10)minsOnesCount (clk_out_200,      (rst),en_minsOnes, count[3:0], load, in_count[3:0]); //Min module alarm
counterModN  #(3,6)minsTensCount (clk_out_200,     (rst), en_minsTens, count[7:4], load, in_count[7:4]); //Min Tens
counterModN  #(4,10)hrsOnesCount (clk_out_200,      (rst),en_hrsOnes, count[11:8], load, in_count[11:8]); //Hr module ClockAlarm
counterModN  #(2,3)hrsTensCount (clk_out_200,      (rst),en_hrsTens, count[13:12], load, in_count[13:12]); //Hr Tens


counterModN #(2,4)twoCount (.clk(clk_out_200), .reset(reset), .en(1'b1), .count(twoOut));  

SevenSegCase seg(.en(twoOut), .num(muxOut), .segments(segments),.anode_active(anodes),.dp(dp), .en_clock(en), .clk_1Hz(clk));



  always @(*) begin
  
  if(twoOut == 2'b00)
    muxOut = count[3:0];
  else if(twoOut == 2'b01)
    muxOut = count[7:4];
  else if(twoOut == 2'b10)
    muxOut = count[11:8];
  else if(twoOut == 2'b11)
    muxOut =  count[13:12];
   
      
      
end


    always@(count) begin
    if(en) begin
         if(en_Time == 2'b01) begin
                en_minsTens = 1'b1;
                en_hrsOnes = 1'b0;
                en_hrsTens = 1'b0;
                en_minsOnes  = 1'b1;

            end
 
        else if(en_Time == 2'b10) begin
            en_hrsOnes  = 1'b1;
            en_hrsTens = 1'b1;
            en_minsOnes  = 1'b0;
            en_minsTens = 1'b0;
//            en = 1'b0;
        end
        else begin
            en_hrsOnes  = 1'b0;
            en_hrsTens = 1'b0;
            en_minsOnes  = 1'b0;
            en_minsTens = 1'b0;
        end

       end
        
    
    end






endmodule
