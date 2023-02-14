`timescale 1ns / 1ps



module Morse_Processor(

input [1:0] serial_in,
input update, // determines when the coming input will be processed and sent out
         // should use out_ready output of the input processor module
input rst,
input clk,
output reg [5:0] char_out, // number of characters needed (with/ without punctuation) = [36, 52] => 6 bits necessary
output reg char_ready
    );
    
    
    reg [13:0] morse_sequence;
    
    reg char_ready_lit_once;
    
     /** 
         00 - dot
         01 - dash
         11 - short space
     */
    
    always@(posedge clk or posedge rst) begin
    
        if (rst) begin
        
            morse_sequence <= 14'b0000_0000_0000_11;
            char_out <= 6'b0;
            char_ready_lit_once <= 0;
            char_ready <= 0;
        
        end
        else if (clk) begin
        
            if (update) begin
            
                morse_sequence[13:12] <= morse_sequence[11:10];
                morse_sequence[11:10] <= morse_sequence[9:8];
                morse_sequence[9:8] <= morse_sequence[7:6];
                morse_sequence[7:6] <= morse_sequence[5:4];
                morse_sequence[5:4] <= morse_sequence[3:2];
                morse_sequence[3:2] <= morse_sequence[1:0];           
                morse_sequence[1:0] <= serial_in; // record the newest entry
                
                char_ready_lit_once <= 0;
            
            end               
            else begin // else update
                    ;
            end
            
            if (morse_sequence[1:0] == 2'b11) begin // short space is the delimiting character for a sequence of morse primitives (dash / dot) which make up a letter
            
                casex (morse_sequence[13:2]) // last two bits will contain the delimiting character --> no need to do extra checks here
                
                    12'b????_??11_0001 : char_out <= 6'b000_001; // A
                    12'b??11_0100_0000 : char_out <= 6'b000_010; // B
                    12'b??11_0100_0100 : char_out <= 6'b000_011; // C
                    12'b????_1101_0000 : char_out <= 6'b000_100; // D
                    12'b????_????_1100 : char_out <= 6'b000_101; // E
                    12'b??11_0000_0100 : char_out <= 6'b000_110; // F                    
                    12'b????_1101_0100 : char_out <= 6'b000_111; // G
                    12'b??11_0000_0000 : char_out <= 6'b001_000; // H
                    12'b????_??11_0000 : char_out <= 6'b001_001; // I
                    12'b??11_0001_0101 : char_out <= 6'b001_010; // J
                    12'b????_1101_0001 : char_out <= 6'b001_011; // K
                    12'b??11_0001_0000 : char_out <= 6'b001_100; // L
                    12'b????_??11_0101 : char_out <= 6'b001_101; // M
                    12'b????_??11_0100 : char_out <= 6'b001_110; // N
                    12'b????_1101_0101 : char_out <= 6'b001_111; // O
                    12'b??11_0001_0100 : char_out <= 6'b010_000; // P
                    12'b??11_0101_0001 : char_out <= 6'b010_001; // Q
                    12'b????_1100_0100 : char_out <= 6'b010_010; // R
                    12'b????_1100_0000 : char_out <= 6'b010_011; // S
                    12'b????_????_1101 : char_out <= 6'b010_100; // T
                    12'b????_1100_0001 : char_out <= 6'b010_101; // U
                    12'b??11_0000_0001 : char_out <= 6'b010_110; // V
                    12'b????_1100_0101 : char_out <= 6'b010_111; // W
                    12'b??11_0100_0001 : char_out <= 6'b011_000; // X
                    12'b??11_0101_0001 : char_out <= 6'b011_001; // Y
                    12'b??11_0101_0000 : char_out <= 6'b011_010; // Z
                    default : char_out <= 6'b0; // default output: 0
                    
                endcase
            
                if (~char_ready_lit_once) begin
                    char_ready <= 1;
                    char_ready_lit_once <= 1;
                end
                else begin
                    char_ready <= 0;
                end
                /** SOLVED!:::ERROR HERE!!! --> FIND A WAY TO MAKE SURE THAT CHAR_READY IS DRIVEN HIGH ONLY ONCE PER NEW MEANINGFUL VALUE AT THE STORAGE 
                                        AND FOR ONE CLK CYCLE ONLY!!!
                                        
                                        IF WE DON'T IMPLEMENT THIS: WE'LL HAVE TO MODIFY THE DEFAULT CASE UNDER THE SWITCH STATEMENT ABOVE TO DRIVE CHAR_READY LOW 
                                            --> THEN HOW WILL THE SSD DEC MODULE KNOW THAT IT IS ON WAIT
                                                --> NOT IMPLEMENTING THIS WILL RESULT IN MORE ELEABORATE CODE!!!                                        
                */
            
            
            end
            else begin // else last two digits check
            
                char_out <= char_out;
                char_ready <= 0;
            
            end
            
        
        end 
        else begin // else (rst)
            ;
        end
    
    
    
    end
    
    
    
endmodule
