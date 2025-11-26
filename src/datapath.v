`timescale 1ns / 1ps

module datapath(
    input clk,
    input reset,
    input clk_10ms,          
    input count_enable,      // from controller
    input up,                // from controller (direction)
    input [1:0] mode,
    input [3:0] preset_tens,
    input [3:0] preset_ones,

    output [3:0] ms_ones,
    output [3:0] ms_tens,
    output [3:0] sec_ones,
    output [3:0] sec_tens
    );
    
    reg [3:0] L_ms1, L_ms10, L_s1, L_s10;   //Load vals

    always @(*) begin
        case (mode)
            2'b00: begin   //Mode 0: up from 00.00
                L_ms1  = 0;
                L_ms10 = 0;
                L_s1   = 0;
                L_s10  = 0;
            end

            2'b01: begin   //Mode 1: down from 99.99
                L_ms1  = 9;
                L_ms10 = 9;
                L_s1   = 9;
                L_s10  = 9;
            end

            2'b10: begin   //Mode 2: up from preset seconds
                L_ms1  = 0;
                L_ms10 = 0;
                L_s1   = preset_ones;
                L_s10  = preset_tens;
            end

            2'b11: begin   //Mode 3: down from preset seconds
                L_ms1  = 0;
                L_ms10 = 0;
                L_s1   = preset_ones;
                L_s10  = preset_tens;
            end
        endcase
    end
    
    wire r0, r1, r2; //ripple from each digit

    wire en_ms_ones = clk_10ms & count_enable;  //00.0x
    wire en_ms_tens = r0 & en_ms_ones;
    wire en_sec_ones = r1 & en_ms_tens;
    wire en_sec_tens = r2 & en_sec_ones;        //x0.00
    
    // ms ones
    digit_counter d0 (
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .load_val(L_ms1),
        .enable(en_ms_ones),
        .up(up),
        .q(ms_ones),
        .ripple(r0)
    );

    // ms tens
    digit_counter d1 (
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .load_val(L_ms10),
        .enable(en_ms_tens),
        .up(up),
        .q(ms_tens),
        .ripple(r1)
    );

    // sec ones
    digit_counter d2 (
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .load_val(L_s1),
        .enable(en_sec_ones),
        .up(up),
        .q(sec_ones),
        .ripple(r2)
    );

    // sec tens
    digit_counter d3 (
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .load_val(L_s10),
        .enable(en_sec_tens),
        .up(up),
        .q(sec_tens),
        .ripple()    //ignore ripple cuz doesnt matter for others
    );
    
    
endmodule
