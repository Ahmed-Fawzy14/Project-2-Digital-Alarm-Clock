`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2024 12:35:24 PM
// Design Name: 
// Module Name: ClockAlarm
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


module Clock(
input clk, rst, en, load,
//output alarm,
input [21:0]in_count, //current clolck for time NOT ALARM TIME
input [1:0] en_Time, //1: hr 0: min
output [21:0]count //current clolck for time NOT ALARM TIME
    );
    
 
    
    
   
    
    reg en_secondsTens;
    reg en_minsOnes;
    reg en_minsTens;
    reg en_hrsOnes;
    reg en_hrsTens;
    
    //n = Fin/2*Fout
//    assign count = in_count;

wire reset;
assign reset = ( count[21:20] == 2 &  count[19:16] == 3 &  count[15:12] == 5 & count[11:8] == 9 & count[7:4] == 5 & count[3:0] == 9);
   
    counterModN  #(4,10)secondsOnesCount (clk, rst|reset,en, count[3:0], 1'b0, in_count[3:0]); //Second One
    counterModN  #(3,6)secondsTensCount (clk,     (rst|reset),en_secondsTens, count[7:4], 1'b0, in_count[7:4]); //Second Tens
    counterModN  #(4,10)minsOnesCount (clk,      ((rst|reset)),en_minsOnes, count[11:8], load, in_count[11:8]); //Min One
    counterModN  #(3,6)minsTensCount (clk,     ((rst|reset)), en_minsTens, count[15:12], load, in_count[15:12]); //Min Tens
    counterModN  #(4,10)hrsOnesCount (clk,      ((rst|reset)),en_hrsOnes, count[19:16], load, in_count[19:16]); //Hr module ClockAlarm
    counterModN  #(2,3)hrsTensCount (clk,      ((rst|reset)),en_hrsTens, count[21:20], load, in_count[21:20]); //Hr Tens

    //concatenate 1 bit to in 21:20,, if count to clock [19:16] if count of [19:16] + 1 == 10 :: if count[21:20] + == 3 so count [21:16] else if small counter is 9
    always@(count) begin
    if(en) begin
        if(count[3:0] == 9 & en) begin
            en_secondsTens = 1'b1;
        end
        else begin
            en_secondsTens = 1'b0;
        end
        if(count[7:4] == 5 && en_secondsTens && en) begin
            en_minsOnes = 1'b1;
        end
        else begin
            en_minsOnes = 1'b0;
        end
        if(count[11:8] == 9 && en_minsOnes && en_secondsTens & en) begin
            en_minsTens = 1'b1;
        end
        else begin
            en_minsTens = 1'b0;
        end
        if(count[15:12] == 5 && en_minsOnes && en_secondsTens && en_minsTens  && en) begin
            en_hrsOnes = 1'b1;
        end
        else begin
            en_hrsOnes = 1'b0;
        end
        if(count[19:16] == 9 && en_minsOnes && en_secondsTens && en_minsTens && en_hrsOnes && en) begin
            en_hrsTens = 1'b1;
        end
        else begin
            en_hrsTens = 1'b0;
        end
      end
       else begin
         if(en_Time == 2'b01) begin
                en_minsTens = 1'b1;
                en_hrsOnes = 1'b0;
                en_hrsTens = 1'b0;
                en_minsOnes  = 1'b1;
                en_secondsTens = 1'b0;

//                en = 1'b0;
            end
 
        else if(en_Time == 2'b10) begin
            en_hrsOnes  = 1'b1;
            en_hrsTens = 1'b1;
            en_minsOnes  = 1'b0;
            en_minsTens = 1'b0;
            en_secondsTens = 1'b0;
//            en = 1'b0;
        end
        else begin
            en_hrsOnes  = 1'b0;
            en_hrsTens = 1'b0;
            en_minsOnes  = 1'b0;
            en_minsTens = 1'b0;
            en_secondsTens = 1'b0;
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
