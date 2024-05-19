`timescale 1ns / 1ps
/*******************************************************************
*
* Module: pushButtonTest.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This module tests if the push Button detector works
*
* Change history: 
* 16/05/24 - Added FSM from our design
* 17/05/24 - Added the 
* 18/05/24 - Debugging
* 19/05/24 - Done


**********************************************************************/


module pushButtonTest(
   input buttonState, //0: BTNC, 1: BTNR, 2: BTNL, 3: BTNU, 4: BTND
   input clk, reset,
   output led
    );
    
    wire btn;
    
        clockDivider #(250000) c1  (.clk(clk), .rst(reset), .clk_out(new_clk2));
        Pushbutton_Detector BTNC( .X(buttonState), .clk(new_clk2) , .rst(reset), .Z(led)); 
        
   


endmodule
