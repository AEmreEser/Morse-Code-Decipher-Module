`timescale 1ns / 1ps


/** Ahmet Emre Eser - 7/2/2023 */


module Clock_Divider(
    input [2:0] spec,
    input clk,
    input rst,
    output reg out
    );
    
    reg [27:0] divider;
    reg [27:0] count;
    
    always@(posedge clk or posedge rst) begin
      
        if (rst) begin
            divider <= 28'b1110_1110_0100_1011_0010_1000_0000;
            count <= 28'b0;
            out <= 0;
        end
        else if (clk) begin
            // ADJUST DIVIDER
            if (spec != divider) begin
                case (spec) // divider speeds : speed slows down as the spec number increases
                   
                    3'b111 : divider <= 28'b0000_0000_0000_0000_0000_0000_0001;
                    3'b110 : divider <= 28'b1000_1111_1110_1011_0010_1000_0000;
                    3'b101 : divider <= 28'b1000_1110_1110_1011_0010_1000_0000;
                    3'b100 : divider <= 28'b1000_1110_0110_1011_0010_1000_0000;
                    3'b011 : divider <= 28'b0100_1110_0100_1011_0010_1000_0000;
                    3'b010 : divider <= 28'b0100_1110_0000_1011_0010_1000_0000;
                    3'b001 : divider <= 28'b0100_1100_0000_1011_0010_1000_0000;
                    3'b000 : divider <= 28'b0100_1000_0000_1011_0010_1000_0000;
                    
                endcase
            end
            // NO NEED TO ADJUST DRIVER
            else begin                
                divider <= divider; 
            end
            
            
            
            
            // OUTPUT & COUNTER INCREMENT
            if (count >= divider) begin
                out <= !out;
                count <= 28'b0;
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
