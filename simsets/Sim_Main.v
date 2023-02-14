`timescale 1ns / 1ps



module Sim_Main();


reg clk, rst;
reg serial_in; // ideally: should be taken up as input after 3 divided clk pulses -- if I remember correctly
reg [2:0] spec;
wire char_ready;
wire [5:0] char_out;


Main UUT(
    .char_out(char_out),
    .char_ready(char_ready),
    .rst(rst),
    .clk(clk), 
    .noisy_in(serial_in),
    .spec(spec)
);

// two of these will generate one divided clk pulse --> at the 000 spec
task automatic genClkPeriod();
    
    begin

    clk <= 1;
    #5;
    clk <= 0;
    #5;
    clk <= 1;
    #5;
    clk <= 0;
    #5;
    clk <= 1;
    #5;
    clk <= 0;
    #5;
    clk <= 1;
    #5;
    clk <= 0;
    #5;
    clk <= 1;
    #5;
    clk <= 0;
    #5;
    clk <= 1;
    #5;
    clk <= 0;
    #5;
    
    end
    
endtask

initial begin


rst <= 0;
spec <= 3'b000;
serial_in <= 0;

genClkPeriod();

genClkPeriod();

rst <= 1;

genClkPeriod();


rst <= 0; 

genClkPeriod();

serial_in <= 1;

genClkPeriod();
genClkPeriod();

serial_in <= 0; // line 92 to here: dot

genClkPeriod();
genClkPeriod();
genClkPeriod();

serial_in <= 1;

genClkPeriod();
genClkPeriod();
genClkPeriod();

serial_in <= 0;

genClkPeriod();
genClkPeriod();
genClkPeriod();


genClkPeriod();
genClkPeriod();
genClkPeriod();


serial_in <= 0;

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();

genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();
genClkPeriod();


end



endmodule