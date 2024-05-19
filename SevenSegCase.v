`timescale 1ns / 1ps
/*******************************************************************
*
* Module: SevenSegCase.v
* Project: DigitalClock
* Author: Ahmed Abdelkader, Tony Gerges, Ahmed Abdeen
* Description: This is the module that is used to display the clock and alarm time on the seven segment display
*
* Change history: 14/05/24 - Created the module (inspired from the lab experiments)

**********************************************************************/



module SevenSegCase( input [1:0]en,
                     input clk_1Hz,
                     input en_clock,
                     input [3:0] num,
                     output reg [6:0] segments,
                     output reg [3:0] anode_active,
                     output reg dp
                     );
                     
                     
                     
                     
       always @(*) begin
       
      
      

       case(en)
       0:begin
            anode_active =4'b1110;
            dp = 1;
       end
       1:begin
            anode_active=4'b1101;
            dp = 1;
       end
       2:begin
            anode_active=4'b1011;
            dp = en_clock ? clk_1Hz : 1;
        end
       3:begin
            anode_active=4'b0111;
            dp = 1;
       end
       endcase
       
        case(num)
              0: segments = 7'b0000001;
              1: segments = 7'b1001111;
              2: segments = 7'b0010010;
              3: segments = 7'b0000110;
              4: segments = 7'b1001100;
              5: segments = 7'b0100100;
              6: segments = 7'b0100000;
              7: segments = 7'b0001111;
              8: segments = 7'b0000000;
              9: segments = 7'b0000100;
            
            
           default: segments = 7'b1111111;
            
       endcase
       end

    


    
                     
                     
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/02/2024 04:11:44 PM
// Design Name:
// Module Name: SevenSegDecWithEn
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


//module SevenSegDecWithEn(
//input [1:0] en,
//input [3:0] in,
//output reg [6:0] segments,
//output reg [3:0] anode_active);
//always @ (in,en) begin
//case(en)
//0: anode_active= 4'b0111;
//1: anode_active = 4'b1011;
//2: anode_active = 4'b1101;
//3: anode_active = 4'b1110;
//endcase

// case(in)
//  0: segments = 7'b0000001;
//  1: segments = 7'b1001111;
//  2: segments = 7'b0010010;
//  3: segments = 7'b0000110;
//  4: segments = 7'b1001100;
//  5: segments = 7'b0100100;
//  6: segments = 7'b0100000;
//  7: segments = 7'b0001111;
//  8: segments = 7'b0000000;
//  9: segments = 7'b0000100;
////  10: segments =7'b0001000;
////  11: segments =7'b1100000;
////  12: segments =7'b0110001;
////  13: segments =7'b1000010;
////  14: segments =7'b0110000;
////  15: segments =7'b0111000;
 
 
//  endcase

//end
//endmodule
