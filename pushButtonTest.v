`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 12:52:33 PM
// Design Name: 
// Module Name: pushButtonTest
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


module pushButtonTest(
   input buttonState, //0: BTNC, 1: BTNR, 2: BTNL, 3: BTNU, 4: BTND
   input clk, reset,
   output led
    );
    
    wire btn;
    
        clockDivider #(250000) c1  (.clk(clk), .rst(reset), .clk_out(new_clk2));
        Pushbutton_Detector BTNC( .X(buttonState), .clk(new_clk2) , .rst(reset), .Z(led)); 
        
   


endmodule
