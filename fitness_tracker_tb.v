`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:22:43 AM
// Design Name: 
// Module Name: fitness_tracker_tb
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


module fitness_tracker_tb;
    reg pulseOut, RESET;
    wire [15:0] step_count;
    wire [15:0] dist;
    wire OFLOW;
    wire [15:0] pulse_count;
    
    fitbit_tracker dut (
        .pulseOut(pulseOut),
        .reset(RESET),
        .step_count(step_count),
        .dist(dist),
        .OFLOW(OFLOW),
        .pulse_count(pulse_count)
    );
    
    always #1 pulseOut = ~pulseOut;
    
    initial begin
        pulseOut = 0;
        RESET = 1;
        #10
        RESET = 0;
        
        #100
        
        RESET = 1;
        #200
        
        RESET = 0;
        #400
        
        $finish;
    end
endmodule
