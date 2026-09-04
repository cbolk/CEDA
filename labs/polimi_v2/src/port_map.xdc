###this command is needed to generate timing reports after implementation
create_clock -period 10.000 -name clk [get_ports clk]

### XDC file for Digilent Nexys 4
# ---------------------------------------------------------------------------
# Clock signal (100 MHz)
# ---------------------------------------------------------------------------
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# ---------------------------------------------------------------------------
# Inputs: Reset and Start/Stop
# ---------------------------------------------------------------------------
# rst: Mapped on upper button BTNU 
set_property PACKAGE_PIN F15 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# i_start_stop: Mapped on central button BTNC
set_property PACKAGE_PIN E16 [get_ports i_start_stop]
set_property IOSTANDARD LVCMOS33 [get_ports i_start_stop]

# ---------------------------------------------------------------------------
# Outputs: LED
# ---------------------------------------------------------------------------
# o_led: Mapped on LED0
set_property PACKAGE_PIN T8 [get_ports o_led]
set_property IOSTANDARD LVCMOS33 [get_ports o_led]

# ---------------------------------------------------------------------------
# 7-Segment Display: Anodes 
# ---------------------------------------------------------------------------
set_property PACKAGE_PIN N6 [get_ports {anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]
set_property PACKAGE_PIN M6 [get_ports {anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
set_property PACKAGE_PIN M3 [get_ports {anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
set_property PACKAGE_PIN N5 [get_ports {anode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]
set_property PACKAGE_PIN N2 [get_ports {anode[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[4]}]
set_property PACKAGE_PIN N4 [get_ports {anode[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[5]}]
set_property PACKAGE_PIN L1 [get_ports {anode[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[6]}]
set_property PACKAGE_PIN M1 [get_ports {anode[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[7]}]

# ---------------------------------------------------------------------------
# 7-Segment Display: Segments
# ---------------------------------------------------------------------------
set_property PACKAGE_PIN L3 [get_ports {display[6]}]  
# CA
set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}]
set_property PACKAGE_PIN N1 [get_ports {display[5]}]  
# CB
set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}]
set_property PACKAGE_PIN L5 [get_ports {display[4]}]  
# CC
set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}]
set_property PACKAGE_PIN L4 [get_ports {display[3]}]  
# CD
set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}]
set_property PACKAGE_PIN K3 [get_ports {display[2]}]  
# CE
set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}]
set_property PACKAGE_PIN M2 [get_ports {display[1]}]  
# CF
set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}]
set_property PACKAGE_PIN L6 [get_ports {display[0]}]  
# CG
set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}]
