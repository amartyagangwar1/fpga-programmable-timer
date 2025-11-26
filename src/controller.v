`timescale 1ns / 1ps

module controller(
    input clk,
    input reset,        
    input startstop,        
    input [1:0] mode,
    input at_zero,
    input at_max,       
       

    output reg count_enable,
    output reg up            //1 = count up, 0 = count down
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(*) begin   //count direction
        case(mode)
            2'b00: up = 1;
            2'b01: up = 0;
            2'b10: up = 1;
            2'b11: up = 0;
        endcase
   end
   
   always @(posedge clk or posedge reset) begin     //state transition
        if(reset)
            state <= 2'b00;
        else
            state <= next_state;
  end
  
  
  always @(*) begin
    next_state = state;
    
    case(state)
        2'b00: begin                 //init
            next_state = 2'b01;
        end 
        
        2'b01: begin                //idle
            if(startstop) begin     //if started go to run
                next_state = 2'b10;
            end
        end
        
        2'b10: begin                //run
            if (!up && at_zero) begin
                next_state = 2'b11;
            end
            if (up && at_max) begin
                next_state = 2'b11;
            end     
            if(startstop) begin
                next_state = 2'b11;  //pause
            end
        end            
               
         2'b11: begin
            if(startstop) begin
                next_state = 2'b10;
            end
          end
          
      
    endcase        
  end   
  
  
  always @(*) begin
    case(state)
        2'b00: count_enable = 0;
        2'b01: count_enable = 0;
        2'b10: count_enable = 1;
        2'b11: count_enable = 0;
    endcase
  end    
endmodule