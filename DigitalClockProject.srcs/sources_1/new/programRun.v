`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 02:56:17 PM
// Design Name: 
// Module Name: programRun
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
//clock into into divider is reg unknown, input in the cases is not the push button input,clock in reset output chouldbe the same as the clock divided one/

module programRun(
   input clk, reset, user_en, /*turn off clock*/ //en, //enable for seconds counter
   input [4:0] buttonState, //0: BTNC, 1: BTNR, 2: BTNL, 3: BTNU, 4: BTND
   output [6:0] segments, 
   output [3:0] anodes,
   output dp,
   output reg alarmSound,
   output  reg[4:0] LEDstate
    
    );
    //THIS SHOULD COME FROM ALARM MODULE
    reg[13:0] alarmReg;
    reg clk_to_clock;
    reg en_to_clock;
    wire new_clk, new_clk2;
    reg [1:0] en_Time;
    reg load;
    reg BL;
    
    reg [2:0] state, nextState;
    parameter [2:0]  Clock = 3'b000, Alarm = 3'b001, Adjust_0 = 3'b010, Adjust_1 = 3'b011, Adjust_2 = 3'b100, Adjust_3 = 3'b101;
    
//    assign hours[6:0] = count_from_clock[21:16];
    
    
     wire [21:0] count_from_clock;    
     reg [21:0] count_to_clock;   
     reg [5:0] temp;  
     wire dp_to_clock;    
     wire [4:0] BTN;
 //    reg [1:0] en_Time; //1: Hr 0: Min


    //assign count_to_clock_wire = count_to_clock; //**********************
    Pushbutton_Detector BTNC( .X(buttonState[0]), .clk(new_clk2) , .rst(rst), .Z(BTN[0])); 
    Pushbutton_Detector BTNR( .X(buttonState[1]), .clk(new_clk2) , .rst(rst), .Z(BTN[1])); 
    Pushbutton_Detector BTNL( .X(buttonState[2]), .clk(new_clk2) , .rst(rst), .Z(BTN[2])); 
    Pushbutton_Detector BTNU( .X(buttonState[3]), .clk(new_clk2) , .rst(rst), .Z(BTN[3])); 
    Pushbutton_Detector BTND( .X(buttonState[4]), .clk(new_clk2) , .rst(rst), .Z(BTN[4]));
   
   //ENABLE FOR CLOCKS
   reg en_clock;
   
   
    clockState clock(.clk(clk_to_clock),.clk_out_200(new_clk2), .reset(reset), .segments(segments), .anodes(anodes), .dp(dp), .count(count_from_clock), .en(en_clock), .in_count(count_to_clock), .load(load), .en_Time(en_Time));
    clockDivider #(250000) c1  (.clk(clk), .rst(reset), .clk_out(new_clk2));
    clockDivider #(50000000) c2 (.clk(clk), .rst(reset), .clk_out(new_clk));

       //////////////////////
 
 

    //////////////////////////////
    //In programRun:
    //Create ONE Clock object that we will change 
    //create a clockDivder that gives 200hz
    //create a clockDivder that gives 1hz
    //when going to adjust: send 200hz, disbale, incremeant and send it as in_count
    //When we are returing to clock from adjust: enable clocks, send 1hz
    
    always@(BTN or state) begin  

        case(state)

     
        Clock: 
        begin 
            load = 0;
            clk_to_clock = new_clk;
            en_clock = 0;
            en_Time = 2'b00;
            LEDstate = 5'b00000;
            nextState = Clock;
            
            if(count_from_clock[21:8] == count_from_clock[21:8]) 
                 begin//If currentTime and alarmTime are the same AND any button is pressed or not pressed expect BTNC     
                    nextState = Alarm;
                    alarmSound = new_clk;
                    LEDstate={4'b0000, new_clk};
                   en_Time = 2'b00;
                    en_clock=1;
                end
            if(BTN == 5'b00001) begin
            
                    nextState = Adjust_0;
                    alarmSound=0;
                    LEDstate= 5'b00001;
                    en_clock  = 0;
                    clk_to_clock = new_clk2;
                   en_Time = 2'b00;

                   
            end  
            else begin      
                  nextState = Clock;
                  alarmSound=0;
                  LEDstate =5'b00000;
                  en_clock = 1;
                  clk_to_clock = new_clk;
                  en_Time = 2'b00;
            end
        end
        
        Alarm: 
         begin 

             if((BTN != 5'b00000))  
             begin
                 nextState = Clock;
                 alarmSound=0;
                 LEDstate =5'b00000;
                 load = 0;
                 en_Time = 2'b00;
                 en_clock = 1;

            end
            else begin
                nextState  = Alarm;
                alarmSound = 1;
                LEDstate = {4'b0000, new_clk};
                load = 0;
                en_Time = 2'b00;
                en_clock = 1;
            
            end
            
        end

        Adjust_0:
        begin

            if(BTN == 5'b00001)
            begin
                nextState = Clock;
                en_clock = 1;
                alarmSound=0;
                LEDstate = 5'b00000;
                load = 0;
                clk_to_clock = new_clk;
                en_Time = 2'b00;
                
            end
            
            else if (BTN == 5'b00100)//BTNL
            begin
                nextState = Adjust_1;
                alarmSound=0;
                LEDstate =5'b00101;
                load = 0;
                en_clock = 0;
                clk_to_clock = new_clk2;
                en_Time = 2'b00;
                
            end
            else if (BTN == 5'b00010)//BTNR
            begin
                nextState = Adjust_3;
                en_clock = 0;
                alarmSound=0;
                load = 0;
                LEDstate =5'b10001;
                clk_to_clock = new_clk2;
                en_Time = 2'b00;
                en_clock = 0;

            end
            else if(BTN == 5'b01000) begin //adjust time hour
  
            if (count_from_clock[19:16] == 4'd9)
            begin
                if (count_from_clock [21:20] == 2'd1)
                begin    
                
                    count_to_clock[21:20] = 2'd2;
                    count_to_clock[19:16] = 4'd0;
                end
                if (count_from_clock[21:20] == 2'd0)
                begin   
                    count_to_clock [21:20] =2'd1;
                    count_to_clock [19:16] =4'd0;
                 end
            end
            else if (count_from_clock [19:16] == 3 & count_from_clock [21:20] == 2)
            begin

                count_to_clock [21:20] =0;
                count_to_clock [19:16] =0;

            end
            
            else
            begin
            count_to_clock [19:16] =  count_from_clock [19:16] + 4'd1;
            count_to_clock [21:20] = count_from_clock[21:20];
            
            end
            
            
            
               alarmSound=0;
                load = 1;
                LEDstate = 5'b00011;
                en_Time = 2'b10;
                clk_to_clock = new_clk2;
                en_clock = 0;
              
            end
             else if(BTN == 5'b10000) begin //adjust time hour
                
            if (count_from_clock[19:16] == 4'd0)
            begin
                if (count_from_clock [21:20] == 2'd2)
                begin    
                
                    count_to_clock[21:20] = 2'd1;
                    count_to_clock[19:16] = 4'd9;
                end
                if (count_from_clock[21:20] == 2'd1)
                begin   
                    count_to_clock [21:20] =2'd0;
                    count_to_clock [19:16] =4'd9;
                 end
            end
            else if (count_from_clock [19:16] == 0 & count_from_clock [21:20] == 0)
            begin

                count_to_clock [21:20] =2'd2;
                count_to_clock [19:16] =4'd3;

            end
            else
            begin
                count_to_clock [19:16] =  count_from_clock [19:16] - 4'd1;
                count_to_clock [21:20] = count_from_clock[21:20];
                
            end
            
            
            
                alarmSound=0;
                load = 1;
                LEDstate = 5'b00011;
                en_Time = 2'b10;
                clk_to_clock = new_clk2;
                en_clock = 0;
               end
            else 
            begin
               nextState = Adjust_0;
               alarmSound=0;
               LEDstate =5'b00011;
               en_clock = 0;
               load = 0;
               clk_to_clock = new_clk2;
               en_Time = 2'b00;
 
                

            end
         end
         Adjust_1:

         begin

            if(BTN == 5'b00001)
            begin
                nextState = Clock;
                alarmSound=0;
                load = 0;
                LEDstate =5'b00000;
                en_clock = 1;
                en_Time = 2'b00;

                clk_to_clock = new_clk;
            end
            else if (BTN == 5'b00100)
            begin
            nextState = Adjust_2;
            alarmSound=0;
            LEDstate =5'b01001;
            en_clock = 0;
             clk_to_clock = new_clk2;
            en_Time = 2'b00;
            load = 0;


            end
            else if (BTN == 5'b00010)
            begin
            nextState = Adjust_0;
            en_clock = 0;
            clk_to_clock = new_clk2;
            en_Time = 2'b00;
            load = 0;
            alarmSound=0;
            LEDstate =5'b00011;
            end
            
            
            else if(BTN == 5'b01000) begin //adjust time min
                 if (count_from_clock[11:8] == 4'd9)
            begin
                    if (count_from_clock [15:12] == 4'd5)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd0;
                    end
                    else if (count_from_clock [15:12] == 4'd4)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd5;
                    end
                     if (count_from_clock [15:12] == 4'd3)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd4;
                    end
                     if (count_from_clock [15:12] == 4'd2)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd3;
                    end
                     if (count_from_clock [15:12] == 4'd1)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd2;
                    end
                     if (count_from_clock [15:12] == 4'd0)
                    begin    
                        count_to_clock[11:8] = 4'd0;
                        count_to_clock[15:12] = 4'd1;
                    end
                
             end
            else
            begin
            count_to_clock [11:8] =  count_from_clock [11:8] + 4'd1;
            count_to_clock [15:12] = count_from_clock[15:12];
            
           end 
            
            
            
                load = 1;
                LEDstate = 5'b00101;
                en_Time = 2'b01;
                clk_to_clock = new_clk2;
                en_clock = 0;
                alarmSound=0;
              
            end  
            else if(BTN == 5'b10000) begin //adjust time min
                                 if (count_from_clock[11:8] == 4'd0)
            begin
                    if (count_from_clock [15:12] == 4'd5)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd4;
                    end
                    else if (count_from_clock [15:12] == 4'd4)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd3;
                    end
                     if (count_from_clock [15:12] == 4'd3)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd2;
                    end
                     if (count_from_clock [15:12] == 4'd2)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd1;
                    end
                     if (count_from_clock [15:12] == 4'd1)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd0;
                    end
                     if (count_from_clock [15:12] == 4'd0)
                    begin    
                        count_to_clock[11:8] = 4'd9;
                        count_to_clock[15:12] = 4'd5;
                    end
                
             end
            else
            begin
            count_to_clock [11:8] =  count_from_clock [11:8] - 4'd1;
            count_to_clock [15:12] = count_from_clock[15:12];
            
           end 
            
            
            
                load = 1;
                LEDstate = 5'b00101;
                en_Time = 2'b01;
                clk_to_clock = new_clk2;
                en_clock = 0;
               alarmSound=0;


            end
            else 
            begin
            nextState = Adjust_1;
            en_clock = 0;
            alarmSound=0;
            load = 0;
            LEDstate = 5'b00101;
            clk_to_clock = new_clk2;
            en_Time = 2'b00;
 
            
            end
         end  
         
//            Adjust_2:
//         begin

//            if(BTN == 5'b00001)
//            begin
//            nextState = Clock;
//            load = 0;
//            en_clock = 1;
//            alarmSound=0;
//            LEDstate = 5'b11111;
//            clk_to_clock = new_clk;
//            en_Time = 2'b00;


//            end
//            else if (BTN == 5'b00100)
//            begin
//            nextState = Adjust_3;
//            en_clock = 0;
////            alarmSound=0;
//            LEDstate = 5'b10001;
//            clk_to_clock = new_clk2;
//                       en_Time = 2'b00;


//            end
//            else if (BTN == 5'b00010)
//            begin
//            nextState = Adjust_1;
//            en_clock = 0;
////            alarmSound=0;
//            LEDstate = 5'b00101;
//            clk_to_clock = new_clk2;
//                       en_Time = 2'b00;


//            end
////            else if(BTN_save == 5'b01000) begin //adjust alarm hour
////            alarmReg[13:7] = alarmReg[13:7] + 1'b1;
////            end  
////            else if(BTN_save == 5'b10000) begin //adjust alarm hour
////            alarmReg[13:7] = alarmReg[13:7] - 1'b1;
////            end
//            else 
           
//            begin
//            nextState = Adjust_2;
//            en_clock = 0;
////            alarmSound=0;
//            LEDstate = 5'b01001;
//            clk_to_clock = new_clk2;
//           en_Time = 2'b00;



//            end
//         end
//             Adjust_3:
//            begin
//                       load = 0;


//            if(BTN == 5'b00001)
//            begin
//                nextState = Clock;
//                load = 1;
//                en_clock = 1;
//    //            alarmSound=0;
//                clk_to_clock = new_clk;
//                LEDstate = 5'b11111;

//            end
//            else if (BTN == 5'b00100)
//            begin
//                nextState = Adjust_0;
//    //            alarmSound=0;
//                LEDstate = 5'b00001;
//                en_clock = 0;
//               clk_to_clock = new_clk2;
//                          en_Time = 2'b00;


//            end
//            else if (BTN == 5'b00010)
//            begin
//                nextState = Adjust_2;
//    //            alarmSound=0;
//                LEDstate = 5'b01001;
//                en_clock = 0;
//                clk_to_clock = new_clk2;
//                           en_Time = 2'b00;




//            end
////            else if(BTN_save == 5'b01000) begin //adjust alarm hour
////            alarmReg[6:0] = alarmReg[6:0] + 1'b1;
////            end  
////            else if(BTN_save == 5'b10000) begin //adjust alarm hour
////            alarmReg[6:0] = alarmReg[6:0] - 1'b1;
////            end
//            else 
//                begin
//                    nextState = Adjust_3;
//        //            alarmSound=0;
//                    LEDstate = 5'b10001;
//                    en_clock = 0;
//                    clk_to_clock = new_clk2;
//                    en_Time = 2'b00;

    
//                end
//            end
                
        default: nextState = Clock;
        endcase
    
    
    end
    always@(posedge new_clk2 or posedge reset)
        begin
        if(reset )begin
                state <=   Clock;                     
          end
             else 
          begin
             state <= nextState;
         end
     end
     

    
endmodule


