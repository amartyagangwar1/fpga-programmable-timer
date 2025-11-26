`timescale 1ns / 1ps

module top(
    input clk,
    input reset,               // btnC
    input startstop,           // btnU 
    input [1:0] mode,          // SW0–SW1
    input [3:0] preset_ones,   // SW2–SW5
    input [3:0] preset_tens,   // SW6–SW9

    output [6:0] seg,          // seven-seg output
    output dp,
    output [3:0] an
    );
    
    
    //clock divider
    wire clk_10ms;
    clkdiv u_clkdiv(
        .clk(clk),
        .reset(reset),
        .clk_10ms(clk_10ms)
    );    
    
    //sync for buttons
    wire reset_sync;
    wire startstop_sync;
    
    ff_sync s1 (.clk(clk), .d(reset), .q(reset_sync));
    ff_sync s2 (.clk(clk), .d(startstop), .q(startstop_sync));
    
    
    //controller
    wire count_enable;
    wire up;
    wire at_zero = (ms_ones == 0 && ms_tens == 0 && sec_ones == 0 && sec_tens == 0);
    wire at_max = (ms_ones == 0 && ms_tens == 9 && sec_ones == 0 && sec_tens == 9);
    controller u_controller(
        .clk(clk),
        .reset(reset_sync),
        .startstop(startstop_sync),
        .mode(mode),
        .at_zero(at_zero),
        .at_max(at_max),
        .count_enable(count_enable),
        .up(up)
    );
    
        
    //datapath
    wire [3:0] ms_ones;
    wire [3:0] ms_tens;
    wire [3:0] sec_ones;
    wire [3:0] sec_tens;
    
     datapath u_datapath(
        .clk(clk),
        .reset(reset),
        .clk_10ms(clk_10ms),
        .count_enable(count_enable),
        .up(up),
        .mode(mode),
        .preset_ones(preset_ones),
        .preset_tens(preset_tens),
        .ms_ones(ms_ones),
        .ms_tens(ms_tens),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens)
    );


    //mux display
     wire [3:0] digit;

    display_mux u_mux(
        .clk(clk),
        .d0(ms_ones),
        .d1(ms_tens),
        .d2(sec_ones),
        .d3(sec_tens),
        .an(an),
        .digit(digit)
    );
    
    
    //bcd
    sevenseg u_sevenseg(
        .digit(digit),
        .seg(seg)
    );
    assign dp = 1'b1;
    
endmodule
