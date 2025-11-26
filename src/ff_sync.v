`timescale 1ns / 1ps

module ff_sync(
    input clk,
    input d,
    output q
);
    reg r1, r2;
    always @(posedge clk) begin
        r1 <= d;
        r2 <= r1;
    end
    assign q = r2;
endmodule

