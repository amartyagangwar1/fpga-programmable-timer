`timescale 1ns / 1ps

module display_mux(
    input clk,                   
    input [3:0] d0, d1, d2, d3,  
    output reg [3:0] an,         
    output reg [3:0] digit       
    );
    
    reg[1:0] sel = 0; //select which digit is on
    reg[15:0] count = 0; //create counter 
    
    always @(posedge clk) begin
        count <= count + 1;
        sel <= count[15:14];
    end
    
    always @(*) begin
        case(sel) 
             2'b00: begin
                    an = 4'b1110;   //AN0 ON 
                    digit = d0;     
                end
    
                2'b01: begin
                    an = 4'b1101;   // AN1 ON
                    digit = d1;
                end
    
                2'b10: begin
                    an = 4'b1011;   //AN2 ON
                    digit = d2;
                end
    
                2'b11: begin
                    an = 4'b0111;   //AN3 ON
                    digit = d3;
                end
            endcase
        end
    
endmodule
