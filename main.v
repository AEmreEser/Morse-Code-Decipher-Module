`timescale 1ns / 1ps

module Main(

input clk,
input rst,
input noisy_in,
input [2:0] spec,
output morse_primitive_input_received,
output [5:0] char_out,
output char_ready,
output divided_clk_led
    );
    
    wire out_clk_div, out_Debouncer, out_ready;
    wire [1:0] processed_input_out;
    
    Clock_Divider divider(
        .rst(rst),
        .clk(clk),
        .spec(spec),
        .out(out_clk_div)
    );
    
    assign divided_clk_led = out_clk_div;
    
    Debouncer debouncer(
    
        .clk(clk),
        .rst(rst),
        .noisy_in(noisy_in),
        .out(out_Debouncer)
    );
    
    
    Input_Processor in_processor(
    
        .clk(out_clk_div),
        .rst(rst),
        .serial_in(out_Debouncer),
        .out_ready(out_ready),
        .out(processed_input_out)  
    
    );
    
    assign morse_primitive_input_received = out_ready;
    
    Morse_Processor morse_processor(
    
        .clk(out_clk_div),
        .rst(rst),
        .update(out_ready),
        .serial_in(processed_input_out),
        .char_out(char_out),
        .char_ready(char_ready)    
    );
    
    
    
endmodule
