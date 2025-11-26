`timescale 1ns / 1ps

module tb_top();

    reg clk;
    reg reset;
    reg startstop;
    reg [1:0] mode;
    reg [3:0] preset_ones;
    reg [3:0] preset_tens;

    wire [6:0] seg;
    wire dp;
    wire [3:0] an;

    // DUT
    top dut (
        .clk(clk),
        .reset(reset),
        .startstop(startstop),
        .mode(mode),
        .preset_ones(preset_ones),
        .preset_tens(preset_tens),
        .seg(seg),
        .dp(dp),
        .an(an)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        // Default states
        clk = 0;
        reset = 0;
        startstop = 0;
        mode = 2'b00;
        preset_ones = 0;
        preset_tens = 0;

        // TEST CASE 1: BASIC RESET, MODE 0 UP COUNT
        reset = 1;    #20;
        reset = 0;    #40;

        startstop = 1; #20;   // start
        startstop = 0; #2000; // run for a bit

        startstop = 1; #20;   // stop
        startstop = 0; #300;

        startstop = 1; #20;   // resume
        startstop = 0; #2000;

        // TEST CASE 2: SWITCH MODE WHILE RUNNING (Mode 1)
        mode = 2'b01; #40;    // should count down now

        reset = 1; #20;       // load 99.99
        reset = 0; #40;

        startstop = 1; #20;   // start counting down
        startstop = 0; #2000;

        // quick stop + start
        startstop = 1; #20;
        startstop = 0; #200;
        startstop = 1; #20;
        startstop = 0; #2000;

        // TEST CASE 3: MODE 2 — COUNT UP FROM PRESET (37 seconds)
        mode = 2'b10; #40;
        preset_tens = 4'd3;
        preset_ones = 4'd7;

        reset = 1; #20;       // load preset value
        reset = 0; #40;

        startstop = 1; #20;
        startstop = 0; #2000;

        // TEST CASE 4: MODE 3 — COUNT DOWN FROM PRESET (50 seconds)
        mode = 2'b11; #40;
        preset_tens = 4'd5;
        preset_ones = 4'd0;

        reset = 1; #20;
        reset = 0; #40;

        startstop = 1; #20;
        startstop = 0; #2000;

        // TEST CASE 5: RAPID BUTTON PRESS (debounce stress test)
        startstop = 1; #5;   // quick pulse
        startstop = 0; #5;
        startstop = 1; #5;
        startstop = 0; #50;  // settle

        // TEST CASE 6: MID-COUNT MODE SWITCHES
        mode = 2'b00; #200;
        mode = 2'b01; #200;
        mode = 2'b10; #200;
        mode = 2'b11; #200;

        #1000;
        $finish;
    end

endmodule
