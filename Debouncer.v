`timescale 1ns / 1ps

/** Ahmet Emre Eser - 7/2/2023 */

module Debouncer(
        input noisy_in,
        input clk,
        input rst,
        output reg out
    );
    
    /**
    
    IMPORTANT: NOTE FOR MYSELF: DEVELOPMENT PHASE:
    Adjust clk period accordingly in the divider module!
    
    */
    

reg [2:0] prev_in; // third signal will send the out signal
    
always@(posedge rst or posedge clk) begin

        if (rst) begin
        
            prev_in <= 3'b0;
            out <= 0;
            
        end
        else if (clk) begin
      
            prev_in[2] <= prev_in[1];
            prev_in[1] <= prev_in[0];
            prev_in[0] <= noisy_in;   
      
            if (prev_in[2] == prev_in[1] && prev_in[1] == prev_in[0]) begin                
                out <= prev_in[2];
            end
            else begin
                out <= out;
            end
      
         end  
         else begin
            prev_in <= prev_in;
            out <= out;
         end
      
  end
    
endmodule
