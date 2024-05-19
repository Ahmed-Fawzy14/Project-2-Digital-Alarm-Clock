`timescale 1ns / 1ps
/*******************************************************************
*
* Module: programRun.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This module is used in the push button detector to detect if there is a rising edge in the signal
*
* Change history: 
* 16/05/24 - Created the module


**********************************************************************/


module Rising_edge_detector(input clk, rst, w, output z);

reg [1:0] state, nextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10;

always @ (w or state)
case (state)
A: if (w==0) nextState = A;
 else nextState = B;
B: if (w==1) nextState = C;
 else nextState = A;
C: if (w==0) nextState = A;
 else nextState = C;
default: nextState = A;

endcase

always @ (posedge clk or posedge rst) begin
if(rst) state <= A;
else state <= nextState;
end 
assign z = (state == B);
endmodule


