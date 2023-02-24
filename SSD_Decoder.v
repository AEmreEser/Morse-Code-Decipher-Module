`timescale 1ns / 1ps


module SSD_Decoder(

    input clk, // will use the char_ready signal of the morse processor module to only update the display when a new character is ready
    input rst,
    input [5:0] char_code,
    output reg [31:0] char_seq
    
    );
    
    reg [7:0] newCharReg; // dp not included, DON'T FORGET TO INVERT THE CONTENTS WHEN SENDING OUT WITH CHAR_SEQ
    reg [5:0] oldCharCode; // holds the old value of newCharReg so that the display does not update itself at every clk pulse
    
    always@(posedge rst or posedge clk) begin
    
        if (rst) begin
            char_seq <= 32'b1111_1111_1111_1111_1111_1111_1111_1111;
            newCharReg <= 8'b0;
            oldCharCode <= 8'b1000_0000;
        end
        else if (clk && (oldCharCode != char_code) ) begin
            
            oldCharCode <= char_code;
            
            case (char_code)
            
                6'b000_001 : newCharReg <= 8'b0111_0111; // A
                6'b000_010 : newCharReg <= 8'b0111_1111; // B
                6'b000_011 : newCharReg <= 8'b0100_1110; // C
                6'b000_100 : newCharReg <= 8'b0111_1110; // D
                6'b000_101 : newCharReg <= 8'b0100_1111; // E
                6'b000_110 : newCharReg <= 8'b0100_0111; // F                
                6'b000_111 : newCharReg <= 8'b0101_1111; // G
                6'b001_000 : newCharReg <= 8'b0011_0111; // H
                6'b001_001 : newCharReg <= 8'b0011_0000; // I
                6'b001_010 : newCharReg <= 8'b0011_1100; // J
                6'b001_011 : newCharReg <= 8'b0101_0111; // K
                6'b001_100 : newCharReg <= 8'b0000_1110; // L
                6'b001_101 : newCharReg <= 8'b0011_0101; // M
                6'b001_110 : newCharReg <= 8'b0010_0101; // N
                6'b001_111 : newCharReg <= 8'b0111_1110; // O
                6'b010_000 : newCharReg <= 8'b0110_0111; // P
                6'b010_001 : newCharReg <= 8'b1111_1110; // Q
                6'b010_010 : newCharReg <= 8'b0110_1111; // R
                6'b010_011 : newCharReg <= 8'b0101_1011; // S
                6'b010_100 : newCharReg <= 8'b0000_1111; // T
                6'b010_101 : newCharReg <= 8'b0011_1110; // U 
                6'b010_110 : newCharReg <= 8'b0010_0111; // V
                6'b010_111 : newCharReg <= 8'b0011_1111; // W
                6'b011_000 : newCharReg <= 8'b0011_0110; // X
                6'b011_001 : newCharReg <= 8'b0011_0011; // Y
                6'b011_010 : newCharReg <= 8'b0110_1101; // Z
                6'b0 : newCharReg <= 8'b0; // default output: 0
                default : newCharReg <= 8'b0;
            
            endcase
            
            char_seq <= {char_seq[23:0], ~newCharReg};
            
        end
        else begin
            char_seq <= char_seq;        
        end
    
    
    end
    
    
endmodule
