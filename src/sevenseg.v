`timescale 1ns / 1ps

module sevenseg(
    input  [3:0] digit,     // BCD digit 0-9
    output reg [6:0] seg    // {a,b,c,d,e,f,g}, ACTIVE LOW
);

    always @(*) begin
        case (digit)
            4'd0: seg = 7'b1000000; // 0
            4'd1: seg = 7'b1111001; // 1
            4'd2: seg = 7'b0100100; // 2
            4'd3: seg = 7'b0110000; // 3
            4'd4: seg = 7'b0011001; // 4
            4'd5: seg = 7'b0010010; // 5
            4'd6: seg = 7'b0000010; // 6
            4'd7: seg = 7'b1111000; // 7
            4'd8: seg = 7'b0000000; // 8
            4'd9: seg = 7'b0010000; // 9
            //over 9 set to 9
            4'd10: seg = 7'b0010000; // 9
            4'd11: seg = 7'b0010000; // 9
            4'd12: seg = 7'b0010000; // 9
            4'd13: seg = 7'b0010000; // 9
            4'd14: seg = 7'b0010000; // 9
            4'd15: seg = 7'b0010000; // 9         
            default: seg = 7'b1111111; // all off
        endcase
    end

endmodule
