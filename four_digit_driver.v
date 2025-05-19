`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/07/2025 08:29:31 PM
// Design Name:
// Module Name: display_driver
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module bcd_1digit(
    input [3:0] bcd,
    output reg [7:1] seven
    );
   
    always @(bcd) begin
        case (bcd)
            0: seven = 7'b1000000;
            1: seven = 7'b1111001;
            2: seven = 7'b0100100;
            3: seven = 7'b0110000;
            4: seven = 7'b0011001;
            5: seven = 7'b0010010;
            6: seven = 7'b0000010;
            7: seven = 7'b1111000;
            8: seven = 7'b0000000;
            9: seven = 7'b0011000;
            10: seven = 7'b1110111;
            default: seven = 7'b1111111;
        endcase
    end
endmodule

module bcd_4digit(
    input clk, reset, dot,
    input [15:0] bcd,
    output [7:1] C,
    output reg DP,
    output reg [3:0] AN
);
    reg [16:0] counter;
    reg [3:0] select_bcd;
    reg [1:0] counter2;
   
    bcd_1digit bd (
        .bcd(select_bcd),
        .seven(C)
    );
   
    always @(posedge clk) begin
        if (reset) begin
            counter <= 17'd0;
            counter2 <= 2'd0;
       
        end else begin
            if (counter <= 17'd100000) begin
                counter <= counter + 1;
            end else begin
                counter <= 17'd0;
                if (counter2 < 2'd3) begin
                    counter2 <= counter2 + 1;
                end else begin
                    counter2 <= 2'd0;
                end
            end
        end
    end
   
    always @(*) begin
    
        case (counter2)
            2'd0: begin
                AN = 8'b11111110;
                select_bcd = bcd[3:0];
                DP = 1;
                end
            2'd1: begin
                AN = 8'b11111101;
                select_bcd = bcd[7:4];
                DP = ~dot;
                end
            2'd2: begin
                AN = 8'b11111011;
                select_bcd = bcd[11:8];
                DP = 1;
                end
            2'd3: begin
                AN = 8'b11110111;
                select_bcd = bcd[15:12];
                DP = 1;
                end
            default: begin
                AN = 8'b1111_1111;
                select_bcd = 4'd0;
                DP = 1;
                end
        endcase
    end
   
endmodule
