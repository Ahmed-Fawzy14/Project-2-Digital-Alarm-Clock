`timescale 1ns / 1ps
/*******************************************************************
*
* Module: synchronizer.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This module synchronizes the signal coming from the debouncer with the clock
*
* Change history: 
* 16/05/24 Created this module for the pushButtons used in the project for adjusting


**********************************************************************/

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
