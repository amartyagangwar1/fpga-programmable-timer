`timescale 1ns / 1ps

module digit_counter(
    input clk,
    input reset,
    input load,
    input [3:0] load_val,
    input enable,           //only begins when high
    input up,               //1 = count up, 0 = count down
    output reg[3:0] q,
    output reg ripple       //goes high when digit at 9 / 0 
    );
    
    always @(posedge clk) begin
        if(reset) begin
            if(load) begin
                q <= load_val;
            end else begin     
                q <= 0;
            end
            ripple <=0;
        end
        
        else if(enable) begin
            ripple <=0;
            
            if(up) begin    
                if(q==9) begin
                    q <= 0;
                    ripple <= 1;
                end else begin 
                    q <= q + 1;
                
                end
            end 
            
            else begin //count down   
                if(q==0) begin
                    q <= 9;
                    ripple <=1;
                end else begin
                    q <= q - 1;
                end
            end
         end
     end           
endmodule
