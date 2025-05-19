`timescale 1ns / 1ps

module tb_rotation_module;

    reg clk;
    reg rst;
    reg [15:0] bcd_step_count;
    reg [15:0] bcd_distance;
    reg [3:0]  bcd_mode;
    wire [15:0] display_bcd;
    wire dp;

  
    rotation_module uut (
        .clk100Mhz(clk),
        .rst(rst),
        .bcd_step_count(bcd_step_count),
        .bcd_distance(bcd_distance),
        .bcd_mode(bcd_mode),
        .display_bcd(display_bcd),
        .dp(dp)
    );


    always #5 clk = ~clk;

   
    initial begin
 
        clk = 0;
        rst = 1;
        bcd_step_count = 16'h1234;   // Step count = 1234
        bcd_distance = 16'h0567;     // Distance = 5.67
        bcd_mode = 4'h3;             // Mode = 3

        #20 rst = 0; // Release reset after 20 ns

      
        #500;

        $stop;
    end

endmodule
