`timescale 1ns / 1ps


module SSD_Control_Unit(
    input clk, // should not ideally be a divided clock - faster it is the smoother the visuals will be
    input rst,
    input [31:0] cathode_config_combined, // active low
    // active low
    output reg [7:0] cathode_out,
    output reg [3:0] anode_out    
    );
    
    reg [3:0] anode_turn_counter; // inverted one-hot encoding
    
    
    always@(posedge clk or posedge rst) begin
        
        if (rst) begin
        
            anode_turn_counter <= 4'b0111;
            // anode out adjusted after if else block                        
            cathode_out <= 8'b1;
            // update_display_counter <= 10'b0;
        
        end
        else if (clk ) begin // sys_clk pulse   // && update_display_counter >= 10'b0001101000                
        
            // update_display_counter <= 10'b0;
        
            // circular shift - anode  
            anode_turn_counter[3] <= anode_turn_counter[2];
            anode_turn_counter[2] <= anode_turn_counter[1];
            anode_turn_counter[1] <= anode_turn_counter[0];
            anode_turn_counter[0] <= anode_turn_counter[3];
                        
            case (anode_turn_counter)
            
                4'b0111 : cathode_out <= cathode_config_combined[31:24]; // first ssd
                4'b1011 : cathode_out <= cathode_config_combined[23:16]; // second ssd
                4'b1101 : cathode_out <= cathode_config_combined[15:8]; // third ssd
                4'b1110 : cathode_out <= cathode_config_combined[7:0]; // fourth ssd
            
            endcase
            
        
        end   
        else begin
            //update_display_counter <= update_display_counter + 1;
            cathode_out <= cathode_out;
            anode_out <= anode_out;
            anode_turn_counter <= anode_turn_counter;
        end
                
        anode_out <= anode_turn_counter; 
    
    end // always    
    
endmodule
