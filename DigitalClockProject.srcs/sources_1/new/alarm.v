`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2024 10:19:02 PM
// Design Name: 
// Module Name: alarm
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


module alarm(
input clk, rst, en, load,
//output alarm,
input [12:0]in_count, //current clolck for time NOT ALARM TIME
input [1:0] en_Time, //1: hr 0: min
output [12:0]count //current clolck for time NOT ALARM TIME
    );
    
 
    
    
   
    
    reg en_minsOnes;
    reg en_minsTens;
    reg en_hrsOnes;
    reg en_hrsTens;
    
    //n = Fin/2*Fout
//    assign count = in_count;

wire reset;
assign reset = ( count[21:20] == 2 &  count[19:16] == 3 &  count[15:12] == 5 & count[11:8] == 9);
   

    counterModN  #(4,10)minsOnesCount (clk,      ((rst|reset)),en_minsOnes, count[3:0], load, in_count[3:0]); //Min One
    counterModN  #(3,6)minsTensCount (clk,     ((rst|reset)), en_minsTens, count[6:4], load, in_count[6:4]); //Min Tens
    counterModN  #(4,10)hrsOnesCount (clk,      ((rst|reset)),en_hrsOnes, count[10:7], load, in_count[10:7]); //Hr module ClockAlarm
    counterModN  #(2,3)hrsTensCount (clk,      ((rst|reset)),en_hrsTens, count[12:11], load, in_count[12:11]); //Hr Tens

    //concatenate 1 bit to in 21:20,, if count to clock [19:16] if count of [19:16] + 1 == 10 :: if count[21:20] + == 3 so count [21:16] else if small counter is 9
    always@(count) begin
    if(en) begin
         if(en_Time == 2'b01) begin
                en_minsTens = 1'b1;
                en_hrsOnes = 1'b0;
                en_hrsTens = 1'b0;
                en_minsOnes  = 1'b1;

//                en = 1'b0;
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
//       count[3:0] = in_count[3:0];
//       count[7:4] = in_count[7:4];
//       count[11:8] = in_count[11:8];
//       count[15:12] = in_count[15:12];
//       count[19:16] = in_count[19:16];
//       count[21:20] = in_count[21:20];






endmodule
