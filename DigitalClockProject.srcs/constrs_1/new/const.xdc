## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


## Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {reset}]
set_property PACKAGE_PIN V16 [get_ports {user_en}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {user_en}]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
##7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {segments[6]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {segments[5]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {segments[4]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {segments[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {segments[2]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {segments[1]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {segments[0]}]

set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports  dp]

set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {anodes[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {anodes[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {anodes[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {anodes[3]}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports {buttonState[0]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {buttonState[0]}]
set_property PACKAGE_PIN T18 [get_ports {buttonState[3]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {buttonState[3]}]
set_property PACKAGE_PIN W19 [get_ports {buttonState[2]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {buttonState[2]}]
set_property PACKAGE_PIN T17 [get_ports {buttonState[1]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {buttonState[1]}]
set_property PACKAGE_PIN U17 [get_ports {buttonState[4]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {buttonState[4]}]
	
	##LEDS
	set_property PACKAGE_PIN U16 [get_ports {LEDstate[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {LEDstate[0]}]
    set_property PACKAGE_PIN P3 [get_ports {LEDstate[1]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {LEDstate[1]}]
    set_property PACKAGE_PIN N3 [get_ports {LEDstate[2]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {LEDstate[2]}]
    set_property PACKAGE_PIN P1 [get_ports {LEDstate[3]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {LEDstate[3]}]
    set_property PACKAGE_PIN L1 [get_ports {LEDstate[4]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {LEDstate[4]}]
#        set_property PACKAGE_PIN U14 [get_ports {en_Time[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {en_Time[0]}]
#set_property PACKAGE_PIN V14 [get_ports {en_Time[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {en_Time[1]}]

set_property PACKAGE_PIN W18 [get_ports {alarmSound}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {alarmSound}]


#set_property PACKAGE_PIN L1 [get_ports alarmSound]						
#	set_property IOSTANDARD LVCMOS33 [get_ports alarmSound]
	
	
	
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets <myHier/myNet>]

#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports {JC[0]}];#Sch name = JC1
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {JC[1]}];#Sch name = JC2