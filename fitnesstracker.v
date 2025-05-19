`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/06/2025 08:50:27 PM
// Design Name:
// Module Name: fitbit_tracker
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


module fitbit_tracker(
    input pulseOut, reset,
    output reg [15:0] step_count,
    output [15:0] dist,
    output reg OFLOW
    //output reg [15:0] pulse_count
    );
   
    reg [15:0] pulse_count;
   
    always @(posedge pulseOut) begin
        if (reset) begin
            step_count <= 16'd0;
            pulse_count <= 16'd0;
            OFLOW <= 1'd0;
           
        end else begin
            pulse_count <= pulse_count + 1;
            if(pulse_count >= 14'd9999) begin
                step_count <= 14'd9999;
                OFLOW <= 1'd1;
            end else begin
                step_count <= pulse_count;
                OFLOW <= 1'd0;
            end
        end
    end
    
    assign dist = pulse_count[14:11] * 5;
    
endmodule
   
    /*always @(*) begin
        if (reset == 1) begin
            dist = 16'd0;
           
        end else begin
            if (16'd0 <= pulse_count && pulse_count < 16'd2048) begin
                dist = 16'd0; // dist = 0.0
            end else if (16'd2048 <= pulse_count && pulse_count < 16'd4096) begin
                dist = 16'd5; // dist = 0.5
            end else if (16'd4096 <= pulse_count && pulse_count < 16'd6144) begin
                dist = 16'd10; // dist = 1.0
            end else if (16'd6144 <= pulse_count && pulse_count < 16'd8192) begin
                dist = 16'd15; // dist = 1.5
            end else if (16'd8192 <= pulse_count && pulse_count < 16'd10240) begin
                dist = 16'd20; // dist = 2.0
            end else if (16'd10240 <= pulse_count && pulse_count < 16'd12288) begin
                dist = 16'd25; // dist = 2.5
            end else if (16'd12288 <= pulse_count && pulse_count < 16'd14336) begin
                dist = 16'd30; // dist = 3
            end else if (16'd14336 <= pulse_count && pulse_count < 16'd16384) begin
                dist = 16'd35; // dist = 3.5
            end else if (16'd16384 <= pulse_count && pulse_count < 16'd18342) begin
                dist = 16'd40; // dist = 4.0
            end else if (16'd18342 <= pulse_count && pulse_count < 16'd20480) begin
                dist = 16'd45; // dist = 4.5
            end else if (16'd20480 <= pulse_count && pulse_count < 16'd22528) begin
                dist = 16'd50; // dist = 5.0
            end else if (16'd22528 <= pulse_count && pulse_count < 16'd24576) begin
                dist = 16'd55; // dist = 5.5
            end else if (16'd24576 <= pulse_count && pulse_count < 16'd26624) begin
                dist = 16'd60; // dist = 6.0
            end else if (16'd26624 <= pulse_count && pulse_count < 16'd28672) begin
                dist = 16'd65; // dist = 6.5
            end else if (16'd28672 <= pulse_count && pulse_count < 16'd30720) begin
                dist = 16'd70; // dist = 7.0
            end else if (16'd30720 <= pulse_count && pulse_count < 16'd32768) begin
                dist = 16'd75; // dist = 7.5
            end else if (16'd32768 <= pulse_count && pulse_count < 16'd34816) begin
                dist = 16'd80; // dist = 8.0
            end else if (16'd34816 <= pulse_count && pulse_count < 16'd36864) begin
                dist = 16'd85; // dist = 8.5
            end else if (16'd36864 <= pulse_count && pulse_count < 16'd38912) begin
                dist = 16'd90; // dist = 9.0
            end else begin
                dist = 16'd95; // dist = 9.5
            end
        end
    end*/
