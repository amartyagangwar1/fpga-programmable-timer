# Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


# SWITCHES
# mode[0] = SW0 = V17
set_property PACKAGE_PIN V17 [get_ports {mode[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mode[0]}]
# mode[1] = SW1 = V16
set_property PACKAGE_PIN V16 [get_ports {mode[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mode[1]}]
# preset_ones[0] = SW2 = W16
set_property PACKAGE_PIN W16 [get_ports {preset_ones[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_ones[0]}]
# preset_ones[1] = SW3 = W17
set_property PACKAGE_PIN W17 [get_ports {preset_ones[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_ones[1]}]
# preset_ones[2] = SW4 = W15
set_property PACKAGE_PIN W15 [get_ports {preset_ones[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_ones[2]}]
# preset_ones[3] = SW5 = V15
set_property PACKAGE_PIN V15 [get_ports {preset_ones[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_ones[3]}]
# preset_tens[0] = SW6 = W14
set_property PACKAGE_PIN W14 [get_ports {preset_tens[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_tens[0]}]
# preset_tens[1] = SW7 = W13
set_property PACKAGE_PIN W13 [get_ports {preset_tens[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_tens[1]}]
# preset_tens[2] = SW8 = V2
set_property PACKAGE_PIN V2 [get_ports {preset_tens[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_tens[2]}]
# preset_tens[3] = SW9 = T3
set_property PACKAGE_PIN T3 [get_ports {preset_tens[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {preset_tens[3]}]


# 7-SEGMENT DISPLAY 
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property PACKAGE_PIN V7 [get_ports dp]
    set_property IOSTANDARD LVCMOS33 [get_ports dp]
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


# BUTTONS 
# reset = btnC = U18
set_property PACKAGE_PIN U18 [get_ports reset]
    set_property IOSTANDARD LVCMOS33 [get_ports reset]
# startstop = btnU = T18  
set_property PACKAGE_PIN T18 [get_ports startstop]
    set_property IOSTANDARD LVCMOS33 [get_ports startstop]
