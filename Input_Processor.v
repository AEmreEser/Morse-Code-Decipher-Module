`timescale 1ns / 1ps

// Ahmet Emre Eser - 02/2023

module Input_Processor(
    output reg [1:0] out,
     /** 
     00 - dot
     01 - dash
     11 - short space
     */
    output reg out_ready, // acts like an enable signal that stops the processing of morse code in the next module (morse processor) - if 0 
    input rst,
    input clk,
    input serial_in // the signal coming from the debouncer
                    // 0 as a separator
    );
    
    
    reg [3:0] prev_inputs;
    
    task shByOne(input reg[3:0] shReg);

        begin
            shReg[1] <= shReg[0];        
            shReg[2] <= shReg[1];        
            shReg[3] <= shReg[2];
        end
    
    endtask
    
    
    
    always@(posedge clk or posedge rst) begin
    
    if (rst) begin
    
        prev_inputs <= 4'b0100; // second half == 100 since 000 would yield a "short space" return value from output port "out"
        out <= 2'b10;
        out_ready <= 0;
    
    end
    else if (clk) begin
    
        prev_inputs[1] <= prev_inputs[0];
        prev_inputs[2] <= prev_inputs[1];
        prev_inputs[3] <= prev_inputs[2];
    
        prev_inputs[0] <= serial_in;
    
//        if (prev_inputs[2:0] == 3'b000) begin
//            // short space
//            out_ready <= 1;
//            out <= 2'b10;       
        
//        end
//        else begin
            
            if (prev_inputs[0] == 0) begin
                
                
                if (prev_inputs[3:0] /* indexing to not create errors if I change register size */ == 4'b1110) begin
                    out <= 2'b01; // dash
                    out_ready <= 1;
                end
                else begin
                                        
                    case(prev_inputs[2:0]) 
                    
                        3'b100 : out_ready <= 0;
                        3'b010, 3'b110 : begin
                            out_ready <= 1;
                            out <= 00; // dot
                        end
                        3'b000 : begin
                            out_ready <= 1;
                            out <= 11; // short space
                        end
                                          
                    endcase
                                        
                end
                            
            end 
            else begin
            
                out_ready <= 0;
            
            end
        
        //end
        
        end
        else begin
            ;
        end
    
    
    end // always
    
    
endmodule
