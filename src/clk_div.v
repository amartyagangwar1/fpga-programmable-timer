`timescale 1ns / 1ps

module clkdiv(
    input clk,
    input reset,
    output reg clk_10ms
);

    reg [19:0] count; 

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            clk_10ms <= 0;
        end 
        else if (count == 999_999) begin   //10ms of cycles
            count <= 0;
            clk_10ms <= 1;                
        end 
        else begin
            count <= count + 1;
            clk_10ms <= 0;               
        end
    end

endmodule