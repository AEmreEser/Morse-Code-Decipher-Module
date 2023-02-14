`timescale 1ns / 1ps


/** Ahmet Emre Eser - 7/2/2023 */


/** 

IMPORTANT: NOTE FOR MYSELF: DEVELOPMENT PHASE:

Test this module, no tests have been conducted yet
Calculate the actual counter periods for 100mhz * 3 --> * 3 as the debouncer will require 3 clk inputs per press

*/


module Clock_Divider(
    input [2:0] spec,
    input clk,
    input rst,
    output reg out
    );
    
    reg [7:0] divider;
    reg [7:0] count;
    
    always@(posedge clk or posedge rst) begin
      
        if (rst) begin
            divider <= 8'b1111000;
            count <= 8'b0;
            out <= 0;
        end
        else if (clk) begin
            // ADJUST DIVIDER
            if (spec != divider) begin
                case (spec) // divider speeds : speed slows down as the spec number increases
                   
                    3'b111 : divider <= 8'b11111111;
                    3'b110 : divider <= 8'b11111100;
                    3'b101 : divider <= 8'b11110000;
                    3'b100 : divider <= 8'b11000000;
                    3'b011 : divider <= 8'b00111111;
                    3'b010 : divider <= 8'b00111100;
                    3'b001 : divider <= 8'b00110000;
                    3'b000 : divider <= 8'b0000_0001; /** LOWERED FOR DEBUGGING PURPOSES */
                    
                endcase
            end
            // NO NEED TO ADJUST DRIVER
            else begin                
                divider <= divider; 
            end
            
            
            
            
            // OUTPUT & COUNTER INCREMENT
            if (count >= divider) begin
                out <= !out;
                count <= 8'b0;
            end
            else begin
                count <= count + 1;
                out <= out;
            end
            
            
            
        end // else if (clk)
        else begin
            divider <= divider;
            count <= count;
        end
        
        
    end // always@ block
    
endmodule
