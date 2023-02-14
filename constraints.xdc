# set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { clk }];
# create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property -dict { PACKAGE_PIN W19  IOSTANDARD LVCMOS33 } [get_ports { clk }];

set_property -dict { PACKAGE_PIN V16  IOSTANDARD LVCMOS33 } [get_ports { noisy_in }];
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { rst }];
set_property -dict { PACKAGE_PIN W14  IOSTANDARD LVCMOS33 } [get_ports { spec[2] }];
set_property -dict { PACKAGE_PIN V15  IOSTANDARD LVCMOS33 } [get_ports { spec[1] }];
set_property -dict { PACKAGE_PIN W15  IOSTANDARD LVCMOS33 } [get_ports { spec[0] }];

set_property -dict { PACKAGE_PIN L1  IOSTANDARD LVCMOS33 } [get_ports { divided_clk_led }];
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { morse_primitive_input_received }];

set_property -dict { PACKAGE_PIN P1  IOSTANDARD LVCMOS33 } [get_ports { char_ready }];
set_property -dict { PACKAGE_PIN P3  IOSTANDARD LVCMOS33 } [get_ports { char_out[5] }];
set_property -dict { PACKAGE_PIN U3  IOSTANDARD LVCMOS33 } [get_ports { char_out[4] }];
set_property -dict { PACKAGE_PIN W3  IOSTANDARD LVCMOS33 } [get_ports { char_out[3] }];
set_property -dict { PACKAGE_PIN V3  IOSTANDARD LVCMOS33 } [get_ports { char_out[2] }];
set_property -dict { PACKAGE_PIN V13  IOSTANDARD LVCMOS33 } [get_ports { char_out[1] }];
set_property -dict { PACKAGE_PIN V14  IOSTANDARD LVCMOS33 } [get_ports { char_out[0] }];



#char out (6 bit) , char ready needed
